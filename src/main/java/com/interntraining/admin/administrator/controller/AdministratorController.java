package com.interntraining.admin.administrator.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.administrator.domain.AdministratorInfo;
import com.interntraining.admin.administrator.service.AdministratorService;
import com.interntraining.admin.authority.domain.AuthInfo;
import com.interntraining.member.user.domain.Member;


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
		
		String grade = null;
		for(int i=0; i<list.size(); i++) {
			AdministratorInfo objAdmInfo = list.get(i);
			grade = administratorService.selectAuth(objAdmInfo.getIntAdminAuth()); 
			objAdmInfo.setStrAdminGrade(grade);
			list.set(i, objAdmInfo);
		}
					
		mav.addObject("adminList", list);
		mav.setViewName("/admin/administrator/AdminManagement");	//오른쪽 위 관리자 클릭시 안됨
		return mav;
	}
	
	//관리자 등록 페이지로 이동
	@RequestMapping(value="/AdministratorEnrollForm")
	public ModelAndView AdminEnrollForm() {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<AuthInfo> auth = administratorService.selectAllAuth();	//권한명 모두 가져오기
		
		mav.addObject("authList", auth);
		mav.setViewName("/admin/administrator/AdminEnroll");
		return mav;
	}
	
	//관리자 등록시 아이디 체크
	@RequestMapping(value="/AdministratorIdCheck", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public int AdminIdCheck(String id) throws Exception{
		//DB에서 Id 체크
		AdministratorInfo adminId = administratorService.selectId(id);
		int check = 0;
		if(adminId != null) {
			check = 1;	//DB에 id 있음
		}				
		return check;	
	}
	
	//관리자 등록
	@RequestMapping(value="/Enroll", method=RequestMethod.POST)
	public ModelAndView AdminEnroll(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		String id = request.getParameter("admin_Id");
		String password = request.getParameter("admin_Pw");
		String name = request.getParameter("admin_Name");
		String auth_s = request.getParameter("admin_Auth");
		int auth =  Integer.parseInt(auth_s);
		String phone = request.getParameter("admin_Phone");
		String email = request.getParameter("admin_Email");
		String grade = administratorService.selectAuth(auth); 
		
		
		AdministratorInfo admin = new AdministratorInfo();
		admin.setStrAdminId(id);
		admin.setStrAdminPw(password);
		admin.setStrAdminName(name);
		admin.setStrAdminGrade(grade);	//권한명
		admin.setStrAdminPhone(phone);
		admin.setStrAdminEmail(email);
		admin.setIntAdminAuth(auth);
		
		administratorService.insertAdmin(admin);	//관리자 등록
		
		List<AdministratorInfo> listA = administratorService.selectAdminList();
		
		
		for(int i=0; i<listA.size(); i++) {
			AdministratorInfo objAdmInfo = listA.get(i);
			grade = administratorService.selectAuth(objAdmInfo.getIntAdminAuth()); 
			objAdmInfo.setStrAdminGrade(grade);
			listA.set(i, objAdmInfo);
		}
		
		mav.addObject("adminList", listA);
		mav.setViewName("/admin/administrator/AdminManagement");	//오른쪽 위 관리자 클릭시 안됨
		return mav;
	}
	

}
