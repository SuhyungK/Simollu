package com.example.elasticsearch.model.service;



import com.example.elasticsearch.model.dto.review.ModifyReviewDto;
import com.example.elasticsearch.model.dto.review.ReviewDto;

import java.util.List;

public interface ReviewService {

    /* 후기 작성 */
    Long writeReview(String userSeq, ReviewDto reviewDto);

    /* 후기 리스트 조회 */
    List<ReviewDto> getReviewList(Long restaurantSeq);

    /* 후기 상세 조회 */
    ReviewDto getReview(Long reviewSeq);

    /* 후기 수정 */
    ReviewDto modifyReview(ModifyReviewDto modifyReviewDto);
}
