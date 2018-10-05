package com.interntraining.member.user.controller;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;


import com.interntraining.member.user.service.UserService;




/*
 * 회원 정보 관리
 * 	- 회원 가입
 * 	- 회원 정보 수정
 * 
 */
@Controller
@RequestMapping(value = "/")
public class UserController {

	@Autowired
	private UserService userService;
	
	
	//회원가입
	@RequestMapping("joinForm")
    public String joinForm(){		
        return "/login/sample";
    }
	
	//회원정보 저장
	@RequestMapping(value = "joinsave.do")
	public ModelAndView joinSave() {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		return mav;
		
	}
	
	
	
		
}
