package com.simollu.CalculatorService.service;


import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

@Service
@Slf4j
@RequiredArgsConstructor
public class RedisService {

    private final RedisTemplate<String, Object> redisTemplate;


    // redis에 key값 조회
//    public <T> T getRedisValue(Integer restaurantSeq,Class<T> classType) throws JsonProcessingException {
//        String key = RESTAURANT_KEY + restaurantSeq;
//        String redisValue = (String) redisTemplate.opsForValue().get(key);
//        if (ObjectUtils.isEmpty(redisValue)) {
//            return null;
//        }else{
//            return objectMapper.readValue(redisValue,classType);
//        }
//    }


    // redis에 key, value로 push
//    public void putRedis(String key,Object classType) throws JsonProcessingException {
//        redisTemplate.opsForValue().set(key, objectMapper.writeValueAsString(classType));
//    }


}
