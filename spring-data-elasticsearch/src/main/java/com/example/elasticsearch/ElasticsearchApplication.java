package com.example.elasticsearch;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import javax.annotation.PostConstruct;
import java.util.TimeZone;
import org.springframework.cloud.openfeign.EnableFeignClients;

//@EnableJpaRepositories(excludeFilters = @ComponentScan.Filter(
//        type = FilterType.ASSIGNABLE_TYPE,
//        classes = MemberSearchRepository.class))
@SpringBootApplication
@EnableFeignClients
public class ElasticsearchApplication {


    @PostConstruct
    void started() {
        TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
    }
    public static void main(String[] args) {
        SpringApplication.run(ElasticsearchApplication.class, args);
    }

}
