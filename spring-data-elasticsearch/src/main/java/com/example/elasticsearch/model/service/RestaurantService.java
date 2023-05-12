package com.example.elasticsearch.model.service;

import com.example.elasticsearch.model.dto.MenuInfoResponse;
import com.example.elasticsearch.model.dto.RestaurantInfoResponse;
import com.example.elasticsearch.model.dto.ReviewInfoResponse;
import com.example.elasticsearch.model.dto.SearchInfoResponse;
import com.example.elasticsearch.model.entity.Menu;
import com.example.elasticsearch.model.entity.Restaurant;
import com.example.elasticsearch.model.document.RestaurantDocument;
import com.example.elasticsearch.model.entity.Review;
import com.example.elasticsearch.repository.jpa.MenuJpaRepository;
import com.example.elasticsearch.repository.jpa.RestaurantJpaRepository;
import com.example.elasticsearch.repository.elkBasic.RestaurantElasticBasicRepository;
import com.example.elasticsearch.repository.review.ReviewRepository;
import java.io.IOException;
import java.util.ArrayList;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Slice;
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
    private final ReviewRepository reviewRepository;

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
                .build();

        return searchInfoResponse;
    }


    public RestaurantInfoResponse getRestaurantInfo(long restaurantSeq){
        Restaurant restaurant = restaurantJpaRepository.findByRestaurantSeq(restaurantSeq);
        RestaurantInfoResponse restaurantInfoResponse = RestaurantInfoResponse.builder()
                .restaurantAddress(restaurant.getRestaurantAddress())
                .restaurantImg(restaurant.getRestaurantImg())
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
                    .menuImage(m.getMenuImage())
                    .menuSeq(m.getMenuSeq())
                    .menuPrice(m.getMenuPrice())
                    .menuName(m.getMenuName())
                    .build();
            menuInfoResponseList.add(menuInfoResponse);
        }
        return menuInfoResponseList;
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
