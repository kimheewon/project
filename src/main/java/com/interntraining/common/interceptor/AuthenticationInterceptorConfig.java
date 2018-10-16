package com.interntraining.common.interceptor;

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
	        registry.addInterceptor(authenticationInterceptor)
	        		.addPathPatterns("/board/**")		//세션 게시판 검사
	        		.excludePathPatterns("/login/**")	//로그인 세션 검사 X
	        		.excludePathPatterns("/user/**")	//회원가입 세션 검사 X
	        		.excludePathPatterns("/loginAdmin/**")	//관리자 로그인 세션 검사 X
    				.addPathPatterns("/Auth/**")	
	        		.addPathPatterns("/Administrator/**");
	        //addPathPatterns
	   }
	 
}
