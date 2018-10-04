package com.interntraining.admin.common.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/*
 * 로그인 인증 Interceptor 설정
 * */

@Configuration
public class AuthenticationInterceptorConfig extends WebMvcConfigurerAdapter{

	   @Autowired
	   private AuthenticationInterceptor authenticationInterceptor;
	   
	   @Override
	   public void addInterceptors(InterceptorRegistry registry) {
	        registry.addInterceptor(authenticationInterceptor).addPathPatterns("/user/controller/UserController/*.do");
	   }
	 
}
