package com.simollu.UserService.controller;


import com.simollu.UserService.dto.RegisterUserForkRequestDto;
import com.simollu.UserService.dto.RegisterUserForkResponseDto;
import com.simollu.UserService.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/")
@CrossOrigin
public class UserController {

    private final UserService userService;


    @PostMapping("user-fork")
    public ResponseEntity<?> registerUserFork(@RequestHeader("token") String token,
                                              @RequestBody RegisterUserForkRequestDto registerUserForkRequestDto) {
        RegisterUserForkResponseDto responseDto = userService.registerUserForkLog(token, registerUserForkRequestDto);
        return ResponseEntity.ok(responseDto);
    }




}
