package com.simollu.UserService.repository;

import com.simollu.UserService.entity.UserNickname;
import com.simollu.UserService.entity.UserProfile;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserProfileRepository extends JpaRepository<UserProfile, Long> {

    // 가장 최근의 내역 가져오기
    UserProfile findTopByUserSeqOrderByUserProfileRegisterDateDesc(String userSeq);

}
