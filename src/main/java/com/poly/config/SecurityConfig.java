package com.poly.config;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.poly.auth.UserRootService;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {
  private final UserRootService userRootService;
  //private final CustomOAuth2UserService customOAuth2UserService;

  @Bean
  public BCryptPasswordEncoder getPasswordEncoder() {
    return new BCryptPasswordEncoder();
  }
  @Bean()
  public AuthenticationManager authenticationManagerBean(AuthenticationConfiguration authConfig) throws Exception {
    return authConfig.getAuthenticationManager();
  }
  @Bean
  public DaoAuthenticationProvider authenticationProvider() {
    DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
    authProvider.setUserDetailsService(userRootService);
    authProvider.setPasswordEncoder(getPasswordEncoder());
    return authProvider;
  }
  
  @Bean
  public PasswordEncoder passwordEncoder() {
      return new BCryptPasswordEncoder();
  }

  @Bean
  public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    return http
        .csrf(AbstractHttpConfigurer::disable)
        .authorizeHttpRequests(
            req -> req
                .requestMatchers("/admin/*","/booking/views/*").authenticated()
                .requestMatchers("/account/change-password").permitAll()
                .anyRequest().permitAll())
        .formLogin(form -> form
            .loginPage("/index/login")
            .usernameParameter("username")
            .passwordParameter("password")
            .loginProcessingUrl("/account/login-check")
            .defaultSuccessUrl("/account/login/success")
            .failureUrl("/account/login/failure"))
//        .oauth2Login(ou -> ou
//            .authorizationEndpoint(e -> e.baseUri("/oauth2/authorization"))
//            .redirectionEndpoint(e -> e.baseUri("/login/oauth2/code/*"))
//            .userInfoEndpoint(e -> e.userService(customOAuth2UserService)))
        .exceptionHandling(e -> e.accessDeniedPage("/accessDenied"))
        .build();
  }
 
}
