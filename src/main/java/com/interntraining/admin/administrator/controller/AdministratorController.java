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
import com.interntraining.admin.authority.domain.AuthMapp;
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
	
	//관리자 목록페이지로 이동
	@RequestMapping(value="/AdministratorList")
	public ModelAndView administratorList (HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
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
			if(authItem.get(i).getIntAuthItemNo() == 2) {
				authCheck=1;	//권한 가지고 있음
			}			
		}
		
		if(authCheck == 1) {	//권한 가지고 있으면
			List<AdministratorInfo> list = administratorService.selectAdminList();
			
			String grade = null;
			for(int i=0; i<list.size(); i++) {
				
				AdministratorInfo objAdmInfo = list.get(i);
				grade = administratorService.selectAuth(objAdmInfo.getIntAdminAuth()); 			
				objAdmInfo.setStrAdminGrade(grade);
				list.set(i, objAdmInfo);
				
				//이름 마스킹
				String name = list.get(i).getStrAdminName();
				String firstName = name.substring(0, 1);
				int lastNameStartPoint = name.indexOf(firstName);
				String lastName = name.substring(lastNameStartPoint + 1, name.length());
	 
	            String makers = "";
	 
	            for(int j = 0; j < lastName.length(); j++){
	                makers += "*";
	            }
	 
	            lastName = lastName.replace(lastName, makers);
	            String maskedName = firstName + lastName;

	            list.get(i).setStrAdminName(maskedName);
				
			}
						
			mav.addObject("adminList", list);
			mav.setViewName("/admin/administrator/AdminManagement");	//오른쪽 위 관리자 클릭시 안됨
		}
		
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
		return mav;
	}
	
	//관리자 등록 페이지로 이동
	@RequestMapping(value="/AdministratorEnrollForm")
	public ModelAndView AdminEnrollForm(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
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
			if(authItem.get(i).getIntAuthItemNo() == 2) {
				authCheck=1;	//권한 가지고 있음
			}			
		}
		
		if(authCheck == 1) {	//권한 가지고 있으면
			int AuthNo = (int) session.getAttribute("AuthNo");	//세션에서 권한 번호 가져오기
			List<AuthInfo> auth = administratorService.selectAllAuth();	//권한명 모두 가져오기
			int itemNo = administratorService.selectItemNo(AuthNo);//매핑테이블에서 권한명에 따른 권한 항목 젤 처음꺼 가져오기 
			
			mav.addObject("authList", auth);
			mav.addObject("itemNo", itemNo);
			mav.setViewName("/admin/administrator/AdminEnroll");
		}
		
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
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
		String grade = administratorService.selectAuth(auth); 
		
		
		AdministratorInfo admin = new AdministratorInfo();
		admin.setStrAdminId(id);
		admin.setStrAdminPw(password);
		admin.setStrAdminName(name);
		admin.setStrAdminGrade(grade);	//권한명		
		admin.setIntAdminAuth(auth);
		
		administratorService.insertAdmin(admin);	//관리자 등록
		
		List<AdministratorInfo> listA = administratorService.selectAdminList();	//모든 권한 항목들 가져오기(TAuthItem)
		
		
		for(int i=0; i<listA.size(); i++) {		//리스트에 뿌려줄 관리자들의 정보에서 권한번호를 통해 권한명 찾아 객체에 권한명 저장
			AdministratorInfo objAdmInfo = listA.get(i);
			grade = administratorService.selectAuth(objAdmInfo.getIntAdminAuth()); //권한명 가져오기
			objAdmInfo.setStrAdminGrade(grade);
			listA.set(i, objAdmInfo);
			
			//이름 마스킹
			String nameM = listA.get(i).getStrAdminName();
			String firstName = nameM.substring(0, 1);
			int lastNameStartPoint = nameM.indexOf(firstName);
			String lastName = nameM.substring(lastNameStartPoint + 1, nameM.length());
 
            String makers = "";
 
            for(int j = 0; j < lastName.length(); j++){
                makers += "*";
            }
 
            lastName = lastName.replace(lastName, makers);
            String maskedName = firstName + lastName;

            listA.get(i).setStrAdminName(maskedName);
			
		}
		
		
		
		mav.addObject("adminList", listA);
		mav.setViewName("/admin/administrator/AdminManagement");	
		return mav;
	}
	
	//수정할 권한이 있는지 확인
	@RequestMapping(value="checkItemCount", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public int checkItemCount(String no, HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
		
		int check=0;//수정할 권한 없음
		
		int adminNo = Integer.parseInt(no);	//수정할 관리자의 번호
		int authNo = administratorService.selectAuthNo(adminNo);//수정할 관리자의 번호로 권한 번호 찾기
		int adminAuthNo = (int) session.getAttribute("AuthNo");	//세션에서 권한 번호 가져오기
		
		int itemCount =3;//모든 권한 항목들의 개수 가져오기
		int count = administratorService.selectItemCount(authNo);	//수정할 관리자의 권한 항목의 총 개수
		int count2 = administratorService.selectItemCount(adminAuthNo); //로그인한 관리자의 권한 항목의 총 개수
		
		if(count == itemCount) {		//수정할 관리자의 권한 항목의 총 개수 == 총 권한 항목의 개수(T: 선택인은 마스터)
			if(count2 == itemCount) {	//로그인한 관리자의 권한 항목의 총 개수 == 총 권한 항목의 개수(T: 로그인 관리자는 마스터) 
				check=1;//수정가능
			}
			else {
				check=0; //수정 불가		//F: 로그인 관리자는 마스터아님 
			}
		}
		else {
			check=1;	//그 이외는 수정 가능
		}
		
		return check;
	}
		
	
	//관리자 수정페이지로 이동
	@RequestMapping(value="/UpdateFrom")
	public ModelAndView AdminUpdateForm(HttpServletRequest request, HttpServletResponse response,HttpSession session, int intAdminNo) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		/*
		 * 권한 제어		
		 * - 로그인한 관리자가 해당 권한 가지고 있는지 확인
		 * 
		 */
		
		int loginAuth = (int) session.getAttribute("AuthNo");			
				
		@SuppressWarnings("unchecked")
		List<AuthMapp> authItem =  (List<AuthMapp>) session.getAttribute("items");
	
		int authCheck=0;	//권한 가지고 있는 체크
		
		for(int i=0; i<authItem.size(); i++) {
			if(authItem.get(i).getIntAuthItemNo() == 2) {	//관리자가 관리자 관리 권한 가지고 있으면				
				
				authCheck=1;	//권한 가지고 있음			
			
			}			
		}
		
		//수정할 관리자가 마스터 인지 여부 확인
		int authNo = administratorService.selectAuthNo(intAdminNo);//수정할 관리자의 번호로 권한 번호 찾기
		int count = administratorService.selectItemCount(authNo);	//수정할 관리자의 권한 항목의 총 개수
		int count2 = administratorService.selectItemCount(loginAuth);	//로그인한 관리자의 권한 항목의 총 개수
		
		if(count == 3) {		//수정할 관리자의 권한 항목의 총 개수 == 총 권한 항목의 개수(3)(T: 선택인은 마스터)
			if(count2 == 3) {	//로그인한 관리자의 권한 항목의 총 개수 == 총 권한 항목의 개수(3)(T: 로그인 관리자는 마스터) 
				authCheck=1;//수정가능
			}
			else {
				authCheck=0; //수정 불가		//F: 로그인 관리자는 마스터아님 
			}
		}
		else {
			authCheck=1;	//그 이외는 수정 가능
		}
		
		
		
		if(authCheck == 1) {	//권한 가지고 있으면
			authCheck = 0;
			int AuthNo = (int) session.getAttribute("AuthNo");	//세션에서 권한 번호 가져오기
			List<AuthInfo> auth = administratorService.selectAllAuth();	//권한명 모두 가져오기
			int itemNo = administratorService.selectItemNo(AuthNo);//매핑테이블에서 권한명에 따른 권한 항목 젤 처음꺼 가져오기
			
			AdministratorInfo admin = administratorService.selectAdmin(intAdminNo);//관리자 번호로 관리자 데이터 찾기
			mav.addObject("adminInfo", admin);	//변경할 관리자 정보들
			
			mav.addObject("authList", auth);
			mav.addObject("itemNo", itemNo);
				
			mav.setViewName("/admin/administrator/AdminUpdateForm");
		}
		
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
		return mav;		
	}
	
	//수정된 관리자 정보 업데이트
	@RequestMapping(value="/Update", method=RequestMethod.POST)
	public ModelAndView AdminUpdate(HttpServletRequest request, HttpServletResponse response,HttpSession session){
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		
		String id = request.getParameter("admin_Id");
		String password = request.getParameter("admin_Pw");
		String name = request.getParameter("admin_Name");
		String auth_s = request.getParameter("admin_Auth");
		int auth =  Integer.parseInt(auth_s);		
		String grade = administratorService.selectAuth(auth); //권한명
		
		AdministratorInfo admin = new AdministratorInfo();
		admin.setStrAdminId(id);
		admin.setStrAdminPw(password);
		admin.setStrAdminName(name);	
		admin.setIntAdminAuth(auth);	//권한 번호
		
		administratorService.updateAdmin(admin);	//관리자 정보 업데이트
		
		List<AdministratorInfo> listA = administratorService.selectAdminList();	//모든 권한 항목들 가져오기(TAuthItem)
		
		
		for(int i=0; i<listA.size(); i++) {	
			AdministratorInfo objAdmInfo = listA.get(i);
			grade = administratorService.selectAuth(objAdmInfo.getIntAdminAuth()); //권한명 가져오기
			objAdmInfo.setStrAdminGrade(grade);
			listA.set(i, objAdmInfo);
			
			//이름 마스킹
			String nameM = listA.get(i).getStrAdminName();
			String firstName = nameM.substring(0, 1);
			int lastNameStartPoint = nameM.indexOf(firstName);
			String lastName = nameM.substring(lastNameStartPoint + 1, nameM.length());
 
            String makers = "";
 
            for(int j = 0; j < lastName.length(); j++){
                makers += "*";
            }
 
            lastName = lastName.replace(lastName, makers);
            String maskedName = firstName + lastName;

            listA.get(i).setStrAdminName(maskedName);
		}
		
		mv.addObject("adminList", listA);
		mv.setViewName("/admin/administrator/AdminManagement");	
		
		
		
		return mv;
	}
	
	
}
