package com.simollu.UserService.repository;

import com.simollu.UserService.entity.UserForkLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserForkLogRepository extends JpaRepository<UserForkLog, Long> {

    // 가장 최근의 내역 가져오기
    UserForkLog findTopByUserSeqOrderByUserForkRegisterDateDesc(String userSeq);

    // 전체 내역 페이지로 조회
    Page<UserForkLog> findByUserSeqOrderByUserForkRegisterDateDesc(String userSeq, Pageable pageable);

}
