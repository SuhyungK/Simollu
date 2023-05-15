package com.example.elasticsearch.model.dto.main;


import com.example.elasticsearch.model.dto.restaurant.RestaurantHighRatingListResponse;
import com.example.elasticsearch.model.dto.restaurant.RestaurantLessWaitingListResponse;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class RestaurantMainInfoListResponse {
    private List<RestaurantMainInfoResponse> restaurantNearByList;
    private List<RestaurantMainInfoResponse> restaurantHighRatingList;
    private List<RestaurantMainInfoResponse> restaurantLessWaitingList;
    private List<RestaurantMainInfoResponse> koreanFoodTopList;
    private List<RestaurantMainInfoResponse> westernFoodTopList;
    private List<RestaurantMainInfoResponse> chineseTopList;
    private List<RestaurantMainInfoResponse> japanesTopList;
    private List<RestaurantMainInfoResponse> fastFoodTopList;
    private List<RestaurantMainInfoResponse> cafeTopList;
    private List<RestaurantMainInfoResponse> bakeryTopList;
}
