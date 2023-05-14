package com.example.elasticsearch.controller;

import com.example.elasticsearch.model.dto.search.SearchInfoResponse;
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

    // 레스토랑 상세검색
    @GetMapping("/restaurant/{restaurantSeq}")
    public ResponseEntity<SearchInfoResponse> getSearchInfo(@PathVariable("restaurantSeq") long restaurantSeq) throws IOException {
        return ResponseEntity.ok(restaurantService.getSearchInfo(restaurantSeq));
    }


}
