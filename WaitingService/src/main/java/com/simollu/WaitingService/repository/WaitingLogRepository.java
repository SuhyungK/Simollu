package com.simollu.WaitingService.repository;


import com.simollu.WaitingService.model.entity.WaitingLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface WaitingLogRepository extends JpaRepository<WaitingLog, Integer> {


}
