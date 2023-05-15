package com.example.elasticsearch.model.service;

import com.example.elasticsearch.aws.AwsS3Repository;
import com.example.elasticsearch.model.document.RestaurantDocument;
import com.example.elasticsearch.model.document.SearchDocument2;
import com.example.elasticsearch.model.dto.search.SearchHistoryResponse;
import com.example.elasticsearch.model.dto.search.SearchRankResponse;
import com.example.elasticsearch.model.entity.Search;
import com.example.elasticsearch.model.document.SearchDocument;
import com.example.elasticsearch.repository.elkAdvance.SearchElasticAdvanceRepository;
import com.example.elasticsearch.repository.jpa.SearchJpaRepository;
import com.example.elasticsearch.repository.elkBasic.SearchElasticBasicRepository;
import com.example.elasticsearch.model.dto.restaurant.RestaurantListResponse;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class SearchService {

    private final SearchJpaRepository searchRepository;
    private final SearchElasticBasicRepository searchElasticBasicRepository;
    private final SearchElasticAdvanceRepository searchElasticAdvanceRepository;
    private final AwsS3Repository awsS3Repository;
    private final RedisTemplate redisTemplate;

    /*elk 검색*/
    public List<RestaurantListResponse> findByContainsDescription(String description, String lon, String lat, Pageable pageable) {
        // elk에서 목록을 가져옴
        List<RestaurantDocument> restaurants = searchElasticAdvanceRepository.findByDescription(description, lon, lat, pageable);
        List<RestaurantListResponse> restaurantResponses = new ArrayList<>();
        for (RestaurantDocument restaurant : restaurants) {
            RestaurantListResponse restaurantListResponse = RestaurantListResponse.builder()
                    .restaurantSeq(restaurant.getRestaurantSeq())
                    .restaurantX(restaurant.getRestaurantX())
                    .restaurantY(restaurant.getRestaurantY())
                    .restaurantImg(awsS3Repository.getTemporaryUrl(restaurant.getRestaurantImg()))
                    .restaurantName(restaurant.getRestaurantName())
                    .restaurantRating(calculateRating(restaurant.getRestaurantSeq()))
                    .distance(calculateDistance(Double.parseDouble(lat),Double.parseDouble(lon),Double.parseDouble(restaurant.getRestaurantY()), Double.parseDouble(restaurant.getRestaurantX())))
                    .build();
            restaurantResponses.add(restaurantListResponse);
        }
        return restaurantResponses;
    }


    public List<SearchRankResponse> getTopSearchKeywords(int topN) {
        List<SearchDocument2> SearchDocumentList =  searchElasticAdvanceRepository.findTopSearchKeywords(topN);
        List<SearchRankResponse> searchRankResponses = new ArrayList<>();
        int n=1;
        for (SearchDocument2 searchDocument : SearchDocumentList) {
            SearchRankResponse s = SearchRankResponse.builder()
                    .searchRank(n++)
                    .searchWord(searchDocument.getSearchWord())
                    .build();
            searchRankResponses.add(s);
        }

        return searchRankResponses;
    }

    /*RDB에 검색한 데이터 저장*/
    public void saveSearch(String description) {
        Search searchSaveRequest = new Search();
        long currentTimeMillis = System.currentTimeMillis();
        searchSaveRequest.setSearchRegistDate(currentTimeMillis);
        searchSaveRequest.setSearchWord(description);
        searchRepository.save(searchSaveRequest);
    }

    /**/
    public void saveAllSearchDocuments() throws IOException {
        List<SearchDocument> searchDocumentList = new ArrayList<>();
        List<Search> searchList = searchRepository.findAll();
        for (Search search : searchList) {
            SearchDocument document = SearchDocument.from(search);
            searchDocumentList.add(document);
        }
        searchElasticBasicRepository.saveAll(searchDocumentList);
    }


    public static double calculateDistance(double startLat, double startLng, double endLat, double endLng) {
        double earthRadiusKm = 6371.0;
        double dLat = Math.toRadians(endLat - startLat);
        double dLng = Math.toRadians(endLng - startLng);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(Math.toRadians(startLat)) * Math.cos(Math.toRadians(endLat)) * Math.sin(dLng / 2) * Math.sin(dLng / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distanceInKm = earthRadiusKm * c;

        // 반올림하여 소수점 둘째 자리까지 표시
        DecimalFormat df = new DecimalFormat("#.##");
        String formattedDistance = df.format(distanceInKm);
        double roundedDistance = Double.parseDouble(formattedDistance) +0.2;
        return roundedDistance;
    }

    public List<SearchHistoryResponse> SearchHistory() {
        int n = 1;
        List<SearchHistoryResponse> searchHistoryListResponse = new ArrayList<>();
        List<String> dataList = redisTemplate.opsForList().range("Ranking", 0, -1);
        for(String data : dataList) {
            SearchHistoryResponse searchHistoryResponse = SearchHistoryResponse.builder()
                    .order(n++)
                    .keyword(data)
                    .build();
            searchHistoryListResponse.add(searchHistoryResponse);
        }
        return searchHistoryListResponse;
    }

    public int calculateRating(Long restaurantSeq) {
        Integer f = (Integer) redisTemplate.opsForHash().get("review", restaurantSeq+"_false");
        Integer t = (Integer) redisTemplate.opsForHash().get("review", restaurantSeq+"_true");
        int percentage = 0;
        if (t != 0) {
            System.out.println();
            double ratio = (double) t / (t + f);
            percentage = (int) (ratio * 100);
        }
        return percentage;
    }
}
