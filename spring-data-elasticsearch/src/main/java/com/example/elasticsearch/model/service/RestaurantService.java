package com.example.elasticsearch.model.service;

import com.example.elasticsearch.aws.AwsS3Repository;
import com.example.elasticsearch.client.WaitingClientService;
import com.example.elasticsearch.model.dto.main.RestaurantMainInfoListResponse;
import com.example.elasticsearch.model.dto.main.RestaurantMainThemeInfoResponse;
import com.example.elasticsearch.model.dto.menu.MenuInfoResponse;
import com.example.elasticsearch.model.dto.restaurant.RestaurantFavoriteResponse;
import com.example.elasticsearch.model.dto.restaurant.RestaurantInfoResponse;
import com.example.elasticsearch.model.dto.main.RestaurantMainInfoResponse;
import com.example.elasticsearch.model.dto.restaurant.WaitingTimeResponse;
import com.example.elasticsearch.model.dto.search.SearchInfoResponse;
import com.example.elasticsearch.model.dto.waiting.WaitingOneResponseDto;
import com.example.elasticsearch.model.entity.Menu;
import com.example.elasticsearch.model.entity.Restaurant;
import com.example.elasticsearch.model.document.RestaurantDocument;
import com.example.elasticsearch.repository.elkAdvance.SearchElasticAdvanceRepository;
import com.example.elasticsearch.repository.jpa.MenuJpaRepository;
import com.example.elasticsearch.repository.jpa.RestaurantJpaRepository;
import com.example.elasticsearch.repository.elkBasic.RestaurantElasticBasicRepository;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Qualifier;
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
    private final SearchElasticAdvanceRepository searchElasticAdvanceRepository;
    private final AwsS3Repository awsS3Repository;
    @Qualifier("jsonRedisTemplate")
    private final RedisTemplate<String, Object> redisTemplate;


    private final WaitingClientService waitingClientService;



    // 시간 계산
    public int getWaitingTime(Long restaurantSeq) {
        WaitingOneResponseDto restaurantWaitingStatus = waitingClientService.getRestaurantWaitingStatus(restaurantSeq);
        return restaurantWaitingStatus.getWaitingTime();


    }



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
                    .expectedWaitingTime((int)Double.parseDouble(s.get(data).toString()))
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
                .restaurantLessWaitingList(getRestaurantLessWaitingList(lat,lon))
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

    private List<RestaurantMainInfoResponse> getRestaurantLessWaitingList(Double lat, Double lon) {
        List<RestaurantDocument> restaurantDocument = searchElasticAdvanceRepository.findLessWaitingRestaurant(lat,lon);
        List<RestaurantMainInfoResponse> restaurantMainInfoList = new ArrayList<>();
        for(RestaurantDocument r : restaurantDocument){
            RestaurantMainInfoResponse restaurantMainInfoResponse = RestaurantMainInfoResponse.builder()
                    .restaurantSeq(r.getRestaurantSeq())
                    .restaurantName(r.getRestaurantName())
                    .restaurantImage(awsS3Repository.getTemporaryUrl(r.getRestaurantImg()))
                    .restaurantRating(r.getRestaurantRating())
                    .restaurantWaitingTime(getWaitingTime(r.getRestaurantSeq()))
                    .build();
            restaurantMainInfoList.add(restaurantMainInfoResponse);
        }
        return restaurantMainInfoList;
    }

    private List<RestaurantMainThemeInfoResponse> getRestaurantThemeList(Double lat, Double lon, String theme) {
        List<RestaurantDocument> restaurantDocument = searchElasticAdvanceRepository.findThemeRestaurantsNearby(lat,lon,theme);
        List<RestaurantMainThemeInfoResponse> restaurantMainInfoList = new ArrayList<>();
        for(RestaurantDocument r : restaurantDocument){
            RestaurantMainThemeInfoResponse restaurantMainInfoResponse = RestaurantMainThemeInfoResponse.builder()
                    .restaurantSeq(r.getRestaurantSeq())
                    .restaurantName(r.getRestaurantName())
                    .restaurantImage(awsS3Repository.getTemporaryUrl(r.getRestaurantImg()))
                    .restaurantRating(r.getRestaurantRating())
                    .restaurantWaitingTime(getWaitingTime(r.getRestaurantSeq()))
                    .restaurantAddress(slicingAddress(r.getRestaurantAddress()))
                    .distance(calculateDistance(lat, lon, Double.parseDouble(r.getRestaurantY()), Double.parseDouble(r.getRestaurantX())))
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
                    .restaurantSeq(r.getRestaurantSeq())
                    .restaurantName(r.getRestaurantName())
                    .restaurantImage(awsS3Repository.getTemporaryUrl(r.getRestaurantImg()))
                    .restaurantRating(r.getRestaurantRating())
                    .restaurantWaitingTime(getWaitingTime(r.getRestaurantSeq()))
                    .build();
            restaurantMainInfoList.add(restaurantMainInfoResponse);
        }
        return restaurantMainInfoList;
    }

    // 메인 페이지에서 현재 위치기준 가까운 5가지 뽑아내는 로직
    /* 동언 */
    private List<RestaurantMainInfoResponse> getRestaurantNearByList(Double lat, Double lon) {
        List<RestaurantDocument> restaurantDocument =  searchElasticAdvanceRepository.findNearestRestaurants(lat,lon);
        List<RestaurantMainInfoResponse> restaurantMainInfoList = new ArrayList<>();
        for(RestaurantDocument r : restaurantDocument){
            RestaurantMainInfoResponse restaurantMainInfoResponse = RestaurantMainInfoResponse.builder()
                    .restaurantSeq(r.getRestaurantSeq())
                    .restaurantName(r.getRestaurantName())
                    .restaurantImage(awsS3Repository.getTemporaryUrl(r.getRestaurantImg()))
                    .restaurantRating(r.getRestaurantRating())
                    .restaurantWaitingTime(getWaitingTime(r.getRestaurantSeq()))
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

    public List<RestaurantFavoriteResponse>  getRestaurantFavoriteInfo(List<Long> restaurantFavoriteList) {
        List<RestaurantFavoriteResponse> list = new ArrayList<>();
        for(Long r : restaurantFavoriteList){
            Restaurant restaurant = restaurantJpaRepository.findByRestaurantSeq(r);
            RestaurantFavoriteResponse restaurantFavoriteResponse = RestaurantFavoriteResponse.builder()
                    .restaurantSeq(restaurant.getRestaurantSeq())
                    .restaurantName(restaurant.getRestaurantName())
                    .restaurantAddress(slicingAddress(restaurant.getRestaurantAddress()))
                    .restaurantRating(restaurant.getRestaurantRating())
                    .restaurantCategory(restaurant.getRestaurantCategory())
                    .restaurantImg(restaurant.getRestaurantImg())
                    .build();
            list.add(restaurantFavoriteResponse);

        }
        return list;
    }



    public RestaurantFavoriteResponse  getRestaurantFavorite(Long restaurantSeq) {


            Restaurant restaurant = restaurantJpaRepository.findByRestaurantSeq(restaurantSeq);
            RestaurantFavoriteResponse restaurantFavoriteResponse = RestaurantFavoriteResponse.builder()
                    .restaurantSeq(restaurant.getRestaurantSeq())
                    .restaurantName(restaurant.getRestaurantName())
                    .restaurantAddress(slicingAddress(restaurant.getRestaurantAddress()))
                    .restaurantRating(restaurant.getRestaurantRating())
                    .restaurantCategory(restaurant.getRestaurantCategory())
                    .restaurantImg(restaurant.getRestaurantImg())
                    .build();



        return restaurantFavoriteResponse;
    }

    private String slicingAddress(String restaurantAddress) {
        String[] parts = restaurantAddress.split(" "); // 공백을 기준으로 문자열을 여러 부분으로 나눕니다.

        String slicedAddress = "";
        for (int i = 0; i < parts.length; i++) {
            if (i < 2) { // 첫 번째와 두 번째 부분만 결합합니다.
                slicedAddress += parts[i] + " ";
            }
        }
        return slicedAddress.trim();
    }

    public static double calculateDistance(double startLat, double startLng, double endLat, double endLng) {
        double earthRadiusKm = 6371.0;
        double dLat = Math.toRadians(endLat - startLat);
        double dLng = Math.toRadians(endLng - startLng);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(Math.toRadians(startLat)) * Math.cos(Math.toRadians(endLat)) * Math.sin(dLng / 2) * Math.sin(dLng / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distanceInKm = earthRadiusKm * c;

        // 반올림하여 소수점 둘째 자리까지 표시
        BigDecimal bd = new BigDecimal(distanceInKm).setScale(2, RoundingMode.HALF_UP);
        BigDecimal roundedDistance = bd.add(new BigDecimal(0.2)).setScale(2, RoundingMode.HALF_UP); // 덧셈도 BigDecimal을 사용하여 수행

        return roundedDistance.doubleValue();
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
