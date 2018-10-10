package com.interntraining.admin.loginAdmin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.interntraining.admin.loginAdmin.domain.LoginAdminInfo;
import com.interntraining.admin.loginAdmin.service.LoginAdminService;

/*
 * 관리자 로그인 관리
 * 	- 로그인
 * 	- 로그아웃
 * 
 */
@Controller
@RequestMapping(value= "/loginAdmin")
public class LoginAdminController {
	
	@Autowired
	private LoginAdminService loginAdminService;
	
	//관리자 로그인 확인
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception{
		
		//로그인 폼에서 id와 pw 가져옴
		String id = request.getParameter("AdminId");
		String password = request.getParameter("Password");
			
		
		//AdminLogin: 관리자 로그인 정보 저장 세션
		if(session.getAttribute("AdminLogin") != null) {
			//기존에 login이란 세션 값이 존재한다면
			session.removeAttribute("AdminLogin");	//기존값 제거
		}
			
		LoginAdminInfo admin = new LoginAdminInfo();
		
		//로그인 성공
		
		
		if(loginAdminService.logincheck(id, password)) {
			admin = loginAdminService.selectOne(id);		//로그인 성공시 정보 담아놓음
			session.setAttribute("AdminLogin", admin);	//세션에 admin이란 이름으로 관리자 객체를 저장함
			session.setAttribute("AdminId", admin.getStrAdminId());
			
			return "/admin/login/AdminHome";		//로그인 성공시 관리자 홈화면으로 이동			
		}
		else{//로그인 실패
			return "/admin/login/login_admin";		//로그인 실패시 관리자 로그인 폼 화면으로 이동
		}
	}
	
	//로그아웃
		@RequestMapping(value = "/logout")
		public String logout(HttpSession session) throws Exception{
			session.invalidate();    //세션 전체를 날려버림
			return "/admin/login/login_admin";
		}	
		

}	
	
	

