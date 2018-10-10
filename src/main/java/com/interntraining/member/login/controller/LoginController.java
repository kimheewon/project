package com.interntraining.member.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.member.login.domain.User;
import com.interntraining.member.login.service.LoginService;
/*
 * 로그인 관리
 * 	- 로그인
 * 	- 로그아웃
 * 
 */
@Controller
@RequestMapping(value= {"","/login"})
public class LoginController {

	@Autowired
	private LoginService loginService;
	
	//첫화면 - 로그인 화면
	@RequestMapping(value = {"","/","/login"})
	public String initPage() throws Exception {				
		return "/login/loginForm";	
	}
	
	//홈화면으로 이동
	@RequestMapping("/home")
	public String home() throws Exception {				
		return "/login/home";	
	}
	
	//관리자 로그인 화면으로 이동
	@RequestMapping("/adminLoginForm")
	public String adminLoginFrom() throws Exception{
		return "/admin/login/login_admin";
	}
	
	//로그인 처리
	@RequestMapping(value="/login/loginCheck", method=RequestMethod.POST)
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
		if(loginService.logincheck(id, password)) {
			user = loginService.selectOne(id);		//로그인 성공시 정보 담아놓음
			session.setAttribute("login", user);	//세션에 login이란 이름으로 user 객체를 저장함
			session.setAttribute("id", user.getStrUserid());
			
			return "/login/home";			//로그인 성공시 홈화면으로 이동			
		}
		else{//로그인 실패
			return "/login/loginForm";		//로그인 실패시 로그인 폼 화면으로 이동
		}
		
	}	
		
	//로그아웃
	@RequestMapping(value = "/login/logout")
	public String logout(HttpSession session) throws Exception{
		session.invalidate();    //세션 전체를 날려버림
		return "/login/loginForm";
	}	
	
	//마이페이지
	@RequestMapping(value = "/login/myPageForm")
	public ModelAndView myPage(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {			
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		String id = (String) session.getAttribute("id"); // 세션
		
		User user = loginService.myPage(id);
		
		mv.addObject("member", user);
		mv.setViewName("/login/myPage");
		return mv;		
	}
	
	//수정 마이페이지에 회원 정보 뿌리기
	@RequestMapping(value = "/login/myPageUpdateForm")
	public ModelAndView myPageForm(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		String id = (String) session.getAttribute("id"); // 세션
		User user = loginService.myPage(id);
		
		mv.addObject("member", user);
		mv.setViewName("/login/myPageUpdateForm");
		return mv;
	}
	
	//수정 마이페이지 DB에 저장
	@RequestMapping(value="/user/myPageUpdate")
	public ModelAndView myPageUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		String id = (String) session.getAttribute("id"); // 세션
		String password = request.getParameter("pw1");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");

		User user = new User();

		user.setStrUserid(id);
		user.setStrUserPw(password);
		user.setStrUserName(name);
		user.setStrUserPhone(phone);
		user.setStrUserEmail(email);

		
		loginService.updateMember(user);
		
		
		user = loginService.myPage(id);		
		
		mv.addObject("member", user);
		mv.setViewName("/login/myPage");
		return mv;
	}
	
	
}
