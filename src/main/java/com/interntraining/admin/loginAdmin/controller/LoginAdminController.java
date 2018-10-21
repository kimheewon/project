package com.interntraining.admin.loginAdmin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.authority.domain.AuthMapp;
import com.interntraining.admin.loginAdmin.domain.LoginAdminInfo;
import com.interntraining.admin.loginAdmin.service.LoginAdminService;
import com.interntraining.member.board.domain.Board;

/*
 * 관리자 로그인 관리
 * 	- 로그인
 * 	- 로그아웃
 * 
 */
@Controller
@RequestMapping(value= "/loginAdmin")
public class LoginAdminController {
	
	@Autowired
	private LoginAdminService loginAdminService;
	
	//관리자 로그인 
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		//로그인 폼에서 id와 pw 가져옴
		String id = request.getParameter("AdminId");
		String password = request.getParameter("Password");
			
		
		//AdminLogin: 관리자 로그인 정보 저장 세션
		if(session.getAttribute("AdminLogin") != null) {
			//기존에 login이란 세션 값이 존재한다면
			session.removeAttribute("AdminLogin");	//기존값 제거
		}
			
		LoginAdminInfo admin = new LoginAdminInfo();
		
		//로그인 성공
			
		if(loginAdminService.logincheck(id, password)) {
			admin = loginAdminService.selectOne(id);		//로그인 성공시 정보 담아놓음
			session.setAttribute("AdminLogin", admin);	//세션에 admin이란 이름으로 관리자 객체를 저장함
			session.setAttribute("AdminId", admin.getStrAdminId());
			int authno = admin.getIntAuthNo();
			session.setAttribute("AuthNo", authno); 	//권한 번호
			List<AuthMapp> authItem = loginAdminService.selectItemList(authno);	//권항 항목 가져오기
			session.setAttribute("items", authItem); //권한 매핑 테이블 세션에 담기
			
			//오늘의 가입자수
			int enrollCount = loginAdminService.enrollCount();			
			mv.addObject("enrollCount",enrollCount);
			
			//오늘의 게시물 수
			int boardCount = loginAdminService.boardCount();
			int totalBoardCount = loginAdminService.totalBoardCount();
			
			int boardCountP = (boardCount*100)/totalBoardCount;
			mv.addObject("boardCountP", boardCountP);
			mv.addObject("boardCount", boardCount);
			
			
			//남녀 가입률			
			String word;
			word="남성";
			int men = loginAdminService.count(word);//남자 가입자 수 가져오기
			
			word="여성";
			int women = loginAdminService.count(word);//여자 가입자 수 가져오기
			
			int total = men+women;
			
			int menP = (men*100)/total;	//남자 퍼센트
			int womenP = (women*100)/total;//여자 퍼센트
			
			int enrollP = (enrollCount*100)/total;
			
			mv.addObject("enrollP",enrollP);
			mv.addObject("men",men);
			mv.addObject("women",women);
			mv.addObject("menP", menP);
			mv.addObject("womenP", womenP);
			
			
			//게시글 Top 10			
			List<Board> boardList = loginAdminService.getBoadList();
			//vip 회원 구분
	        for(int i=0; i<boardList.size(); i++){
	        	String idG = boardList.get(i).getStrUserId();
	        	String grade = loginAdminService.getUserGrade(idG); //id로 유저의 등급 찾기
	        	boardList.get(i).setStrGrade(grade);
	        }
	        
			
			 //날짜 변환+new
	        Date dateB = new Date();
	        String boardDate;
	       	        
	        Date today = new Date();
	        SimpleDateFormat date = new SimpleDateFormat("yyy/MM/dd");
	        SimpleDateFormat dateTime = new SimpleDateFormat("hh:mm a",Locale.US);
	        int check;
	        for(int j=0; j<10;j++) {
	        	dateB = boardList.get(j).getDateBoardDate();
	        	check=0;
	        	
		        if(! date.format(today).equals(date.format(dateB))) {	//오늘 쓴 글이 아니면
		        	boardDate = date.format(dateB);
		        	boardList.get(j).setStrBoardDate(boardDate);
		        }
		        else {	//오늘 쓴 글이면
		        	check=1;
		        	boardDate=dateTime.format(dateB);
		        	boardList.get(j).setStrBoardDate(boardDate);
		        	boardList.get(j).setIntNewCheck(check); //오늘 글인지 확인 new
		        }
		    }
			
			
			mv.addObject("boardlist", boardList);			
			
			
			
			mv.setViewName("/admin/login/AdminHome");//로그인 성공시 관리자 홈화면으로 이동			
		}
		else{//로그인 실패
			mv.setViewName("/admin/login/login_admin");		//로그인 실패시 관리자 로그인 폼 화면으로 이동
		}
		return mv;
	}
	
	//로그아웃
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) throws Exception{
		session.invalidate();    //세션 전체를 날려버림
		return "/admin/login/login_admin";
	}	
		

	//홈 화면으로 이동
	@RequestMapping(value="/home")
	public ModelAndView home(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		String id = (String) session.getAttribute("AdminId");
		if(id != null) {
		
			//오늘의 가입자수
			int enrollCount = loginAdminService.enrollCount();			
			mv.addObject("enrollCount",enrollCount);
			
			//오늘의 게시물 수
			int boardCount = loginAdminService.boardCount();
			int totalBoardCount = loginAdminService.totalBoardCount();
			
			int boardCountP = (boardCount*100)/totalBoardCount;
			mv.addObject("boardCountP", boardCountP);
			mv.addObject("boardCount", boardCount);
			
			
			//남녀 가입률			
			String word;
			word="남성";
			int men = loginAdminService.count(word);//남자 가입자 수 가져오기
			
			word="여성";
			int women = loginAdminService.count(word);//여자 가입자 수 가져오기
			
			int total = men+women;
			
			int menP = (men*100)/total;	//남자 퍼센트
			int womenP = (women*100)/total;//여자 퍼센트
			
			int enrollP = (enrollCount*100)/total;
			
			mv.addObject("enrollP",enrollP);
			mv.addObject("men",men);
			mv.addObject("women",women);
			mv.addObject("menP", menP);
			mv.addObject("womenP", womenP);
			
			
			//게시글 Top 10			
			List<Board> boardList = loginAdminService.getBoadList();
			//vip 회원 구분
	        for(int i=0; i<boardList.size(); i++){
	        	String idG = boardList.get(i).getStrUserId();
	        	String grade = loginAdminService.getUserGrade(idG); //id로 유저의 등급 찾기
	        	boardList.get(i).setStrGrade(grade);
	        }
	        //날짜 변환+new
	        Date dateB = new Date();
	        String boardDate;
	       	        
	        Date today = new Date();
	        SimpleDateFormat date = new SimpleDateFormat("yyy/MM/dd");
	        SimpleDateFormat dateTime = new SimpleDateFormat("hh:mm a",Locale.US);
	        int check;
	        for(int j=0; j<10;j++) {
	        	dateB = boardList.get(j).getDateBoardDate();
	        	check=0;
	        	
		        if(! date.format(today).equals(date.format(dateB))) {	//오늘 쓴 글이 아니면
		        	boardDate = date.format(dateB);
		        	boardList.get(j).setStrBoardDate(boardDate);
		        }
		        else {	//오늘 쓴 글이면
		        	check=1;
		        	boardDate=dateTime.format(dateB);
		        	boardList.get(j).setStrBoardDate(boardDate);
		        	boardList.get(j).setIntNewCheck(check); //오늘 글인지 확인 new
		        }
		    }
	        
			mv.addObject("boardlist", boardList);		
			
			mv.setViewName("/admin/login/AdminHome");//로그인 성공시 관리자 홈화면으로 이동
			
	
		}
		else{//로그인 실패
			mv.setViewName("/admin/login/login_admin");		//로그인 실패시 관리자 로그인 폼 화면으로 이동
		}
		return mv;
	}
		
}	
	
	

