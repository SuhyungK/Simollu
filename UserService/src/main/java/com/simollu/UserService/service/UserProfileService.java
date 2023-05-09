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

    public UserProfileResponseDto getUserProfileImage(String token) {
        UserInfoJwtDto userInfo = tokenProvider.getUserInfo(token);

        UserProfile userProfile = userProfileRepository.findTopByUserSeqOrderByUserProfileRegisterDateDesc(userInfo.getUserSeq());

        return UserProfileResponseDto.builder()
                .userProfileUrl(userProfile.getUserProfileUrl())
                .build();
    }

}
