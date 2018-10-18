package com.interntraining.admin.membership.controller;

import java.util.List;

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

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.interntraining.admin.authority.domain.AuthMapp;
import com.interntraining.admin.membership.domain.MembershipInfo;
import com.interntraining.admin.membership.service.MembershipService;

/*
 * 회원 관리
 * 	- 등록
 *  - 수정
 *  
 */

@Controller
@RequestMapping(value= "/Membership")
public class MembershipController {
	@Autowired
	private MembershipService membershipService;

	//회원 목록 페이지로 이동
	@RequestMapping(value="/MembershipList")
	public ModelAndView membershipList(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
	
		/*
		 * 권한 제어		
		 * - 로그인한 관리자가 해당 권한 가지고 있는지 확인
		 * 
		 */
		
		@SuppressWarnings("unchecked")
		List<AuthMapp> authItem =  (List<AuthMapp>) session.getAttribute("items");
	
		int authCheck=0;	//권한 가지고 있는 체크
		
		for(int i=0; i<authItem.size(); i++) {
			if(authItem.get(i).getIntAuthItemNo() == 3) {
				authCheck=1;	//권한 가지고 있음
			}			
		}
		
		if(authCheck == 1) {	//권한 가지고 있으면
		
			List<MembershipInfo> list = membershipService.selectAllMember(); //DB에 저장된 회원들의 정보 모두 가져오기			
			
			mav.addObject("userList",list);
			mav.setViewName("/admin/membership/MembershipList");
		}
		
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
		return mav;
	}
	
	//회원 정보 상세보기 페이지로 이동
	@RequestMapping(value="/MembershipRead")
	public ModelAndView membershipRead(int intUserNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		/*
		 * 권한 제어		
		 * - 로그인한 관리자가 해당 권한 가지고 있는지 확인
		 * 
		 */
		
		@SuppressWarnings("unchecked")
		List<AuthMapp> authItem =  (List<AuthMapp>) session.getAttribute("items");
	
		int authCheck=0;	//권한 가지고 있는 체크
		
		for(int i=0; i<authItem.size(); i++) {
			if(authItem.get(i).getIntAuthItemNo() == 3) {
				authCheck=1;	//권한 가지고 있음
			}			
		}
		
		if(authCheck == 1) {	//권한 가지고 있으면
			MembershipInfo member = membershipService.selectMember(intUserNo);//회원 번호를 통해 DB에서 회원 정보 받아오기
			
			mav.addObject("intUserNo", intUserNo);
			mav.addObject("member",member);
			mav.setViewName("/admin/membership/MembershipRead");
		}
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}		
		return mav;
		
	}
	
	//회원 정보 등록 페이지로 이동
	@RequestMapping(value="/MembershipEnrollForm")
	public ModelAndView membershipEnrollForm(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		/*
		 * 권한 제어		
		 * - 로그인한 관리자가 해당 권한 가지고 있는지 확인
		 * 
		 */
		
		@SuppressWarnings("unchecked")
		List<AuthMapp> authItem =  (List<AuthMapp>) session.getAttribute("items");
	
		int authCheck=0;	//권한 가지고 있는 체크
		
		for(int i=0; i<authItem.size(); i++) {
			if(authItem.get(i).getIntAuthItemNo() == 3) {
				authCheck=1;	//권한 가지고 있음
			}			
		}
		
		if(authCheck == 1) {	//권한 가지고 있으면
			mav.setViewName("/admin/membership/MembershipEnroll");
		}
		
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
		return mav;
		
	}
	
	//아이디 체크
	@RequestMapping(value="/MembershipIdCheck", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody	
	public int idCheck(String id) throws Exception{
		//DB에서 Id 체크
		String userId = membershipService.checkId(id);
		
		int check = 0;
		if(userId != null) {
			check = 1;	//아이디 중복
		}				
		return check;	
	}
	
	
	//회원 정보 등록	
	@RequestMapping(value="MembershipEnroll", method=RequestMethod.POST)
	public ModelAndView membershipEnroll(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
				
		//회원 정보 받아오기
		String id = request.getParameter("id");
		String pw = request.getParameter("pw1");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String sex = request.getParameter("gender");
		String grade = request.getParameter("select_grade");
		
		//객체 생성
		MembershipInfo member = new MembershipInfo();
		
		//객체에 담기
		member.setStrUserId(id);
		member.setStrUserPw(pw);
		member.setStrUserName(name);
		member.setStrUserPhone(phone);
		member.setStrUserEmail(email);
		member.setStrUserSex(sex);
		member.setStrUserGrade(grade);
		
		//회원 정보 DB에 저장
		membershipService.insertMember(member);
		
		//목록페이지로 이동
		List<MembershipInfo> list = membershipService.selectAllMember(); //DB에 저장된 회원들의 정보 모두 가져오기
		
		
		mav.addObject("userList",list);
		mav.setViewName("/admin/membership/MembershipList");
		
		return mav;
	}
	
	
	//회원 정보 수정 페이지로 이동
	@RequestMapping(value="/MembershipUpdateForm")
	public ModelAndView membershipUpdateForm(int intUserNo, HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		/*
		 * 권한 제어		
		 * - 로그인한 관리자가 해당 권한 가지고 있는지 확인
		 * 
		 */
		
		@SuppressWarnings("unchecked")
		List<AuthMapp> authItem =  (List<AuthMapp>) session.getAttribute("items");
	
		int authCheck=0;	//권한 가지고 있는 체크
		
		for(int i=0; i<authItem.size(); i++) {
			if(authItem.get(i).getIntAuthItemNo() == 3) {
				authCheck=1;	//권한 가지고 있음
			}			
		}
		
		if(authCheck == 1) {	//권한 가지고 있으면
		
			MembershipInfo member = membershipService.selectMember(intUserNo);//회원 번호를 통해 DB에서 회원 정보 받아오기
			
			mav.addObject("intUserNo", intUserNo);
			mav.addObject("member",member);
			mav.setViewName("/admin/membership/MembershipUpdate");
		}
		
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
		return mav;		
	}
	
	//회원 정보 수정
	@RequestMapping(value="/MembershipUpdate", method=RequestMethod.POST)
	public ModelAndView membershipUpdate(int intUserNo, HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		//수정한 정보들 받아오기
		String pw = request.getParameter("pw1");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String sex = request.getParameter("gender");
		String grade = request.getParameter("select_grade");
			
		//객체 생성
		MembershipInfo member = new MembershipInfo();
		
		//객체에 넣기
		member.setIntUserNo(intUserNo);
		member.setStrUserPw(pw);
		member.setStrUserName(name);
		member.setStrUserPhone(phone);
		member.setStrUserEmail(email);
		member.setStrUserSex(sex);
		member.setStrUserGrade(grade);
		
		//회웑 정보 번호를 통해 DB에 수정한 정보들 업데이트
		membershipService.updateMember(member);
		
		//수정완료후 목록 페이지로 이동
		List<MembershipInfo> list = membershipService.selectAllMember(); //DB에 저장된 회원들의 정보 모두 가져오기
		
		
		mav.addObject("userList",list);
		mav.setViewName("/admin/membership/MembershipList");
		return mav;		
		
	}
}
