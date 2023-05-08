package com.simollu.UserService.service;


import com.simollu.UserService.dto.user.RegisterUserRequestDto;
import com.simollu.UserService.entity.*;
import com.simollu.UserService.jwt.TokenProvider;
import com.simollu.UserService.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Collections;

@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final UserForkLogRepository userForkLogRepository;
    private final UserNicknameRepository userNicknameRepository;
    private final UserProfileRepository userProfileRepository;
    private final UserStatusRepository userStatusRepository;

    private final TokenProvider tokenProvider;


    // 회원가입
    // kakao 에서 kakao_id, nickname, profile 을 제공받는다.
    public User registerUser(RegisterUserRequestDto registerUserRequestDto) {

        // 권한 생성
        Authority authority = Authority.builder()
                .authorityName("ROLE_USER") // ROLE_ 이런 형식으로 권한을 표시해야한다.
                .build();

        // User 값 삽입
        User user = User.builder()
                .userKakao(registerUserRequestDto.getUserKakao())
                .userAuthority(Collections.singleton(authority))
                .build();
        User save = userRepository.save(user);
        String userSeq = save.getUserSeq();

        // 회원 이미지 삽입
        UserProfile userProfile = UserProfile.builder()
                .userSeq(userSeq)
                .userProfileUrl(registerUserRequestDto.getUserProfileUrl())
                .build();
        userProfileRepository.save(userProfile);

        // 회원 닉네임 삽입
        UserNickname userNickname = UserNickname.builder()
                .userSeq(userSeq)
                .userNicknameContent(registerUserRequestDto.getUserNicknameContent())
                .build();
        userNicknameRepository.save(userNickname);

        // 회원 상태 삽입
        UserStatus userStatus = UserStatus.builder()
                .userSeq(userSeq)
                .userStatusContent(1)
                .build();
        userStatusRepository.save(userStatus);

        // 회원 포크 삽입
        UserForkLog userForkLog = UserForkLog.builder()
                .userSeq(userSeq)
                .userForkAmount(3)
                .userForkBalance(3)
                .userForkType("사용")
                .userForkContent("회원 가입")
                .build();
        userForkLogRepository.save(userForkLog);

        return save;
    }


    // 회원 가입 여부 확인
    public boolean checkByKakao(String kakao) {
        return userRepository.existsByUserKakao(kakao);
    }

    // 카카오 아이디로 회원 정보 조회, 권한도 조회
    public User findByUserKakaoWithAuthorities(String userKakao) {
        return userRepository.findByUserKakaoWithAuthorities(userKakao).orElseThrow();
    }















}
