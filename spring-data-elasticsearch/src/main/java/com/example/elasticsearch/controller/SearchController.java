package com.example.elasticsearch.controller;

import com.example.elasticsearch.model.dto.SearchHistoryResponse;
import com.example.elasticsearch.model.dto.SearchRankResponse;
import com.example.elasticsearch.model.service.RedisService;
import com.example.elasticsearch.model.service.SearchService;
import com.example.elasticsearch.model.dto.RestaurantListResponse;
import com.example.elasticsearch.utils.RedisUtil;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.codehaus.jettison.json.JSONException;
import org.springframework.data.domain.Pageable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/search")
public class SearchController {

    private final SearchService searchService;
    private final RedisUtil redisUtil;
    private final RedisTemplate redisTemplate;

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
    @GetMapping("/top-search-keyword")
    @Transactional(readOnly = false)
    public ResponseEntity<List<SearchHistoryResponse>> SearchHistory () throws IOException {
        List<SearchHistoryResponse> searchHistoryListResponse = searchService.SearchHistory();
        return ResponseEntity.ok(searchHistoryListResponse);

    }

    @GetMapping("/top-search-keyword2")
    @Transactional(readOnly = false)
    public ResponseEntity<Map<Integer, String>> SearchHistoryToRedis () throws IOException {
        searchService.saveAllSearchDocuments();
        // 실시간 검색어 순위 추출
        List<SearchRankResponse> top = searchService.getTopSearchKeywords(10);
//        redisTemplate.delete("Ranking");
        for (SearchRankResponse n : top) {
            System.out.println(n.getSearchWord()+"____________________");
        }
        return null;
    }

}
