package com.simollu.WaitingService.model.service;

import com.simollu.WaitingService.model.dto.WaitingDetailDto;
import com.simollu.WaitingService.model.dto.WaitingDto;
import com.simollu.WaitingService.model.dto.WaitingHistoryDto;
import com.simollu.WaitingService.model.dto.WaitingStatusDto;

import java.util.List;

public interface WaitingService {

    /* 웨이팅 신청 */
    WaitingDetailDto registWaiting(WaitingHistoryDto waitingDetailDto);

    /* 마지막 웨이팅 번호 가져오기 */
    Integer getLastWaitingNo(Integer restaurantSeq);

    /* 웨이팅 상태 변경 */
    boolean updateStatus(WaitingStatusDto waitingStatusDto, WaitingHistoryDto waitingHistoryDto);

    /* 웨이팅 상세정보 조회 */
    WaitingDetailDto getWaiting(Integer waitingSeq);
//    WaitingDetailDto getWaiting(String userSeq);

    /* 순서 변경 */
    Integer changeWaiting(WaitingDto waitingDto);

    /* 웨이팅 리스트 조회(식당) */
    List<WaitingHistoryDto> getWaitingList(Integer restaurantSeq);

    /* 웨이팅 예상시간 조회 */
    Integer getWaitingTime(Integer restaurantSeq, Integer waitingSeq);

    /* 웨이팅 예상시간 조회 */
    Integer getWaitingTime(Integer restaurantSeq);

    /* 웨이팅 내역 조회 (취소/완료) */
    List<WaitingHistoryDto> getWaitingHistory(String userSeq, int waitingStatusContent);

}//WaitingService
