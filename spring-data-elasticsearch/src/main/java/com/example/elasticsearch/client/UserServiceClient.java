package com.example.elasticsearch.client;

import com.example.elasticsearch.model.dto.user.GetUserInfoListRequestDto;
import com.example.elasticsearch.model.dto.user.GetUserInfoListResponseDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@FeignClient(name = "user-service")
public interface UserServiceClient {

    @PostMapping("/user/info-list")
    List<GetUserInfoListResponseDto> getUserInfoList(@RequestBody GetUserInfoListRequestDto userSeqList);

}
