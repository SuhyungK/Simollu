package com.simollu.UserService.client;


import com.simollu.UserService.dto.restaurant.RestaurantFavoriteResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "restaurant-service")
public interface RestaurantServiceClient {

    @GetMapping("favorite/{restaurantSeq}")
    RestaurantFavoriteResponse getRestaurant(@PathVariable("restaurantSeq") long restaurantSeq);

}
