package com.interntraining.admin.authority.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.authority.domain.AuthInfo;
import com.interntraining.admin.authority.domain.AuthItemInfo;
import com.interntraining.admin.authority.domain.AuthMapp;
import com.interntraining.admin.authority.service.AuthService;


/*
 * 권한 관리
 * 	- 목록
 *  - 등록
 * 	- 수정
 *  
 */

@Controller
@RequestMapping(value= "/Auth")
public class AuthController {
	
	@Autowired
	private AuthService authService;
	
	//권한 등록페이지로 이동
	@RequestMapping(value="/AuthEnrollForm")
	public ModelAndView AuthEnrollForm() {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<AuthItemInfo> item = authService.selectAllAuthItem();	//권항 항목 모두 불러오기
		
		mav.addObject("AuthItem", item);		
		mav.setViewName("/admin/authority/AuthEnroll");
		return mav;
	}

	//권한명 이름 중복 체크
	@RequestMapping(value="/AuthNameCheck", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public int AuthNameCheck(String name) throws Exception{
		//DB에서 Id 체크
		AuthInfo authName = authService.selectName(name);
		int check = 0;
		if(authName != null) {
			check = 1;	//DB에 id 있음
		}				
		return check;	
	}
	
	//권한 등록
	@RequestMapping(value="/AuthEnroll", method=RequestMethod.POST)
	public ModelAndView AuthEnroll(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		String authName = request.getParameter("authName");	//권한명
		authService.insertAuthName(authName);		//권한명 저장
	
		int authNo = authService.selectAuthNo(authName);	//권한명 번호 받기
		
		AuthMapp authMapp = new AuthMapp();		//매핑테이블 객체 생성
		authMapp.setIntAuthNo(authNo);
		
		String[] authItem = request.getParameterValues("items[]");
		
		for(int i=0; i<authItem.length; i++) {
			int authItemNo = Integer.parseInt(authItem[i]);	//선택한 권한 항목명			
			authMapp.setIntAuthItemNo(authItemNo);			
			authService.insertAuthMapp(authMapp);	//매핑테이블에 저장			
		}
		
		List<AuthInfo> auth = authService.selectAllAuth();	//권한명 모두 가져오기
				
		mav.addObject("authList",auth);
		mav.setViewName("/admin/authority/AuthList");	
		return mav;
	}
	
	//권한 목록페이지로 이동
	@RequestMapping(value="/AuthList")
	public ModelAndView AuthList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
			
		List<AuthInfo> auth = authService.selectAllAuth();	//권한명 모두 가져오기
		
		mav.addObject("authList",auth);
		mav.setViewName("/admin/authority/AuthList");	
		return mav;
	}

}
