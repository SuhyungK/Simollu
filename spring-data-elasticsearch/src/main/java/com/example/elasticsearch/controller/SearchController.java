package com.example.elasticsearch.controller;

import com.example.elasticsearch.model.service.SearchService;
import com.example.elasticsearch.model.document.SearchDocument;
import com.example.elasticsearch.model.dto.RestaurantListResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.codehaus.jettison.json.JSONException;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/search")
public class SearchController {

    private final SearchService searchService;

    /*검색기능*/
    @GetMapping("/contains")
    @Transactional(readOnly = false)
    public ResponseEntity<Map<String, List>> findByContainsDescription(@RequestParam String description,  String cx, String cy, Pageable pageable)
            throws JSONException, IOException, InterruptedException {
        // 단어 db 저장
        searchService.saveSearch(description);
        List<RestaurantListResponse> restaurantResponsesList = searchService.findByContainsDescription(description,cx, cy, pageable);
        Map<String, List> resultMap = new HashMap<>();
        resultMap.put("result", restaurantResponsesList);
        return ResponseEntity.ok(resultMap);
    }

    /*실시간 순위 뽑아내는 로직*/
    @PostMapping("/top-search-keyword")
    @Transactional(readOnly = false)
    public ResponseEntity<List<SearchDocument>> SearchHistory () throws IOException {
        // 단어 es 저장
        searchService.saveAllSearchDocuments();
        List<SearchDocument> top = searchService.getTopSearchKeywords(3);
        return ResponseEntity.ok(top);

    }



}
