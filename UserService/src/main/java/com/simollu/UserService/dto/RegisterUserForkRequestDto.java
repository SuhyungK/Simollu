package com.simollu.UserService.dto;


import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RegisterUserForkRequestDto {

    private int userForkAmount;
    private String userForkType;
    private String userForkContent;

}
