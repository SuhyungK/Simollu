package com.simollu.UserService.controller;


import com.simollu.UserService.dto.userfork.*;
import com.simollu.UserService.dto.usernickname.RegisterUserNicknameRequestDto;
import com.simollu.UserService.dto.usernickname.RegisterUserNicknameResponseDto;
import com.simollu.UserService.dto.usernickname.UserNicknameResponseDto;
import com.simollu.UserService.dto.userpreference.RegisterUserPreferenceRequestDto;
import com.simollu.UserService.dto.userpreference.RegisterUserPreferenceResponseDto;
import com.simollu.UserService.dto.userpreference.UserPreferenceResponseDto;
import com.simollu.UserService.dto.userprofile.UserProfileResponseDto;
import com.simollu.UserService.dto.userstatus.RegisterUserStatusRequestDto;
import com.simollu.UserService.dto.userstatus.RegisterUserStatusResponseDto;
import com.simollu.UserService.dto.userstatus.UserStatusResponseDto;
import com.simollu.UserService.service.*;
import io.swagger.annotations.Api;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
@CrossOrigin
@Slf4j
@Api(tags = "User Controller")
public class UserController {

    private final UserService userService;
    private final UserForkService userForkService;
    private final UserNicknameService userNicknameService;
    private final UserStatusService userStatusService;
    private final UserPreferenceService userPreferenceService;
    private final UserProfileService userProfileService;



    @Operation(summary = "사용자의 fork 를 등록",
            description = "userForkAmount의 +, - 를 기입해야 합니다. ")
    @PostMapping("fork")
    public ResponseEntity<?> registerUserFork(@RequestHeader("userSeq") String userSeq,
                                              @RequestBody RegisterUserForkRequestDto registerUserForkRequestDto) {

        log.info("UserController - registerUserFork 데이터 입력 {}", registerUserForkRequestDto);

        RegisterUserForkResponseDto responseDto = userForkService.registerUserForkLog(userSeq, registerUserForkRequestDto);

        log.info("UserController - registerUserFork 데이터 출력 {}", responseDto);

        return ResponseEntity.ok(responseDto);
    }


    @Operation(summary = "사용자의 fork 를 조회",
            description = "사용자의 현재 fork 수를 조회합니다.")
    @GetMapping("fork")
    public ResponseEntity<?> getUserFork(@RequestHeader("userSeq") String userSeq) {

        log.info("UserController - getUserFork 데이터 입력");

        UserForkResponseDto responseDto = userForkService.getUserFork(userSeq);

        log.info("UserController - getUserFork 데이터 출력 {}", responseDto);

        return ResponseEntity.ok(responseDto);
    }


    // 회원 포크 내역 페이지 조회

    @Operation(summary = "사용자의 fork log 를 조회",
            description = "사용자의 fork 사용 내역들을 페이지로 조회합니다.")
    @GetMapping("fork-list")
    public ResponseEntity<?> getUserForkLogList(@RequestHeader("userSeq") String userSeq) {
        log.info("UserController - 회원 포크 내역 리스트 입력");
        List<UserForkLogListDto> userForkLogList = userForkService.getUserForkLogList(userSeq);
        return ResponseEntity.ok(userForkLogList);
    }


    // 회원 포크 내역 페이지 조회

    @Operation(summary = "사용자의 fork log 를 조회",
            description = "사용자의 fork 사용 내역들을 페이지로 조회합니다.")
    @GetMapping("fork-page")
    public ResponseEntity<?> getUserForkLogPage(@RequestHeader("userSeq") String userSeq, @RequestParam int page) {

        log.info("UserController - 회원 포크 내역 페이지 입력");
        
        Page<UserForkPageDto> userForkLogPage = userForkService.getUserForkLogPage(userSeq, page);

        return ResponseEntity.ok(userForkLogPage);
    }

    // 회원 닉네임 등록


    @Operation(summary = "닉네임 등록",
            description = "회원이 변경하고싶은 닉네임으로 변경합니다..")
    @PostMapping("nickname")
    public ResponseEntity<?> registerUserNickname(@RequestHeader("userSeq") String userSeq,
                                                  @RequestBody RegisterUserNicknameRequestDto registerUserNicknameRequestDto) {

        System.out.println(userSeq);


        RegisterUserNicknameResponseDto responseDto = userNicknameService.registerUserNickname(userSeq, registerUserNicknameRequestDto);

        return ResponseEntity.ok(responseDto);
    }

    
    @Operation(summary = "닉네임 조회",
            description = "현재 회원이 설정한 닉네임을 보여줍니다.")
    @GetMapping("/nickname")
    public ResponseEntity<?> getUserNickname(@RequestHeader("userSeq") String userSeq) {
        UserNicknameResponseDto responseDto = userNicknameService.getUserNickname(userSeq);
        return ResponseEntity.ok(responseDto);
    }



    @Operation(summary = "회원 상태 등록 ",
            description = "이 회원의 활동, 활동 중지 여부를 등록합니다. 0 : 활동 중지  1 : 활동중")
    @PostMapping("status")
    public ResponseEntity<?> registerUserStatus(@RequestHeader("userSeq") String userSeq,
                                                @RequestBody RegisterUserStatusRequestDto requestDto) {
        RegisterUserStatusResponseDto responseDto = userStatusService.registerUserStatus(userSeq, requestDto);
        return ResponseEntity.ok(responseDto);
    }

    // 회원 상태 조회
    @Operation(summary = "회원 상태 조회 ",
            description = "현재 회원이 활동중인지 활동 중지 인지 확인합니다.")
    @GetMapping("status")
    public ResponseEntity<?> getUserStatus(@RequestHeader("userSeq") String userSeq) {
        UserStatusResponseDto responseDto = userStatusService.getUserStatus(userSeq);
        return ResponseEntity.ok(responseDto);
    }

    // 회원 취향 등록
    @Operation(summary = "회원 취향 등록 ",
            description = "List<String>으로 입력받은 취향을 등록합니다.")
    @PostMapping("preference")
    public ResponseEntity<?> registerUserPreference(@RequestHeader("userSeq") String userSeq,
                                                @RequestBody RegisterUserPreferenceRequestDto requestDto) {
        RegisterUserPreferenceResponseDto responseDto = userPreferenceService.registerUserPreference(userSeq, requestDto);
        return ResponseEntity.ok(responseDto);
    }
    
    // 회원 취향 조회
    @Operation(summary = "회원 취향 조회 ",
            description = "이 회원의 취향을 List<Stirng> 형식으로 조회합니다. ")
    @GetMapping("preference")
    public ResponseEntity<?> getUserPreference(@RequestHeader("userSeq") String userSeq) {
        UserPreferenceResponseDto responseDto = userPreferenceService.getUserPreference(userSeq);
        return ResponseEntity.ok(responseDto);
    }


    // 회원 프로필 조회
    @Operation(summary = "회원 프로필 이미지 조회 ",
            description = "현재 회원의 프로필 이미지의 URL을 조회합니다.")
    @GetMapping("profile-image")
    public ResponseEntity<?> getUserProfileImage(@RequestHeader("userSeq") String userSeq) {
        UserProfileResponseDto responseDto = userProfileService.getUserProfileImage(userSeq);
        return ResponseEntity.ok(responseDto);
    }





}













