package com.example.elasticsearch.client;

import com.example.elasticsearch.model.dto.user.GetUserInfoListRequestDto;
import com.example.elasticsearch.model.dto.user.GetUserInfoListResponseDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@FeignClient(name = "user-service")
public interface UserServiceClient {

    @PostMapping("/user/info-list")
    List<GetUserInfoListResponseDto> getUserInfoList(@RequestBody GetUserInfoListRequestDto userSeqList);

    @GetMapping("/user/restaurant/{restaurantSeq}")
    boolean checkUserRestaurant(@RequestHeader("userSeq") String userSeq, @PathVariable Long restaurantSeq);

}
