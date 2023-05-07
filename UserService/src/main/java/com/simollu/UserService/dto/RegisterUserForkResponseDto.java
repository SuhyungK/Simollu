package com.simollu.UserService.dto;


import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDateTime;

@Data
@Builder
public class RegisterUserForkResponseDto {

    private long userForkSeq;
    private String userSeq;
    private int userForkAmount;
    private int userForkBalance;
    private String userForkType;
    private String userForkContent;
    private String userForkRegisterDate;


}
