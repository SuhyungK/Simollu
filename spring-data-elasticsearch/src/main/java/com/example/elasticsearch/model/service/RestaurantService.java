package com.example.elasticsearch.model.service;

import com.example.elasticsearch.aws.AwsS3Repository;
import com.example.elasticsearch.model.dto.main.RestaurantMainInfoListResponse;
import com.example.elasticsearch.model.dto.menu.MenuInfoResponse;
import com.example.elasticsearch.model.dto.restaurant.RestaurantInfoResponse;
import com.example.elasticsearch.model.dto.main.RestaurantMainInfoResponse;
import com.example.elasticsearch.model.dto.restaurant.WaitingTimeResponse;
import com.example.elasticsearch.model.dto.search.SearchInfoResponse;
import com.example.elasticsearch.model.entity.Menu;
import com.example.elasticsearch.model.entity.Restaurant;
import com.example.elasticsearch.model.document.RestaurantDocument;
import com.example.elasticsearch.repository.elkAdvance.SearchElasticAdvanceRepository;
import com.example.elasticsearch.repository.jpa.MenuJpaRepository;
import com.example.elasticsearch.repository.jpa.RestaurantJpaRepository;
import com.example.elasticsearch.repository.elkBasic.RestaurantElasticBasicRepository;
import com.example.elasticsearch.repository.review.ReviewRepository;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class RestaurantService {

    private final RestaurantJpaRepository restaurantJpaRepository;
    private final MenuJpaRepository menuJpaRepository;
    private final RestaurantElasticBasicRepository restaurantElasticBasicRepository;
    private final RedisTemplate redisTemplate;
    private final SearchElasticAdvanceRepository searchElasticAdvanceRepository;
    private final AwsS3Repository awsS3Repository;

    @Transactional
    public void saveAllRestaurantDocuments() throws IOException {
        List<RestaurantDocument> restaurantDocumentList = new ArrayList<>();
        List<Restaurant> restaurantList = restaurantJpaRepository.findAll();
        for (Restaurant restaurant : restaurantList) {
            RestaurantDocument document = RestaurantDocument.from(restaurant);
            restaurantDocumentList.add(document);
        }
        restaurantElasticBasicRepository.saveAll(restaurantDocumentList);
    }


    public SearchInfoResponse getSearchInfo(long restaurantSeq) {

        SearchInfoResponse searchInfoResponse = SearchInfoResponse.builder()
                .restaurantInfo(getRestaurantInfo(restaurantSeq))
                .menuInfoList(getMenuInfo(restaurantSeq))
//                .reviewInfoList(getReviewInfo(restaurantSeq))
                .waitingTimeList(getWaitingTimeList(restaurantSeq))
                .build();

        return searchInfoResponse;
    }

    private List<WaitingTimeResponse> getWaitingTimeList(long restaurantSeq) {
        String key = "averageWaitingTime:" + restaurantSeq;
        HashOperations<String, Object, Object> hashOps = redisTemplate.opsForHash();
        Map<Object, Object> s = hashOps.entries(key);
        List<WaitingTimeResponse> response = new ArrayList<>();
        for (Object data : s.keySet()) {
            WaitingTimeResponse w = WaitingTimeResponse.builder()
                    .timeZone((String) data)
                    .expectedWaitingTime((String) s.get(data))
                .build();
            response.add(w);
        }
        return response;
    }


    public RestaurantInfoResponse getRestaurantInfo(long restaurantSeq){
        Restaurant restaurant = restaurantJpaRepository.findByRestaurantSeq(restaurantSeq);
        RestaurantInfoResponse restaurantInfoResponse = RestaurantInfoResponse.builder()
                .restaurantAddress(restaurant.getRestaurantAddress())
                .restaurantImg(awsS3Repository.getTemporaryUrl(restaurant.getRestaurantImg()))
                .restaurantName(restaurant.getRestaurantName())
                .restaurantCategory(restaurant.getRestaurantCategory())
                .restaurantRating(restaurant.getRestaurantRating())
                .restaurantBusinessHours(restaurant.getRestaurantBusinessHours())
                .restaurantSeq(restaurant.getRestaurantSeq())
                .restaurantPhoneNumber(restaurant.getRestaurantPhoneNumber())
                .build();
        return restaurantInfoResponse;
    }


    public List<MenuInfoResponse> getMenuInfo(long restaurantSeq){
        List<MenuInfoResponse> menuInfoResponseList = new ArrayList<>();
        List<Menu> menues = menuJpaRepository.findByRestaurantSeq(restaurantSeq);
        for(Menu m : menues){
            MenuInfoResponse menuInfoResponse = MenuInfoResponse.builder()
                    .menuImage(awsS3Repository.getTemporaryUrl(m.getMenuImage()))
                    .menuSeq(m.getMenuSeq())
                    .menuPrice(m.getMenuPrice())
                    .menuName(m.getMenuName())
                    .build();
            menuInfoResponseList.add(menuInfoResponse);
        }
        return menuInfoResponseList;
    }

    @Transactional
    public RestaurantMainInfoListResponse getMainInfo(Double lat, Double lon) {

        RestaurantMainInfoListResponse restaurantMainInfoListResponse = RestaurantMainInfoListResponse.builder()
                .restaurantNearByList(getRestaurantNearByList(lat,lon))
                .restaurantHighRatingList(getRestaurantHighRatingList(lat,lon))
//                .restaurantLessWaitingList()
                .koreanFoodTopList(getRestaurantThemeList(lat, lon, "한식"))
                .westernFoodTopList(getRestaurantThemeList(lat, lon, "양식"))
                .chineseTopList(getRestaurantThemeList(lat, lon, "증식"))
                .japanesTopList(getRestaurantThemeList(lat, lon, "일식"))
                .fastFoodTopList(getRestaurantThemeList(lat, lon, "패스트푸드"))
                .cafeTopList(getRestaurantThemeList(lat, lon, "카페"))
                .bakeryTopList(getRestaurantThemeList(lat, lon, "베이커리"))
                .build();
        return restaurantMainInfoListResponse;

    }

    private List<RestaurantMainInfoResponse> getRestaurantThemeList(Double lat, Double lon, String theme) {
        List<RestaurantDocument> restaurantDocument = searchElasticAdvanceRepository.findThemeRestaurantsNearby(lat,lon,theme);
        List<RestaurantMainInfoResponse> restaurantMainInfoList = new ArrayList<>();
        for(RestaurantDocument r : restaurantDocument){
            RestaurantMainInfoResponse restaurantMainInfoResponse = RestaurantMainInfoResponse.builder()
                    .restaurantName(r.getRestaurantName())
                    .restaurantImage(awsS3Repository.getTemporaryUrl(r.getRestaurantImg()))
                    .restaurantRating(r.getRestaurantRating())
                    //.restaurantWaitingTime()
                    .build();
            restaurantMainInfoList.add(restaurantMainInfoResponse);
        }
        return restaurantMainInfoList;
    }

    private List<RestaurantMainInfoResponse> getRestaurantHighRatingList(Double lat, Double lon) {
        List<RestaurantDocument> restaurantDocument = searchElasticAdvanceRepository.findTopRatedRestaurantsNearby(lat,lon);
        List<RestaurantMainInfoResponse> restaurantMainInfoList = new ArrayList<>();
        for(RestaurantDocument r : restaurantDocument){
            RestaurantMainInfoResponse restaurantMainInfoResponse = RestaurantMainInfoResponse.builder()
                    .restaurantName(r.getRestaurantName())
                    .restaurantImage(awsS3Repository.getTemporaryUrl(r.getRestaurantImg()))
                    .restaurantRating(r.getRestaurantRating())
                    //.restaurantWaitingTime()
                    .build();
            restaurantMainInfoList.add(restaurantMainInfoResponse);
        }
        return restaurantMainInfoList;
    }

    // 메인 페이지에서 현재 위치기준 가까운 5가지 뽑아내는 로직
    private List<RestaurantMainInfoResponse> getRestaurantNearByList(Double lat, Double lon) {
        List<RestaurantDocument> restaurantDocument =  searchElasticAdvanceRepository.findNearestRestaurants(lat,lon);
        List<RestaurantMainInfoResponse> restaurantMainInfoList = new ArrayList<>();
        for(RestaurantDocument r : restaurantDocument){
            RestaurantMainInfoResponse restaurantMainInfoResponse = RestaurantMainInfoResponse.builder()
                    .restaurantName(r.getRestaurantName())
                    .restaurantImage(awsS3Repository.getTemporaryUrl(r.getRestaurantImg()))
                    .restaurantRating(r.getRestaurantRating())
                    //.restaurantWaitingTime()
                    .build();
            restaurantMainInfoList.add(restaurantMainInfoResponse);
        }

        return restaurantMainInfoList;
    }

    public List<Long> getRestaurantSeq() {
        List<Restaurant> restaurants = restaurantJpaRepository.findAll();
        List<Long> responseSeq = new ArrayList<>();
        for(Restaurant r : restaurants){
            responseSeq.add(r.getRestaurantSeq());
        }
        return responseSeq;
    }


//    private List<ReviewInfoResponse> getReviewInfo(long restaurantSeq) {
//        List<ReviewInfoResponse> reviewInfoResponseList = new ArrayList<>();
//        List<Review> reviews = reviewRepository.findByRestaurantSeq(restaurantSeq);
//        for(Review r : reviews){
//            ReviewInfoResponse reviewInfoResponse = ReviewInfoResponse.builder()
//
//                    .build();
//            reviewInfoResponseList.add(restaurantInfoResponse);
//        }
//        return reviewInfoResponseList;
//    }
}
