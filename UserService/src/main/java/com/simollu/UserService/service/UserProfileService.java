package com.simollu.UserService.service;


import com.simollu.UserService.dto.user.UserInfoJwtDto;
import com.simollu.UserService.dto.userprofile.UserProfileResponseDto;
import com.simollu.UserService.entity.UserNickname;
import com.simollu.UserService.entity.UserProfile;
import com.simollu.UserService.jwt.TokenProvider;
import com.simollu.UserService.repository.UserProfileRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class UserProfileService {

    private final UserProfileRepository userProfileRepository;

    private final TokenProvider tokenProvider;

    public UserProfileResponseDto getUserProfileImage(String userSeq) {


        UserProfile userProfile = userProfileRepository.findTopByUserSeqOrderByUserProfileRegisterDateDesc(userSeq);

        return UserProfileResponseDto.builder()
                .userProfileUrl(userProfile.getUserProfileUrl())
                .build();
    }

}
