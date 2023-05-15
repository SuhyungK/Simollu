package com.simollu.WaitingService.controller;

import com.simollu.WaitingService.model.dto.WaitingDetailDto;
import com.simollu.WaitingService.model.dto.WaitingDto;
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
@RequestMapping("/user")
@RequiredArgsConstructor
@Slf4j
@Api(tags = "Waiting API")
public class WaitingUserController {

    private final WaitingService waitingService;

    private static final int STATUS_COMPLETE = 1; // 완료
    private static final int STATUS_CANCEL = 2; // 취소

    /*
     * 웨이팅 등록
     * */
    @PostMapping
    public ResponseEntity<?> registWaiting(@RequestHeader("userSeq") String userSeq, @RequestBody WaitingHistoryDto waitingHistoryDto) {
        waitingHistoryDto.setUserSeq(userSeq);
        WaitingDetailDto waitingDetailDto = waitingService.registWaiting(waitingHistoryDto);

        return ResponseEntity.ok().body(waitingDetailDto);
    }//registWaiting

    /*
     * 웨이팅 취소
     * */
    @PostMapping("/cancel")
    public ResponseEntity<?> updateStatusCancel(@RequestBody WaitingStatusDto waitingStatusDto){
        WaitingHistoryDto waitingDto = waitingService.getWaiting(waitingStatusDto.getWaitingSeq()).toHistoryDto();
        waitingDto.setWaitingStatusContent(STATUS_CANCEL);

        if(waitingService.updateStatus(waitingStatusDto, waitingDto)){
            return ResponseEntity.status(HttpStatus.OK).build();
        }else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }//updateStatus

    /*
     * 웨이팅 완료
     * */
    @PostMapping("/complete")
    public ResponseEntity<?> updateStatusComplete(@RequestBody WaitingStatusDto waitingStatusDto){
        WaitingHistoryDto waitingDto = waitingService.getWaiting(waitingStatusDto.getWaitingSeq()).toHistoryDto();
        waitingDto.setWaitingStatusContent(STATUS_COMPLETE);

        if(waitingService.updateStatus(waitingStatusDto, waitingDto)){
            return ResponseEntity.status(HttpStatus.OK).build();
        }else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }//updateStatus

    /*
     * 회원의 웨이팅 리스트조회
     *
    @GetMapping
    public ResponseEntity<?> getUserWaitingList() {
        return null;
    }//getWaitingList
    */

    /*
     * 웨이팅 상세정보 조회
     * */
    @GetMapping("{waitingSeq}")
    public ResponseEntity<?> getWaitingInfo(@PathVariable("waitingSeq") Integer waitingSeq) {
        WaitingDetailDto waitingDetailDto = waitingService.getWaiting(waitingSeq);
        if(waitingDetailDto == null) return ResponseEntity.noContent().build();
        return ResponseEntity.ok(waitingDetailDto);
    }//getWaitingInfo

    /*
     * 웨이팅 순서변경
     * */
    @PutMapping
    public ResponseEntity<?> changeWaiting(@RequestHeader("userSeq") String userSeq, @RequestBody WaitingDto waitingDto) {
        waitingDto.setUserSeq(userSeq);
        Integer waitingSeq = waitingService.changeWaiting(waitingDto);
        if(waitingSeq == -1) return ResponseEntity.status(202).build();
        return ResponseEntity.ok(waitingSeq);
    }//changeWaiting

    /* 웨이팅 예상시간 조회 */
    @GetMapping("{restaurantSeq}/{waitingSeq}")
    public ResponseEntity<?> getWaitingTime(
            @PathVariable("restaurantSeq")Integer restaurantSeq
            , @PathVariable("waitingSeq")Integer waitingSeq) {

        return ResponseEntity.ok(waitingService.getWaitingTime(restaurantSeq, waitingSeq));
    }

    /* 웨이팅 내역 조회 (취소/완료) */
    @GetMapping("status/{waitingStatusContent}")
    public ResponseEntity<?> getWaitingHistory(
            @RequestHeader("userSeq") String userSeq, @PathVariable("waitingStatusContent")int waitingStatusContent) {

        return ResponseEntity.ok(waitingService.getWaitingHistory(userSeq, waitingStatusContent));
    }


}//WaitingUserController
