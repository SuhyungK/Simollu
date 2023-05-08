package com.simollu.UserService.config;


import com.simollu.UserService.handler.OAuth2AuthenticationSuccessHandler;
import com.simollu.UserService.oauth.CustomUserOAuth2Service;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.filter.CorsFilter;

import javax.servlet.http.HttpServletResponse;

@EnableWebSecurity
@EnableMethodSecurity
@Configuration
@RequiredArgsConstructor
public class SecurityConfig {

    private final CorsFilter corsFilter;
    private final CustomUserOAuth2Service customUserOAuth2Service;
    private final OAuth2AuthenticationSuccessHandler oAuth2AuthenticationSuccessHandler;


    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
                .csrf().disable()
                .addFilterBefore(corsFilter, UsernamePasswordAuthenticationFilter.class)


                .oauth2Login()
                .userInfoEndpoint()
                .userService(customUserOAuth2Service)


                .and()
                .successHandler(oAuth2AuthenticationSuccessHandler)

                .and()
                .logout()
                .logoutUrl("/logout")
                .logoutSuccessHandler((request, response, authentication) -> {
                    // 로그아웃 성공 시 처리 로직, 예를 들어, 성공 메시지 반환
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Successfully logged out");
                    
                })
                .invalidateHttpSession(true); // 로그아웃 시 현재 세션을 무효화


        return http.build();

    }


}
