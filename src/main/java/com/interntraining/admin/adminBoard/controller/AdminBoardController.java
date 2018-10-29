package com.interntraining.admin.adminBoard.controller;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.adminBoard.domain.AdminBoardInfo;
import com.interntraining.admin.adminBoard.service.AdminBoardService;
import com.interntraining.admin.authority.domain.AuthMapp;

/*
 * 게시판 관리
 * 	- 목록
 *  - 등록
 * 	- 수정
 *  - 삭제
 */

@Controller
@RequestMapping(value= "/AdminBoard")
public class AdminBoardController {

	@Autowired
	private AdminBoardService adminBoardService;
	
	//게시판 목록 페이지로 이동
	@RequestMapping(value="/AdminBoardList")
	public ModelAndView AdminBoardList(int boardCateNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
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
			if(authItem.get(i).getIntAuthItemNo() == 5) {
				authCheck=1;	//권한 가지고 있음
			}			
		}
		
		
		if(authCheck == 1) {	//권한 가지고 있으면
			List<AdminBoardInfo> Board = adminBoardService.selectAllBoard(boardCateNo);	//게시판 글 모두 가져오기
			String BoardName = adminBoardService.selectBoardName(boardCateNo);			//게시판 명 불러오기
			
			//날짜 변환
	        Date dateB = new Date();
	        String boardDate;
	        
	        Date today = new Date();
	        SimpleDateFormat date = new SimpleDateFormat("yyy/MM/dd");
	        SimpleDateFormat dateTime = new SimpleDateFormat("hh:mm a",Locale.US);
	        int check;
	        for(int j=0; j<Board.size();j++) {
	        	dateB = Board.get(j).getDateBoardDate();
	        	check=0;	            	
		       
		        if(! date.format(today).equals(date.format(dateB))) {	//오늘 쓴 글이 아니면
		        	boardDate = date.format(dateB);
		        	Board.get(j).setStrBoardDate(boardDate);
		        }
		        else {	//오늘 쓴 글이면
		        	check=1;
		        	boardDate=dateTime.format(dateB);
		        	Board.get(j).setStrBoardDate(boardDate);
		        	Board.get(j).setIntNewCheck(check); //오늘 글인지 확인 new
		        }
		    }

			mav.addObject("board", Board);
			mav.addObject("boardName", BoardName);
			mav.setViewName("/admin/board/BoardList");
			
		}
	
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
		
		
		return mav;
		
	}

}
