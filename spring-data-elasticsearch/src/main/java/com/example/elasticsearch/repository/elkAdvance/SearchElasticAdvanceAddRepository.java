package com.example.elasticsearch.repository.elkAdvance;

import com.example.elasticsearch.model.document.RestaurantDocument;
import com.example.elasticsearch.model.document.SearchDocument;
import com.example.elasticsearch.model.dto.SearchListResponse;
import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.search.aggregations.AggregationBuilder;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.BucketOrder;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.SearchHit;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.data.elasticsearch.core.query.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.stream.Collectors;
import org.elasticsearch.index.query.QueryBuilders;

@Repository
@RequiredArgsConstructor
public class SearchElasticAdvanceRepository {
    private final RestHighLevelClient restHighLevelClient;
    private final ElasticsearchRestTemplate elasticsearchRestTemplate;
    public Void findByDescription(String des, Pageable pageable) {
        if (des == null || des.isEmpty()) {
            throw new IllegalArgumentException("Description cannot be null or empty.");
        }

        // Synonym 사전 정의
        String synonymDict = "pho => vietnamese noodle soup, bun cha => grilled pork with vermicelli noodles, banh mi => vietnamese sandwich";

        // ElasticsearchTemplate을 사용하여 검색 쿼리 생성
        Query searchQuery = new NativeSearchQueryBuilder()
                .withQuery(QueryBuilders.multiMatchQuery(des, "restaurantName", "restaurantCategory", "restaurantAddress"))
                .build();

        // Synonym Filter 추가
        AnalyzeRequestBuilder requestBuilder = new AnalyzeRequestBuilder(elasticsearchRestTemplate.getClient(), AnalyzeAction.INSTANCE, null, des)
                .setAnalyzer("synonym")
                .addTokenFilter("lowercase");

        SynonymTokenFilterFactory synonymTokenFilterFactory = new SynonymTokenFilterFactory(new HashMap<>());
        AnalyzerProvider<CustomAnalyzer> analyzerProvider = (fieldName, indexSettings) -> new CustomAnalyzer(synonymTokenFilterFactory);

        Map<String, AnalyzerProvider<CustomAnalyzer>> analyzerMap = new HashMap<>();
        analyzerMap.put("synonym", analyzerProvider);

        Settings indexSettings = Settings.builder()
                .put("index.analysis.filter.synonym.synonyms", synonymDict)
                .put("index.analysis.analyzer.synonym.tokenizer", "standard")
                .put("index.analysis.analyzer.synonym.filter", new String[]{"synonym", "lowercase"})
                .build();

        try {
            TokenizerFactory tokenizerFactory = TokenizerFactoryRegistry.getTokenizer("standard");
            Analyzer analyzer = new CustomAnalyzer(tokenizerFactory, analyzerMap, indexSettings);

            AnalyzeResponse response = requestBuilder.execute().actionGet();
            List<String> synonymTokens = new ArrayList<>();

            for (AnalyzeResponse.AnalyzeToken token : response.getTokens()) {
                String term = token.getTerm();
                if (!term.isEmpty()) {
                    synonymTokens.add(term);
                }
            }

            if (!synonymTokens.isEmpty()) {
                String[] synonymTokenArray = synonymTokens.toArray(new String[synonymTokens.size()]);
                searchQuery = new NativeSearchQueryBuilder()
                        .withQuery(QueryBuilders.multiMatchQuery(synonymTokenArray, "restaurantName", "restaurantCategory", "restaurantAddress"))
                        .build();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // RestHighLevelClient를 사용하여 검색 실행
        SearchHits<RestaurantDocument> searchHits = null;
    }
}

