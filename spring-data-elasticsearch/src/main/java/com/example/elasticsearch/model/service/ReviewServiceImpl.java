package com.example.elasticsearch.model.service;


import com.example.elasticsearch.model.dto.review.ModifyReviewDto;
import com.example.elasticsearch.model.dto.review.MyReviewDto;
import com.example.elasticsearch.model.dto.review.ReviewDto;
import com.example.elasticsearch.model.dto.review.WriteableReviewDto;
import com.example.elasticsearch.model.entity.Review;
import com.example.elasticsearch.repository.jpa.RestaurantJpaRepository;
import com.example.elasticsearch.repository.review.ReviewRepository;
import com.example.elasticsearch.utils.DateTimeUtils;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReviewServiceImpl implements ReviewService {
    private final ReviewRepository reviewRepository;
    private final RestaurantJpaRepository restaurantRepository;
    private final RedisTemplate redisTemplate;
    private final ObjectMapper objectMapper;

    /* 후기 작성 */
    @Override
    public Long writeReview(String userSeq, ReviewDto reviewDto) {
        System.out.println(reviewDto.isReviewRating());

        if(reviewDto.isReviewRating()){
            System.out.println("여기야");
            Integer value = (Integer) redisTemplate.opsForHash().get("review", reviewDto.getRestaurantSeq() + "_true");
        redisTemplate.opsForHash().put("review", reviewDto.getRestaurantSeq() + "_true",value+1);
        }
        Integer value = (Integer) redisTemplate.opsForHash().get("review", reviewDto.getRestaurantSeq() + "_false");
        redisTemplate.opsForHash().put("review", reviewDto.getRestaurantSeq() + "_false",value+1);

        Review review = Review.builder()
                .userSeq(userSeq)
                .restaurantSeq(reviewDto.getRestaurantSeq())
                .reviewRating(reviewDto.isReviewRating())
                .reviewContent(reviewDto.getReviewContent())
                .reviewRegistDate(DateTimeUtils.nowFromZone()) // 현재 시간으로 설정
                .build();

        return reviewRepository.save(review).getReviewSeq();
    }

    /* 후기 리스트 조회 */

    public List<ReviewDto> getReviewList(Long restaurantSeq) {
        List<Review> reviewList = reviewRepository.findByRestaurantSeq(restaurantSeq);
        List<ReviewDto> dtoList = new ArrayList<>();

        for(Review review : reviewList){
            ReviewDto dto = ReviewDto.builder()
                    .reviewSeq(review.getReviewSeq())
                    .userSeq(review.getUserSeq())
                    .restaurantSeq(review.getRestaurantSeq())
                    .reviewContent(review.getReviewContent())
                    .reviewRating(review.isReviewRating())
                    .reviewRegistDate(review.getReviewRegistDate())
                    .build();
            dtoList.add(dto);
        }

        return dtoList;
    }

    /* 후기 상세 조회 */

    public ReviewDto getReview(Long reviewSeq) {
        Review review = reviewRepository.findById(reviewSeq).orElse(null);

        return ReviewDto.builder()
                .reviewSeq(review.getReviewSeq())
                .userSeq(review.getUserSeq())
                .restaurantSeq(review.getRestaurantSeq())
                .reviewContent(review.getReviewContent())
                .reviewRating(review.isReviewRating())
                .reviewRegistDate(review.getReviewRegistDate())
                .build();
    }

    /* 후기 수정 */
    @Override
    public ReviewDto modifyReview(ModifyReviewDto modifyReviewDto) {
        Review review = reviewRepository.findById(modifyReviewDto.getReviewSeq()).orElse(null);
        review.setReviewRating(modifyReviewDto.isReviewRating());
        review.setReviewContent(modifyReviewDto.getReviewContent());
        reviewRepository.save(review);

        ReviewDto reviewDto = new ReviewDto();
        return reviewDto.builder()
                .reviewSeq(modifyReviewDto.getReviewSeq())
                .userSeq(review.getUserSeq())
                .restaurantSeq(review.getRestaurantSeq())
                .reviewRating(review.isReviewRating())
                .reviewContent(review.getReviewContent())
                .reviewRegistDate(review.getReviewRegistDate())
                .build();
    }

    /* 내 리뷰 리스트 조회 */
    @Override
    public List<MyReviewDto> getMyReviewList(String userSeq) {
        List<MyReviewDto> myReviewDtoList = reviewRepository.getReviewByUserSeq(userSeq).orElse(null);
        return myReviewDtoList;
    }

    /* 작성가능 리뷰 리스트 조회 */
    @Override
    public List<WriteableReviewDto> getWriteableList(String userSeq) {
        List<WriteableReviewDto> writeableReviewDtoList = reviewRepository.getWriteableList(userSeq).orElse(null);

        return writeableReviewDtoList;
    }

    /* review redis 제일 처음 초기화 */
    @Override
    public void writeReviewRedis()  {
        int n = (int) restaurantRepository.count();
        HashOperations<String, Object, Object> hashOps = redisTemplate.opsForHash();
        Map<Object, Object> map = new HashMap<>();
        for(int i=1; i<=n; i++) {
            hashOps.put("review", i+"_false", 0);
            hashOps.put("review", i+"_true", 0);
        }
    }

}
