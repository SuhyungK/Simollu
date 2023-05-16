package com.simollu.UserService.service;


import com.simollu.UserService.aws.AwsS3Repository;
import com.simollu.UserService.dto.userprofile.UserProfileResponseDto;
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
    private final AwsS3Repository awsS3Repository;

    public UserProfileResponseDto getUserProfileImage(String userSeq) {


        UserProfile userProfile = userProfileRepository.findTopByUserSeqOrderByUserProfileRegisterDateDesc(userSeq);

        return UserProfileResponseDto.builder()
                .userProfileUrl(awsS3Repository.getTemporaryUrl(userProfile.getUserProfileUrl()))
                .build();
    }

    public Void updateUserProfileImage(String userSeq, String originalFilename) {
        UserProfile userProfile = UserProfile.builder()
                .userSeq(userSeq)
                .userProfileUrl("profile/"+originalFilename)
                .build();
        userProfileRepository.save(userProfile);

        return null;
    }


}
