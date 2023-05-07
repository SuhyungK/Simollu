package com.simollu.UserService.repository;

import com.simollu.UserService.entity.UserStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserStatusRepository extends JpaRepository<UserStatus, Long> {


}
