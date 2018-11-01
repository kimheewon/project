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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.adminBoard.domain.AdminBoardInfo;
import com.interntraining.admin.adminBoard.service.AdminBoardService;
import com.interntraining.admin.authority.domain.AuthMapp;
import com.interntraining.member.board.domain.Comment;

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
	        	
	        	String adminId = adminBoardService.selectAdminId(Board.get(j).getIntAdminNo());	//관리자 id 찾기
	        	Board.get(j).setStrAdminId(adminId);
	        	
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
			mav.addObject("boardCateNo", boardCateNo);
			mav.setViewName("/admin/board/BoardList");
			
		}	
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}		
		return mav;		
	}
	
	//게시글 등록 페이지로 이동
	@RequestMapping(value="/AdminBoardEnrollForm")
	public ModelAndView AdminBoardEnrollForm(int boardCateNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		String BoardName = adminBoardService.selectBoardName(boardCateNo);			//게시판 명 불러오기
		
		mav.addObject("boardCateNo", boardCateNo);	//게시판 카테고리 번호
		mav.addObject("boardName", BoardName);		//게시판명
		mav.setViewName("/admin/board/BoardEnroll");
		
		return mav;		
	}
	
	//게시글 등록
	@RequestMapping(value="/AdminBoardEnroll")
	public ModelAndView AdminBoardEnroll(int boardCateNo, AdminBoardInfo adminBoardInfo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
			
		
		int AdminNo =  (int) session.getAttribute("AdminNo");
		
		adminBoardInfo.setIntBoardCateNo(boardCateNo);	//카테고리 번호
		adminBoardInfo.setStrUserId("관리자");//작성자(로그인 아이디)
		adminBoardInfo.setIntAdmincheck(1);//관리자가 작성
		adminBoardInfo.setIntAdminNo(AdminNo);//관리자번호
		//adminBoardInfo.setIntBoardNotice(1);//공지하기
		
		adminBoardService.insertBoardInfo(adminBoardInfo);		//입력한 정보 DB에 저장
	
		mav.setViewName("redirect:/AdminBoard/AdminBoardList?boardCateNo="+boardCateNo);
			
		return mav;		
	}
	
	//게시글 읽기
	@RequestMapping(value="/AdminBoardRead")
	public ModelAndView AdminBoardRead(int boardCateNo, int BoardNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		
		String BoardName = adminBoardService.selectBoardName(boardCateNo);			//게시판 명 불러오기
		
		AdminBoardInfo board = adminBoardService.selectBoardInfo(BoardNo);		//게시글 정보 가져오기(제목, 작성자, adminId, 글내용) 조회수 증가
		List<Comment> cmmtlist = adminBoardService.selectCommentList(BoardNo);	//댓글 내용 가져오기
		
		int adminNo = board.getIntAdminNo();
		if(adminNo != 0) {		//작성자가 ADMIN이면 ID가져오기
			String adminId = adminBoardService.selectAdminId(adminNo);	//관리자 id
			board.setStrAdminId(adminId);
		}
		
		mav.addObject("board", board);	//게시글
		mav.addObject("commentlist", cmmtlist);	//댓글 리스트
		mav.addObject("boardCateNo", boardCateNo);	//게시판 카테고리 번호
		mav.addObject("boardName", BoardName);		//게시판명
		mav.setViewName("/admin/board/BoardRead");
		
		return mav;		
	}
	
	//게시글 삭제
	@RequestMapping("/AdminBoardDelete")
	public ModelAndView boardDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session,int BoardNo, int CategoryNo) throws Exception {		
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		adminBoardService.deleteboard(BoardNo);	//글 삭제

		mav.setViewName("redirect:/AdminBoard/AdminBoardList?boardCateNo="+CategoryNo);
		
		return mav;
	}
	
	//게시글 수정페이지로 이동
	@RequestMapping("AdminBoardUpdateForm")
	public ModelAndView AdminBoardUpdateForm(int BoardNo) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		AdminBoardInfo board = adminBoardService.selectBoard(BoardNo);	//글번호로 게시글 내용 가져오기
		
		mav.addObject("board", board);
		mav.setViewName("/admin/board/BoardUpdate");
		
		return mav;		
	}

}
