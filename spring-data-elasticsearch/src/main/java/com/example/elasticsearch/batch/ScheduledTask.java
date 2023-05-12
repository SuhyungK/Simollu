package com.example.elasticsearch.batch;

import com.example.elasticsearch.model.dto.search.SearchRankResponse;
import com.example.elasticsearch.model.service.SearchService;
import com.example.elasticsearch.utils.RedisUtil;
import java.io.IOException;
import java.util.List;

import lombok.RequiredArgsConstructor;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = false)
public class ScheduledTask {

    private final SearchService searchService;
    private final RedisUtil redisUtil;
    private final RedisTemplate redisTemplate;

    public void searchHistoryTask() throws IOException {
        // 단어 es 저장
        searchService.saveAllSearchDocuments();
        // 실시간 검색어 순위 추출
        List<SearchRankResponse> top = searchService.getTopSearchKeywords(10);
        redisTemplate.delete("Ranking");
        for(SearchRankResponse n : top){
            redisTemplate.opsForList().rightPush("Ranking", n.getSearchWord());
        }
    }
}
