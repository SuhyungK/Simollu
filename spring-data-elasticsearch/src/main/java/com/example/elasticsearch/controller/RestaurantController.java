package com.example.elasticsearch.controller;

import com.example.elasticsearch.model.service.RestaurantService;
import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/")
public class RestaurantController {

    private final RestaurantService restaurantService;

    // es로 보내기
    @PostMapping("/restaurantDocuments")
    public ResponseEntity<Void> saveRestaurantDocuments() throws IOException {
        restaurantService.saveAllRestaurantDocuments();
        return ResponseEntity.ok().build();
    }


}
