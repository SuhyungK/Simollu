package com.simollu.UserService.dto;


import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RegisterUserRequestDto {

    private String userKakao;
    private String userProfileUrl;
    private String userNicknameContent;



}
