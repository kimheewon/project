package com.interntraining.admin.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.interntraining.admin.user.service.UserService;

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
	
}
