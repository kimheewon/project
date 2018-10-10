package com.interntraining.admin.administrator.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.administrator.domain.AdministratorInfo;
import com.interntraining.admin.administrator.service.AdministratorService;


/*
 * 관리자 관리
 * 	- 등록
 * 	- 상세보기
 *  - 수정
 *  
 */

@Controller
@RequestMapping(value= "/Administrator")
public class AdministratorController {

	@Autowired
	private AdministratorService administratorService;
	
	//관리자 로그인 확인
	@RequestMapping(value="/AdministratorList")
	public ModelAndView administratorList (HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<AdministratorInfo> list = administratorService.selectAdminList();
		
		mav.addObject("adminList", list);
		//mav.setViewName("/admin/administrator/AdminManagement");	//오른쪽 위 관리자 클릭시 안됨
		//mav.setViewName("/admin/administrator/aa");
		return mav;
	}
}
