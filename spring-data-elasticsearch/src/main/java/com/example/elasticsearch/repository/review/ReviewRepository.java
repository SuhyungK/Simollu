package com.example.elasticsearch.repository.review;


import com.example.elasticsearch.model.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {

    List<Review> findByRestaurantSeq(@Param("restaurantSeq") Integer restaurantSeq);

}
