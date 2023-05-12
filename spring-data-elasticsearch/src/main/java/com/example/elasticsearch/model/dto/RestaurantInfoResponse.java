package com.example.elasticsearch.model.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class RestaurantInfoResponse {
    private Long restaurantSeq;

    private String restaurantName;

    private String restaurantCategory;

    private String restaurantBusinessHours;

    private String restaurantPhoneNumber;

    private String restaurantAddress;

    private String restaurantImg;

    private int restaurantRating;
}
