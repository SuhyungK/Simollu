package com.simollu.UserService.controller;


import com.simollu.UserService.dto.userfork.RegisterUserForkRequestDto;
import com.simollu.UserService.dto.userfork.RegisterUserForkResponseDto;
import com.simollu.UserService.dto.userfork.UserForkPageDto;
import com.simollu.UserService.dto.userfork.UserForkResponseDto;
import com.simollu.UserService.dto.usernickname.RegisterUserNicknameRequestDto;
import com.simollu.UserService.dto.usernickname.RegisterUserNicknameResponseDto;
import com.simollu.UserService.dto.usernickname.UserNicknameResponseDto;
import com.simollu.UserService.dto.userpreference.RegisterUserPreferenceRequestDto;
import com.simollu.UserService.dto.userpreference.RegisterUserPreferenceResponseDto;
import com.simollu.UserService.dto.userpreference.UserPreferenceResponseDto;
import com.simollu.UserService.dto.userstatus.RegisterUserStatusRequestDto;
import com.simollu.UserService.dto.userstatus.RegisterUserStatusResponseDto;
import com.simollu.UserService.dto.userstatus.UserStatusResponseDto;
import com.simollu.UserService.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/")
@CrossOrigin
public class UserController {

    private final UserService userService;
    private final UserForkService userForkService;
    private final UserNicknameService userNicknameService;
    private final UserStatusService userStatusService;
    private final UserPreferenceService userPreferenceService;


    // 회원 포크 내역 등록
    @PostMapping("fork")
    public ResponseEntity<?> registerUserFork(@RequestHeader("AUTHORIZATION") String token,
                                              @RequestBody RegisterUserForkRequestDto registerUserForkRequestDto) {
        RegisterUserForkResponseDto responseDto = userForkService.registerUserForkLog(token, registerUserForkRequestDto);
        return ResponseEntity.ok(responseDto);
    }

    // 회원 포크 내역 최신 조회
    @GetMapping("fork")
    public ResponseEntity<?> getUserFork(@RequestHeader("AUTHORIZATION") String token) {
        UserForkResponseDto userFork = userForkService.getUserFork(token);
        return ResponseEntity.ok(userFork);
    }

    // 회원 포크 내역 페이지 조회
    @GetMapping("fork-page")
    public ResponseEntity<?> getUserForkLog(@RequestHeader("AUTHORIZATION") String token, @RequestParam int page) {
        Page<UserForkPageDto> userForkLog = userForkService.getUserForkLog(token, page);
        return ResponseEntity.ok(userForkLog);
    }

    // 회원 닉네임 등록
    @PostMapping("nickname")
    public ResponseEntity<?> registerUserNickname(@RequestHeader("AUTHORIZATION") String token,
                                                  @RequestBody RegisterUserNicknameRequestDto registerUserNicknameRequestDto) {
        RegisterUserNicknameResponseDto responseDto = userNicknameService.registerUserNickname(token, registerUserNicknameRequestDto);

        return ResponseEntity.ok(responseDto);
    }

    // 회원 닉네임 조회
    @GetMapping("nickname")
    public ResponseEntity<?> getUserNickname(@RequestHeader("AUTHORIZATION") String token) {
        UserNicknameResponseDto responseDto = userNicknameService.getUserNickname(token);
        return ResponseEntity.ok(responseDto);
    }


    // 회원 상태 등록
    @PostMapping("status")
    public ResponseEntity<?> registerUserStatus(@RequestHeader("AUTHORIZATION") String token,
                                                @RequestBody RegisterUserStatusRequestDto requestDto) {
        RegisterUserStatusResponseDto responseDto = userStatusService.registerUserStatus(token, requestDto);
        return ResponseEntity.ok(responseDto);
    }

    // 회원 상태 조회
    @GetMapping("status")
    public ResponseEntity<?> getUserStatus(@RequestHeader("AUTHORIZATION") String token) {
        UserStatusResponseDto responseDto = userStatusService.getUserStatus(token);
        return ResponseEntity.ok(responseDto);
    }

    // 회원 취향 등록
    @PostMapping("preference")
    public ResponseEntity<?> registerUserPreference(@RequestHeader("AUTHORIZATION") String token,
                                                @RequestBody RegisterUserPreferenceRequestDto requestDto) {
        RegisterUserPreferenceResponseDto responseDto = userPreferenceService.registerUserPreference(token, requestDto);
        return ResponseEntity.ok(responseDto);
    }
    
    // 회원 취향 조회
    @GetMapping("preference")
    public ResponseEntity<?> getUserPreference(@RequestHeader("AUTHORIZATION") String token) {
        UserPreferenceResponseDto responseDto = userPreferenceService.getUserPreference(token);
        return ResponseEntity.ok(responseDto);
    }





}













