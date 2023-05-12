package com.example.elasticsearch.model.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class SearchHistoryResponse {
    private int order;
    private String keyword;
}
