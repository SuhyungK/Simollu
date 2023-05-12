package com.example.elasticsearch.model.dto.restaurant;


import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class RestaurantMainInfoListResponse {
    private RestaurantNearByListResponse restaurantNearByList;
    private RestaurantHighRatingListResponse restaurantHighRatingList;
    private RestaurantLessWaitingListResponse restaurantLessWaitingList;

}
