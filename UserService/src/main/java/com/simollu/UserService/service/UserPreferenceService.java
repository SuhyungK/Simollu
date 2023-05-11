package com.simollu.UserService.service;


import com.simollu.UserService.dto.user.UserInfoJwtDto;
import com.simollu.UserService.dto.userpreference.RegisterUserPreferenceRequestDto;
import com.simollu.UserService.dto.userpreference.RegisterUserPreferenceResponseDto;
import com.simollu.UserService.dto.userpreference.UserPreferenceResponseDto;
import com.simollu.UserService.entity.UserPreference;
import com.simollu.UserService.jwt.TokenProvider;
import com.simollu.UserService.repository.UserPreferenceRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class UserPreferenceService {

    private final UserPreferenceRepository userPreferenceRepository;
    private final TokenProvider tokenProvider;


    // 회원 취향 삽입
    public RegisterUserPreferenceResponseDto registerUserPreference(String userSeq,
                                                                    RegisterUserPreferenceRequestDto requestDto) {



        // 기존 회원 취향 삭제
        userPreferenceRepository.deleteAllByUserSeq(userSeq);

        List<UserPreference> userPreferenceList = new ArrayList<>();

        for (String preferenceType : requestDto.getUserPrefernceList()) {
            UserPreference userPreference = UserPreference.builder()
                    .userSeq(userSeq)
                    .userPreferenceType(preferenceType)
                    .build();

            userPreferenceList.add(userPreference);
        }

        // 저장된 취향들을 반환하기 위해 저장
        List<UserPreference> save = userPreferenceRepository.saveAll(userPreferenceList);

        // 응답 DTO에 저장된 취향들을 설정
        List<String> saveList = new ArrayList<>();
        for (UserPreference one : save) {
            saveList.add(one.getUserPreferenceType());
        }
        
        RegisterUserPreferenceResponseDto responseDto = RegisterUserPreferenceResponseDto.builder()
                .userSeq(userSeq)
                .userPrefernceList(saveList)
                .build();

        return responseDto;
    }

    // 회원 취향 조회
    public UserPreferenceResponseDto getUserPreference(String userSeq) {


        List<UserPreference> userPreferences = userPreferenceRepository.findAllByUserSeq(userSeq);

        List<String> userPreferenceList = userPreferences.stream()
                .map(UserPreference::getUserPreferenceType)
                .collect(Collectors.toList());


        return UserPreferenceResponseDto.builder()
                .userSeq(userSeq)
                .userPrefernceList(userPreferenceList)
                .build();
    }




}
