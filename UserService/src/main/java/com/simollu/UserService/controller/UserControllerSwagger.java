//package com.simollu.UserService.controller;
//
//
//import com.simollu.UserService.dto.userfork.RegisterUserForkRequestDto;
//import com.simollu.UserService.dto.userfork.RegisterUserForkResponseDto;
//import com.simollu.UserService.dto.userfork.UserForkPageDto;
//import com.simollu.UserService.dto.userfork.UserForkResponseDto;
//import com.simollu.UserService.dto.usernickname.RegisterUserNicknameRequestDto;
//import com.simollu.UserService.dto.usernickname.RegisterUserNicknameResponseDto;
//import com.simollu.UserService.dto.usernickname.UserNicknameResponseDto;
//import com.simollu.UserService.dto.userpreference.RegisterUserPreferenceRequestDto;
//import com.simollu.UserService.dto.userpreference.RegisterUserPreferenceResponseDto;
//import com.simollu.UserService.dto.userpreference.UserPreferenceResponseDto;
//import com.simollu.UserService.dto.userprofile.UserProfileResponseDto;
//import com.simollu.UserService.dto.userstatus.RegisterUserStatusRequestDto;
//import com.simollu.UserService.dto.userstatus.RegisterUserStatusResponseDto;
//import com.simollu.UserService.dto.userstatus.UserStatusResponseDto;
//import com.simollu.UserService.service.*;
//import io.swagger.annotations.ApiOperation;
//import io.swagger.annotations.ApiResponse;
//import io.swagger.annotations.ApiResponses;
//import lombok.RequiredArgsConstructor;
//import org.springframework.data.domain.Page;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//@RestController
//@RequiredArgsConstructor
//@RequestMapping("/")
//@CrossOrigin
//public class UserControllerSwagger {
//
//    private final UserService userService;
//    private final UserForkService userForkService;
//    private final UserNicknameService userNicknameService;
//    private final UserStatusService userStatusService;
//    private final UserPreferenceService userPreferenceService;
//    private final UserProfileService userProfileService;
//
//
//
//    @ApiOperation(value = "회원 포크 내역 최신 조회")
//    @ApiResponses(value = {
//            @ApiResponse(code = 200, message = "성공적으로 회원 포크 내역이 조회되었습니다."),
//            @ApiResponse(code = 401, message = "인증되지 않은 요청입니다."),
//            @ApiResponse(code = 403, message = "권한이 없습니다."),
//            @ApiResponse(code = 500, message = "서버 오류입니다.")
//    })
//    @PostMapping("fork")
//    public ResponseEntity<?> registerUserFork(@RequestHeader("AUTHORIZATION") String token,
//                                              @RequestBody RegisterUserForkRequestDto registerUserForkRequestDto) {
//        RegisterUserForkResponseDto responseDto = userForkService.registerUserForkLog(token, registerUserForkRequestDto);
//        return ResponseEntity.ok(responseDto);
//    }
//
//
//    @ApiOperation(value = "회원 포크 내역 최신 조회")
//    @ApiResponses(value = {
//            @ApiResponse(code = 200, message = "성공적으로 회원 포크 내역이 조회되었습니다."),
//            @ApiResponse(code = 401, message = "인증되지 않은 요청입니다."),
//            @ApiResponse(code = 403, message = "권한이 없습니다."),
//            @ApiResponse(code = 500, message = "서버 오류입니다.")
//    })
//    @GetMapping("fork")
//    public ResponseEntity<?> getUserFork(@RequestHeader("AUTHORIZATION") String token) {
//        UserForkResponseDto userFork = userForkService.getUserFork(token);
//        return ResponseEntity.ok(userFork);
//    }
//
//    // 회원 포크 내역 페이지 조회
//    @ApiOperation(value = "회원 포크 내역 페이지 조회")
//    @ApiResponses(value = {
//            @ApiResponse(code = 200, message = "성공적으로 회원 포크 내역 페이지가 조회되었습니다."),
//            @ApiResponse(code = 401, message = "인증되지 않은 요청입니다."),
//            @ApiResponse(code = 403, message = "권한이 없습니다."),
//            @ApiResponse(code = 500, message = "서버 오류입니다.")
//    })
//    @GetMapping("fork-page")
//    public ResponseEntity<?> getUserForkLog(@RequestHeader("AUTHORIZATION") String token, @RequestParam int page) {
//        Page<UserForkPageDto> userForkLog = userForkService.getUserForkLog(token, page);
//        return ResponseEntity.ok(userForkLog);
//    }
//
//    // 회원 닉네임 등록
//    @ApiOperation(value = "회원 닉네임 등록")
//    @ApiResponses(value = {
//            @ApiResponse(code = 200, message = "성공적으로 회원 닉네임이 등록되었습니다."),
//            @ApiResponse(code = 401, message = "인증되지 않은 요청입니다."),
//            @ApiResponse(code = 403, message = "권한이 없습니다."),
//            @ApiResponse(code = 500, message = "서버 오류입니다.")
//    })
//    @PostMapping("nickname")
//    public ResponseEntity<?> registerUserNickname(@RequestHeader("AUTHORIZATION") String token,
//                                                  @RequestBody RegisterUserNicknameRequestDto registerUserNicknameRequestDto) {
//        RegisterUserNicknameResponseDto responseDto = userNicknameService.registerUserNickname(token, registerUserNicknameRequestDto);
//
//        return ResponseEntity.ok(responseDto);
//    }
//
//    // 회원 닉네임 조회
//    @ApiResponses(value = {
//            @ApiResponse(code = 200, message = "성공적으로 회원 닉네임이 조회되었습니다."),
//            @ApiResponse(code = 401, message = "인증되지 않은 요청입니다."),
//            @ApiResponse(code = 403, message = "권한이 없습니다."),
//            @ApiResponse(code = 500, message = "서버 오류입니다.")
//    })
//    @GetMapping("nickname")
//    public ResponseEntity<?> getUserNickname(@RequestHeader("AUTHORIZATION") String token) {
//        UserNicknameResponseDto responseDto = userNicknameService.getUserNickname(token);
//        return ResponseEntity.ok(responseDto);
//    }
//
//
//    // 회원 상태 등록
//    @ApiOperation(value = "회원 상태 등록")
//    @ApiResponses(value = {
//            @ApiResponse(code = 200, message = "성공적으로 회원 상태가 등록되었습니다."),
//            @ApiResponse(code = 401, message = "인증되지 않은 요청입니다."),
//            @ApiResponse(code = 403, message = "권한이 없습니다."),
//            @ApiResponse(code = 500, message = "서버 오류입니다.")
//    })
//    @PostMapping("status")
//    public ResponseEntity<?> registerUserStatus(@RequestHeader("AUTHORIZATION") String token,
//                                                @RequestBody RegisterUserStatusRequestDto requestDto) {
//        RegisterUserStatusResponseDto responseDto = userStatusService.registerUserStatus(token, requestDto);
//        return ResponseEntity.ok(responseDto);
//    }
//
//    // 회원 상태 조회
//    @ApiOperation(value = "회원 상태 조회")
//    @ApiResponses(value = {
//            @ApiResponse(code = 200, message = "성공적으로 회원 상태가 조회되었습니다."),
//            @ApiResponse(code = 401, message = "인증되지 않은 요청입니다."),
//            @ApiResponse(code = 403, message = "권한이 없습니다."),
//            @ApiResponse(code = 500, message = "서버 오류입니다.")
//    })
//    @GetMapping("status")
//    public ResponseEntity<?> getUserStatus(@RequestHeader("AUTHORIZATION") String token) {
//        UserStatusResponseDto responseDto = userStatusService.getUserStatus(token);
//        return ResponseEntity.ok(responseDto);
//    }
//
//    // 회원 취향 등록
//    @ApiOperation(value = "회원 취향 등록")
//    @ApiResponses(value = {
//            @ApiResponse(code = 200, message = "성공적으로 회원 취향이 등록되었습니다."),
//            @ApiResponse(code = 401, message = "인증되지 않은 요청입니다."),
//            @ApiResponse(code = 403, message = "권한이 없습니다."),
//            @ApiResponse(code = 500, message = "서버 오류입니다.")
//    })
//    @PostMapping("preference")
//    public ResponseEntity<?> registerUserPreference(@RequestHeader("AUTHORIZATION") String token,
//                                                @RequestBody RegisterUserPreferenceRequestDto requestDto) {
//        RegisterUserPreferenceResponseDto responseDto = userPreferenceService.registerUserPreference(token, requestDto);
//        return ResponseEntity.ok(responseDto);
//    }
//
//    // 회원 취향 조회
//    @ApiOperation(value = "회원 취향 조회")
//    @ApiResponses(value = {
//            @ApiResponse(code = 200, message = "성공적으로 회원 취향이 조회되었습니다."),
//            @ApiResponse(code = 401, message = "인증되지 않은 요청입니다."),
//            @ApiResponse(code = 403, message = "권한이 없습니다."),
//            @ApiResponse(code = 500, message = "서버 오류입니다.")
//    })
//    @GetMapping("preference")
//    public ResponseEntity<?> getUserPreference(@RequestHeader("AUTHORIZATION") String token) {
//        UserPreferenceResponseDto responseDto = userPreferenceService.getUserPreference(token);
//        return ResponseEntity.ok(responseDto);
//    }
//
//
//    // 회원 프로필 조회
//    @ApiOperation(value = "회원 프로필 조회")
//    @ApiResponses(value = {
//            @ApiResponse(code = 200, message = "성공적으로 회원 프로필 이미지가 조회되었습니다."),
//            @ApiResponse(code = 401, message = "인증되지 않은 요청입니다."),
//            @ApiResponse(code = 403, message = "권한이 없습니다."),
//            @ApiResponse(code = 500, message = "서버 오류입니다.")
//    })
//    @GetMapping("profile-image")
//    public ResponseEntity<?> getUserProfileImage(@RequestHeader("AUTHORIZATION") String token) {
//        UserProfileResponseDto responseDto = userProfileService.getUserProfileImage(token);
//        return ResponseEntity.ok(responseDto);
//    }
//
//
//
//
//
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
