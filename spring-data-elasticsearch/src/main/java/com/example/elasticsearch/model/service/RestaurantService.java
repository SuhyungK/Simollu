package com.example.elasticsearch.model.service;

import com.example.elasticsearch.model.entity.Restaurant;
import com.example.elasticsearch.model.document.RestaurantDocument;
import com.example.elasticsearch.repository.jpa.RestaurantJpaRepository;
import com.example.elasticsearch.repository.elkBasic.RestaurantElasticBasicRepository;
import java.io.IOException;
import java.util.ArrayList;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class RestaurantService {

    private final RestaurantJpaRepository restaurantRepository;
    private final RestaurantElasticBasicRepository restaurantElasticBasicRepository;

    @Transactional
    public void saveAllRestaurantDocuments() throws IOException {
        List<RestaurantDocument> restaurantDocumentList = new ArrayList<>();
        List<Restaurant> restaurantList = restaurantRepository.findAll();
        for (Restaurant restaurant : restaurantList) {
            RestaurantDocument document = RestaurantDocument.from(restaurant);
            restaurantDocumentList.add(document);
        }
        restaurantElasticBasicRepository.saveAll(restaurantDocumentList);
    }


}
