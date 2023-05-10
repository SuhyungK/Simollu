package com.example.elasticsearch.batch;

import com.example.elasticsearch.model.document.SearchDocument;
import com.example.elasticsearch.model.service.SearchService;
import java.io.IOException;
import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = false)
public class ScheduledTask {

    private final SearchService searchService;

    public void searchHistoryTask() throws IOException {
        // 단어 es 저장
        searchService.saveAllSearchDocuments();
        // 실시간 검색어 순위 추출
        List<SearchDocument> top = searchService.getTopSearchKeywords(3);
        System.out.println("######################################"); // 테스트용으로 콘솔에 출력
        System.out.println(top.get(0).getSearchWord()); // 테스트용으로 콘솔에 출력
    }
}
