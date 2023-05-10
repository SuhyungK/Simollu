package com.example.elasticsearch.controller;


import com.example.elasticsearch.model.dto.review.ModifyReviewDto;
import com.example.elasticsearch.model.dto.review.ReviewDto;
import com.example.elasticsearch.model.service.ReviewService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/review")
@RequiredArgsConstructor
@Slf4j
public class ReviewController {
    private final ReviewService reviewService;

    /* 후기 작성 */
    @PostMapping
    public ResponseEntity<?> writeReview(
            @RequestHeader("userSeq") String userSeq,
            @RequestBody ReviewDto reviewDto) {
        return ResponseEntity.ok(reviewService.writeReview(userSeq, reviewDto));
    }

    /* 후기 리스트 조회 */
    @GetMapping("{restaurantSeq}")
    public ResponseEntity<?> getReviewList(@PathVariable Integer restaurantSeq) {
        return ResponseEntity.ok(reviewService.getReviewList(restaurantSeq));
    }


    /* 후기 상세 조회 */
    @GetMapping("detail/{reviewSeq}")
    public ResponseEntity<?> getReview(@PathVariable Integer reviewSeq) {
        return ResponseEntity.ok(reviewService.getReview(reviewSeq));
    }

    /* 후기 수정 */
    @PutMapping("detail/{reviewSeq}")
    public ResponseEntity<?> modifyReview(@RequestBody ModifyReviewDto modifyReviewDto, @PathVariable Integer reviewSeq) {
        return ResponseEntity.ok(reviewService.modifyReview(modifyReviewDto));
    }

}
