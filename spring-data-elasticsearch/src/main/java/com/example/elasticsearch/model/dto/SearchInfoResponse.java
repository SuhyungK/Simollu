package com.example.elasticsearch.model.dto;

import java.util.List;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class SearchInfoResponse {
    private RestaurantInfoResponse restaurantInfo;
    private List<MenuInfoResponse> menuInfoList;
    private List<ReviewInfoResponse> reviewInfoList;

}
