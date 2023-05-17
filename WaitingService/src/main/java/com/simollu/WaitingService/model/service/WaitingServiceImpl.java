package com.simollu.WaitingService.model.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.simollu.WaitingService.model.dto.*;
import com.simollu.WaitingService.model.entity.Waiting;
import com.simollu.WaitingService.repository.WaitingRepository;
import com.simollu.WaitingService.repository.WaitingStatusRepository;
import com.simollu.WaitingService.utils.DateTimeUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class WaitingServiceImpl implements WaitingService {

    private final WaitingRepository waitingRepository;
    private final WaitingStatusRepository waitingStatusRepository;
    private final RedisTemplate<String, Object> redisTemplate;
    private final RedisService redisService;
    private final RedisCacheService redisCacheService; // 추가

    private static final String RESTAURANT_KEY = "restaurant_no:";
    private static final int STATUS_WAITING = 0; // 웨이팅
    private static final int STATUS_COMPLETE = 1; // 완료
    private static final int STATUS_CANCEL = 2; // 취소
    private static final int STATUS_CHANGE = 3; // 미루기
    private static final int STATUS_DELETE = -1; // 웨이팅 삭제

    /* 웨이팅 걸기 */
    public WaitingDetailDto registWaiting(WaitingHistoryDto waitingHistoryDto) {

        // 대기번호
        Integer waitingNo = getLastWaitingNo(waitingHistoryDto.getRestaurantSeq()) + 1;

        waitingHistoryDto.setWaitingNo(waitingNo);
        Waiting waiting = waitingHistoryDto.toEntity();

        Integer waitingSeq = waitingRepository.save(waiting).getWaitingSeq();
        WaitingStatusDto statusDto = new WaitingStatusDto(waitingSeq, STATUS_WAITING,
                redisService.getWaitingCnt(waitingHistoryDto.getRestaurantSeq())+1, DateTimeUtils.nowFromZone());
        waitingHistoryDto.setWaitingSeq(waitingSeq);
        waitingHistoryDto.setWaitingStatusRegistDate(statusDto.getWaitingStatusRegistDate()); // 대기일시
        updateStatus(statusDto, waitingHistoryDto);

        // 회원 웨이팅
        WaitingDetailDto waitingDetailDto = waitingHistoryDto.toWaitingDetailDto();
        waitingDetailDto.setWaitingStatusRegistDate(statusDto.getWaitingStatusRegistDate()); // 대기일시
        waitingDetailDto.setWaitingStatusContent(STATUS_WAITING); // 대기중

        try{
            waiting.setWaitingSeq(waitingSeq);
            redisService.putRedisList(waitingHistoryDto.getRestaurantSeq(), waitingHistoryDto);
            redisService.saveUserWaitingToRedis(waitingDetailDto.getWaitingSeq(), waitingDetailDto);
        }catch (JsonProcessingException e){
            log.error("registWaiting error!!!!");
        }

        waitingDetailDto.setWaitingCurRank(redisService.getIndex(waitingDetailDto.getRestaurantSeq(), waitingSeq));
        waitingDetailDto.setWaitingTime(getWaitingTime(waitingDetailDto.getRestaurantSeq(), waitingSeq));
        return waitingDetailDto;
    }


    @Override
    public Integer getLastWaitingNo(Integer restaurantSeq){
        // 데이터 조회 시 캐시 먼저 조회
//        String key = "restaurant:"+restaurantSeq;
        Long size = redisTemplate.opsForList().size(RESTAURANT_KEY + restaurantSeq);
        WaitingHistoryDto waiting = null;
        try {
            waiting = redisService.getRedisListValue(restaurantSeq, size-1, WaitingHistoryDto.class);
        }catch (JsonProcessingException e){
            log.error("getLastWaitingNo error!!!!");
        }


        Integer no = 0;
        if(waiting == null){
            SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd 00:00:00");
            Date now = new Date(System.currentTimeMillis());
            String strDate = formatter.format(now);
            no = waitingRepository.findByWaitingNo(strDate, restaurantSeq).orElse(0);
        }else{
            no = waiting.getWaitingNo();
        }

        return no;
    }


    /* 웨이팅 리스트 조회(식당) */
    @Override
    public List<WaitingHistoryDto> getWaitingList(Integer restaurantSeq) {
        List<Object> list = redisService.getRedisList(RESTAURANT_KEY + restaurantSeq);
        int size = list.size();
        List<WaitingHistoryDto> waitingList = new ArrayList<>();

        try {
            for(Object obj : list) {
                WaitingHistoryDto waiting = WaitingHistoryDto.JsonToDto((String) obj);
                waitingList.add(
                        WaitingHistoryDto.builder()
                                .waitingSeq(waiting.getWaitingSeq())
                                .waitingNo(waiting.getWaitingNo())
                                .waitingPersonCnt(waiting.getWaitingPersonCnt())
                                .userSeq(waiting.getUserSeq())
                                .restaurantSeq(waiting.getRestaurantSeq())
                                .restaurantName(waiting.getRestaurantName())
                                .waitingStatusRegistDate(waiting.getWaitingStatusRegistDate())
                                .waitingStatusContent(waiting.getWaitingStatusContent())
                                .build()
                );
            }

        }catch (IOException e){

        }

        return waitingList;
    }

    /* 사용자의 웨이팅 예상시간 조회 */
    @Override
    public Integer getWaitingTime(Integer restaurantSeq, Integer waitingSeq) {

        // LocalTime inputTime = LocalTime.now();
        LocalTime inputTime = LocalTime.of(18, 25);
        Double ratioValue = redisCacheService.getAverageWaitingTime(restaurantSeq, inputTime); // 시간별 예상 대기 시간
        int cnt = getCurrentWaitingRank(restaurantSeq, waitingSeq); // 현재 내 순서

        return  Integer.valueOf((int) (cnt * ratioValue));
    }

    /* 식당의 웨이팅 예상시간 조회 */
    @Override
    public Integer getWaitingTime(Integer restaurantSeq) {

        // LocalTime inputTime = LocalTime.now();
        LocalTime inputTime = LocalTime.of(18, 25);
        Double ratioValue = redisCacheService.getAverageWaitingTime(restaurantSeq, inputTime); // 시간별 예상 대기 시간
        int cnt = redisService.getWaitingCnt(restaurantSeq);

        return (int)(cnt * ratioValue);
    }

    /* 대기 순서 구하기 */
    public int getCurrentWaitingRank(Integer restaurantSeq, Integer waitingSeq) {
        return redisService.getIndex(restaurantSeq, waitingSeq);
    }

    /* 웨이팅 내역 조회 (취소/완료) */
    @Override
    public List<WaitingHistoryDto> getWaitingHistory(String userSeq, int waitingStatusContent) {
        List<WaitingHistoryDto> waitingList = waitingRepository
                .findByUserSeqAndWaitingStatusContent(userSeq, waitingStatusContent).orElse(null);

        return waitingList;
    }



    /* 웨이팅 상태 변경 (취소, 완료) */
    @Override
    public boolean updateStatus(WaitingStatusDto waitingStatusDto, WaitingHistoryDto waitingHistoryDto) {

        // 취소/완료면 레디스에서 제거
        if(waitingStatusDto.getWaitingStatusContent() != 0) {
            waitingStatusDto.setWaitingStatusRegistDate(DateTimeUtils.nowFromZone()); // 현재 시간 설정
            redisService.deleteWaiting(waitingHistoryDto.getRestaurantSeq(), waitingHistoryDto.getWaitingSeq(), STATUS_DELETE);
            if(waitingStatusDto.getWaitingStatusContent() == STATUS_COMPLETE){
                // 완료되었습니다 알림
                // 작성가능후기 DB 추가
            }else{
                // 취소되었습니다 알림
            }
        }
        waitingStatusRepository.save(waitingStatusDto.toEntity());

        return true;
    }

    /* 웨이팅 순서 변경 (미루기) */
    @Override
    public Integer changeWaiting(WaitingDto waitingDto) {
//        WaitingStatus waitingStatus = waitingStatusRepository.findByWaitingSeqAndWaitingStatusContent(
//                waitingDto.getWaitingSeq(), STATUS_CHANGE).orElse(null);
//        if (waitingStatus != null){
//            return -1;
//        }

        if(redisService.getStatus(waitingDto.getWaitingSeq()) != STATUS_WAITING) return -1;

        Integer waitingNo = getLastWaitingNo(waitingDto.getRestaurantSeq()) + 1;
        // 대기리스트에서 삭제
        WaitingHistoryDto waitingHistoryDto = redisService.deleteWaiting(waitingDto.getRestaurantSeq(), waitingDto.getWaitingSeq(), STATUS_CHANGE);
        // 맨뒤에 추가
        waitingDto.setWaitingNo(waitingNo);
        waitingRepository.save(waitingDto.toEntity());
        WaitingStatusDto statusDto = new WaitingStatusDto();
        statusDto.setWaitingSeq(waitingDto.getWaitingSeq());
        statusDto.setWaitingStatusContent(STATUS_CHANGE);
        statusDto.setWaitingStatusRegistDate(DateTimeUtils.nowFromZone());

        try{
            waitingHistoryDto.setWaitingNo(waitingNo);
            waitingHistoryDto.setWaitingStatusContent(STATUS_CHANGE);
            redisService.putRedisList(waitingDto.getRestaurantSeq(), waitingHistoryDto);
        }catch (JsonProcessingException e){
            log.error("registWaiting error!!!!");
        }

        // 상태 저장
        waitingStatusRepository.save(statusDto.toEntity());

        return waitingDto.getWaitingSeq();
    }

    /* 웨이팅 상세정보 조회 */
    @Override
    public WaitingDetailDto getWaiting(Integer waitingSeq) {
//        Waiting waiting = waitingRepository.findById(waitingSeq).orElse(null);

        WaitingDetailDto dto = redisService.getWaiting(waitingSeq);
        if(dto == null) return null;
        dto.setWaitingTime(getWaitingTime(dto.getRestaurantSeq(), waitingSeq));
        dto.setWaitingCurRank(getCurrentWaitingRank(dto.getRestaurantSeq(), waitingSeq));

        return dto;
    }





    // ----------------------------------------------------------------------------------------------------



    // 식당 리스트를 받으면 식당 별 대기팀과 웨이팅 시간을 반환
    // restaurnatSeq 는 Long 인데 Redis에서 검색하는 것은 int 이다.
    // 민정이와 함께 테스트 해보자
    @Override
    public RestaurantWaitingStatusResponseDto getRestaurantWaitingStatus(RestaurantWaitingStatusRequestDto requestDto) {

        List<Long> restaurantList = requestDto.getRestaurantList();
        LocalTime inputTime = LocalTime.now();
        // LocalTime inputTime = LocalTime.of(18, 25);

        HashMap<Long, List<Integer>> waitingTimeAndTeamMap = new HashMap<>();
        List<Integer> waitingTimeAndTeam = null;
        for (Long restaurantSeq : restaurantList) {
            int restaurantSeqInt = restaurantSeq.intValue(); // Long -> int
            Integer waitingCnt = redisService.getWaitingCnt(restaurantSeqInt);// 현재 대기 팀 수
            Double ratioValue = redisCacheService.getAverageWaitingTime(restaurantSeqInt, inputTime); // 시간별 예상 대기 시간

            int waitingTime = 0;
            if(waitingCnt == null || ratioValue == null) {
                waitingTime = 0;
                waitingCnt = 0;
            }
            else {
                waitingTime = (int)(waitingCnt * ratioValue); // 예상 대기 시간
            }



            waitingTimeAndTeam = new ArrayList<>();
            waitingTimeAndTeam.add(waitingTime);
            waitingTimeAndTeam.add(waitingCnt);

            waitingTimeAndTeamMap.put(restaurantSeq, waitingTimeAndTeam);
        }

        return RestaurantWaitingStatusResponseDto.builder()
                .waitingTimeAndTeam(waitingTimeAndTeamMap)
                .build();
    }


    /* 식당 리스트를 받으면 식당 별 웨이팅 시간 반환 */
    // 내일 민정이와 함께 테스트
    @Override
    public RestaurantWaitingTimeResponseDto getRestaurantWaitingTime(RestaurantWaitingStatusRequestDto requestDto) {

        List<Long> restaurantList = requestDto.getRestaurantList();
        LocalTime inputTime = LocalTime.now();

        HashMap<Long, Integer> waitingTimeMap = new HashMap<>();

        for (Long restaurantSeq : restaurantList) {
            int restaurantSeqInt = restaurantSeq.intValue(); // Long -> int
            Integer waitingCnt = redisService.getWaitingCnt(restaurantSeqInt);// 현재 대기 팀 수
            Double ratioValue = redisCacheService.getAverageWaitingTime(restaurantSeqInt, inputTime); // 시간별 예상 대기 시간

            int waitingTime = 0;
            if(waitingCnt == null || ratioValue == null) {
                waitingTime = 0;
            }
            else {
                waitingTime = (int)(waitingCnt * ratioValue); // 예상 대기 시간
            }
            waitingTimeMap.put(restaurantSeq, waitingTime);
        }


        return RestaurantWaitingTimeResponseDto.builder()
                .waitingTimeMap(waitingTimeMap)
                .build();
    }

    /* 식당 seq 대기 시간 조회 */
    public WaitingOneResponseDto getOneRestaurantWaitingStatus(Long restaurantSeq) {

        int restaurantSeqInt = restaurantSeq.intValue();

        // LocalTime inputTime = LocalTime.now();
        LocalTime inputTime = LocalTime.of(18, 25);

        Integer waitingCnt = redisService.getWaitingCnt(restaurantSeqInt);// 현재 대기 팀 수
        Double ratioValue = redisCacheService.getAverageWaitingTime(restaurantSeqInt, inputTime); // 시간별 예상 대기 시간


        int waitingTime = 0;
        if(waitingCnt == null || ratioValue == null) {
            waitingTime = 0;
            waitingCnt = 0;
        }
        else {
            waitingTime = (int)(waitingCnt * ratioValue); // 예상 대기 시간
        }

        return WaitingOneResponseDto.builder()
                .waitingTeam(waitingCnt)
                .waitingTime(waitingTime)
                .build();

    }


}//WaitingService
