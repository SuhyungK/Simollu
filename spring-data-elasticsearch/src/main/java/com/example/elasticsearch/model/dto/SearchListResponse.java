package com.example.elasticsearch.model.dto;

import lombok.Getter;

@Getter

public class SearchListResponse {
    private Long restaurantSeq;
    private String restaurantName;
    private int restaurantRating;
    private String restaurantX;
    private String restaurantY;
    private String restaurantImg;
}
