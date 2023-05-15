package com.example.elasticsearch.client;


import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import org.springframework.web.bind.annotation.PostMapping;

// name 에는 마이크로서비스의 이름 등록
@FeignClient(name = "waiting-service")
public interface WaitingClientService {

//    @PostMapping("/order-service/{userId}/orders")
//    List<ResponseOrder> getOrders(@PathVariable String userId);

}
