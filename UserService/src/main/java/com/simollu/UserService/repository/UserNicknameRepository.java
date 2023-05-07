package com.simollu.UserService.repository;

import com.simollu.UserService.entity.UserNickname;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserNicknameRepository extends JpaRepository<UserNickname, Long> {
}
