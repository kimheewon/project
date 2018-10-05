package com.interntraining.member.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.interntraining.member.login.domain.User;
import com.interntraining.member.login.service.UserService;

/*
 * 로그인 관리
 * 	- 로그인
 * 	- 로그아웃
 * 
 */
@Controller
@RequestMapping(value="/")
public class LoinController {

	@Autowired
	private UserService userService;
	
	//첫화면 - 로그인 화면
	@RequestMapping(value = "/")
	public String initPage() throws Exception {				
		return "/login/loginForm";	
	}
	
	//로그인 처리
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String login(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception{
			
		//로그인 폼에서 id와 pw 가져옴
		String id = request.getParameter("id");
		String password = request.getParameter("pw");
			
			
		if(session.getAttribute("login") != null) {
			//기존에 login이란 세션 값이 존재한다면
			session.removeAttribute("login");	//기존값 제거
		}
			
		User user = new User();
		//로그인 성공
		if(userService.logincheck(id, password)){
			user = userService.selectOne(id);		//로그인 성공시 정보 담아놓음
			session.setAttribute("login", user);	//세션에 login이란 이름으로 user 객체를 저장함
			session.setAttribute("id", user.getStrUserid());
			return "/login/home";			//로그인 성공시 홈화면으로 이동			
		}
		else{//로그인 실패
			return "/login/loginForm";		//로그인 실패시 로그인 폼 화면으로 이동
		}
		
	}	
		
	//로그아웃
	@RequestMapping(value = "logout.do")
	public String logout(HttpSession session) throws Exception{
		session.invalidate();    //세션 전체를 날려버림
		return "/login/loginForm";
	}	
	
}
