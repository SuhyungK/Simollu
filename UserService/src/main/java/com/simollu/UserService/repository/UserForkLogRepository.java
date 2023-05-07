package com.simollu.UserService.repository;

import com.simollu.UserService.entity.UserForkLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserForkLogRepository extends JpaRepository<UserForkLog, Long> {

    // 가장 최근의 내역 가져오기
    UserForkLog findTopByUserSeqOrderByUserForkRegisterDateDesc(String userSeq);

}
