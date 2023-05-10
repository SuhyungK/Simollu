package com.example.elasticsearch.model.dto;

import lombok.Getter;

import java.util.List;
import lombok.Setter;

@Getter
@Setter
public class RestaurantSaveAllRequest {

    private List<RestaurantSaveRequest> restaurantSaveRequestList;
}
