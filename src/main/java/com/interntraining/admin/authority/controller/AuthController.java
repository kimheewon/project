package com.interntraining.admin.authority.controller;

import java.util.ArrayList;
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
	
	//권한 목록페이지로 이동
	@RequestMapping(value="/AuthList")
	public ModelAndView AuthList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
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
			if(authItem.get(i).getIntAuthItemNo() == 1) {
				authCheck=1;	//권한 가지고 있음
			}			
		}
		
		if(authCheck == 1) {	//권한 가지고 있으면
			List<AuthInfo> auth = authService.selectAllAuth();	//권한명 모두 가져오기
				
			mav.addObject("authList",auth);
			mav.setViewName("/admin/authority/AuthList");
		}
	
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
		return mav;
	}
		
		
		
		
	//권한 등록페이지로 이동
	@RequestMapping(value="/AuthEnrollForm")
	public ModelAndView AuthEnrollForm(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
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
			if(authItem.get(i).getIntAuthItemNo() == 1) {
				authCheck=1;	//권한 가지고 있음
			}			
		}
		
		if(authCheck == 1) {	//권한 가지고 있으면
			List<AuthItemInfo> item = authService.selectAllAuthItem();	//권항 항목 모두 불러오기
			
			mav.addObject("AuthItem", item);		
			mav.setViewName("/admin/authority/AuthEnroll");
		}
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
			
		
		
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
		
		String[] authItem = request.getParameterValues("items");
		
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
	
	
	//권한 수정 페이지로 이동
	@RequestMapping(value="/AuthUpdateForm")
	public ModelAndView AuthUpdateForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, int authNo) {
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
			if(authItem.get(i).getIntAuthItemNo() == 1) {
				authCheck=1;	//권한 가지고 있음
			}			
		}
		
		if(authCheck == 1) {	//권한 가지고 있으면
			String authName = authService.selectAuthName(authNo);	//권한번호로 권한명 찾기(Auth 테이블에서)
			List<AuthMapp> selectedItems = authService.selectAuthItem(authNo);	//권한번호로 권한항목 찾기(AuthMapp 테이블에서)
			List<AuthItemInfo> item = authService.selectAllAuthItem();	//권항 항목 모두 불러오기
			
			mav.addObject("AuthItem", item);	//불러온 모든 권한 항목들
			mav.addObject("authNo", authNo);
			mav.addObject("authName",authName);	
			mav.addObject("selectedItems", selectedItems);	//저장된 권한 항목들
			mav.setViewName("/admin/authority/AuthUpdate");	//수정페이지로 이동
		}
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
		
		return mav;
	}

	//권한명 이름 중복 체크
	@RequestMapping(value="/UpdateAuthNameCheck", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public int UpdateAuthNameCheck(String name, String no) throws Exception{
	
		int authNo = Integer.parseInt(no); 
		String authName = authService.selectAuthName(authNo);	//권한번호로 권한명 찾기(Auth 테이블에서)
		
		AuthInfo auth = new AuthInfo();
		auth.setStrAuthName(authName);		//기존 권한명
		auth.setStrAuthNameUpdate(name); 	//수정한 권한명
		
		//DB에서 Id 체크
		AuthInfo  inputAuthName = authService.selectUpdateAuthName(auth);
		int check = 0;	//사용해도 되는 id
		if(inputAuthName != null) {
			check = 1;	//DB에 있는 Id 있음(사용 불가)
		}
		else if(authName.equals(name)) {
			check =2;	//기존  권한명
		}
		return check;	
	}
	
	//권한명 수정
	@RequestMapping("/AuthUpdate")
	public ModelAndView AuthUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		String no = request.getParameter("no");//권한번호
		int authNo = Integer.parseInt(no); 
		
		String authName = authService.selectAuthName(authNo);	//권한번호로 권한명 찾기(Auth 테이블에서)
		String inputAuthName = request.getParameter("authName");	//입력한 권한명
		AuthInfo authN = new AuthInfo();
		
		if(!authName.equals(inputAuthName)) {
			authN.setIntAuthNo(authNo);	//권한번호
			authN.setStrAuthNameUpdate(inputAuthName);	//권한명
			authService.updateAuthName(authN);	//다르면 db에 권한명 업데이트			
		}
		
		AuthMapp authMapp = new AuthMapp();		//매핑테이블 객체 생성
		authMapp.setIntAuthNo(authNo);		//권한 번호
		authService.deleteItems(authNo);	//권한 번호로 Mapp 테이블에 있는 데이터 삭제
		
		String[] authItem = request.getParameterValues("items");		//사용자가 선택한 권한 항목 가져옴
		//List<AuthMapp> selectedItems = authService.selectAuthItem(authNo);	//권한번호로 권한항목 DB에서 가져옴(AuthMapp 테이블에서)
		
		for(int i=0; i<authItem.length; i++) {
			int authItemNo = Integer.parseInt(authItem[i]);	//선택한 권한 항목번호			
			authMapp.setIntAuthItemNo(authItemNo);		//권한 항목번호 객체에 담기
			authService.insertAuthMapp(authMapp);	//매핑테이블에 저장		
		}
		
		List<AuthInfo> auth = authService.selectAllAuth();	//권한명 모두 가져오기
		
		mv.addObject("authList",auth);
		mv.setViewName("/admin/authority/AuthList");	
	
		
		return mv;
	}
	
}
