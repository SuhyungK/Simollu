package com.example.elasticsearch.repository.elkAdvance;

import com.example.elasticsearch.model.document.RestaurantDocument;
import com.example.elasticsearch.model.document.SearchDocument2;
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
    public List<RestaurantDocument> findByDescription(String des, String cx, String cy, Pageable pageable) {
        // ElasticsearchTemplate을 사용하여 검색 쿼리 생성
        Query searchQuery = new NativeSearchQueryBuilder()
                .withQuery(QueryBuilders.multiMatchQuery(des, "restaurantName", "restaurantCategory", "restaurantAddress"))
                .build();

        // ElasticsearchTemplate으로 검색 실행
        SearchHits<RestaurantDocument> searchHits = elasticsearchRestTemplate.search(searchQuery, RestaurantDocument.class);

        // 검색 결과를 리스트로 반환
        return searchHits.stream().map(SearchHit::getContent).collect(Collectors.toList());
    }
    public List<SearchDocument2> findTopSearchKeywords(int topN) {
        AggregationBuilder aggregationBuilder = AggregationBuilders.terms("top_keywords")
                .field("searchWord.keyword")
                .size(topN)
                .order(BucketOrder.count(false));

        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.aggregation(aggregationBuilder);

        SearchRequest searchRequest = new SearchRequest("search");
        searchRequest.source(searchSourceBuilder);

        try {
            SearchResponse searchResponse = restHighLevelClient.search(searchRequest, RequestOptions.DEFAULT);
            Terms terms = searchResponse.getAggregations().get("top_keywords");
            return terms.getBuckets().stream()
                    .map(bucket -> new SearchDocument2(null, bucket.getKeyAsString()))
                    .collect(Collectors.toList());
        } catch (IOException e) {
            throw new RuntimeException("Error occurred while fetching top search keywords.", e);
        }
    }

}

