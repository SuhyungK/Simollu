package com.example.elasticsearch.repository.jpa;

import com.example.elasticsearch.model.dto.RestaurantInfoResponse;
import com.example.elasticsearch.model.entity.Restaurant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RestaurantJpaRepository extends JpaRepository<Restaurant,Long> {


    Restaurant findByRestaurantSeq(long restaurantSeq);
}
