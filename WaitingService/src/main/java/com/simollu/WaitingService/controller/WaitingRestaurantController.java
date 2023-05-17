package com.simollu.WaitingService.controller;

import com.simollu.WaitingService.model.dto.WaitingHistoryDto;
import com.simollu.WaitingService.model.dto.WaitingStatusDto;
import com.simollu.WaitingService.model.service.WaitingService;
import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/restaurant")
@RequiredArgsConstructor
@Slf4j
@Api(tags = "Waiting API")
public class WaitingRestaurantController {

    private final WaitingService waitingService;

    /* 웨이팅 리스트 조회(식당) */
    @GetMapping("{restaurantSeq}")
    public ResponseEntity<?> getWaitingList(@PathVariable("restaurantSeq") Integer restaurantSeq) {

        return ResponseEntity.ok(waitingService.getWaitingList(restaurantSeq));
    }

    /*
     * 웨이팅 입장
     * */
//    @PostMapping("complete")
//    public ResponseEntity<?> updateStatus(@RequestBody WaitingStatusDto waitingStatusDto){
//        WaitingHistoryDto waitingDto = waitingService.getWaiting(waitingStatusDto.getUserSeq()).toHistoryDto();
//
//        // 알림 보내는 로직
//
//        return null;
//    }//updateStatus

}
