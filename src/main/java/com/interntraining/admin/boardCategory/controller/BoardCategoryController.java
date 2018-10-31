package com.interntraining.admin.boardCategory.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.boardCategory.domain.BoardCategoryInfo;
import com.interntraining.admin.boardCategory.service.BoardCategoryService;
import com.interntraining.admin.authority.domain.AuthInfo;
import com.interntraining.admin.authority.domain.AuthMapp;

/*
 * 게시판 카테고리 관리
 * 	- 목록
 *  - 등록
 * 	- 수정
 *  - 삭제
 */

@Controller
@RequestMapping(value= "/BoardCategory")
public class BoardCategoryController {
	
	@Autowired
	private BoardCategoryService boardCategoryService;
	
	//게시판 카테고리 관리 페이지로 이동
	@RequestMapping(value="/BoardCategoryList")
	public ModelAndView BoardCategoryList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
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
			if(authItem.get(i).getIntAuthItemNo() == 4) {
				authCheck=1;	//권한 가지고 있음
			}			
		}
		
		if(authCheck == 1) {	//권한 가지고 있으면
			List<BoardCategoryInfo> BoardCategory = boardCategoryService.selectAllBoardCategory();	//게시판 카테고리 모두 가져오기

			mav.addObject("boardCategory",BoardCategory);
			mav.setViewName("/admin/boardCategory/BoardCategoryList");
		}
	
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
				
		return mav;		
	}
	
	//게시판 카테고리 등록페이지로 이동
	@RequestMapping(value="/BoardCategoryEnrollForm")
	public ModelAndView BoardCategoryEnrollForm(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
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
			mav.setViewName("/admin/boardCategory/BoardCategoryEnroll");
		}		
		else {		//권한 없으면 홈으로
			mav.setViewName("/admin/login/AdminHome_No");
		}
		return mav;
	}
	
	//중복된 게시판명 체크
	@RequestMapping(value="/BoardCategoryNameCheck", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public int BoardNameCheck(String boardName) throws Exception{
		
		//DB에서 카테고리명 중복 체크
		BoardCategoryInfo BoardName = boardCategoryService.selectName(boardName);
		int check = 0;
		if(BoardName != null) {
			check = 1;	//DB에 id 있음
		}				
		return check;	
	}
	
	//게시판 카테고리 등록
	@RequestMapping(value="/BoardCategoryEnroll")
	public ModelAndView BoardCategoryEnroll( HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		String boardName = request.getParameter("boardName");
		int no = (Integer)session.getAttribute("AdminNo");		//게시판 카테고리 생성자의 id
		BoardCategoryInfo board = new BoardCategoryInfo();
		board.setIntBoardCreateAdminNo(no);
		board.setStrBoardCateName(boardName);
		boardCategoryService.boardCategoryInsert(board);			//db에 게시판 카테고리 저장
		
		mav.setViewName("redirect:/BoardCategory/BoardCategoryList");
		return mav;
	}
	
	//게시판 카테고리 수정폼으로 이동
	@RequestMapping(value="/BoardCategoryUpdateForm")
	public ModelAndView BoardCategoryUpdateForm(int intboardCategoryNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		BoardCategoryInfo board = boardCategoryService.selectBoardCategoryName(intboardCategoryNo);	//카테고리 번호로 게시판 명 찾기
			
		mav.addObject("board", board);
		mav.setViewName("/admin/boardCategory/BoardCategoryUpdate");
		return mav;
	}
	
	//수정폼에서 중복된 게시판명 체크
	@RequestMapping(value="/UpdateBoardCategoryNameCheck", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public int UpdateBoardCategoryNameCheck(String boardName, int no) throws Exception{
			
		int check = 0; //사용해도 되는 이름
		BoardCategoryInfo board = boardCategoryService.selectBoardCategoryName(no);	//기존 게시판명
		if(boardName.equals(board.getStrBoardCateName())){	//게시판명 수정 안했으면..
			check = 2;
			return check;
		}
		else {	//중복된 게시판 명
			BoardCategoryInfo updateBoardName = boardCategoryService.searchBoardCateName(boardName);	//게시판 중복인지 찾기
			if(updateBoardName != null) {	//중복된 권한
				check=1; 
				return check;
			}
			else {
				check=0;  
				return check;
			}
		}		
	}
	
	//게시판 카테고리 수정
	@RequestMapping(value="/BoardCategoryUpdate")
	public ModelAndView BoardCategoryUpdate( HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
			
		String boardName = request.getParameter("boardName");
		int adminNo = (Integer)session.getAttribute("AdminNo");		//게시판 카테고리 수정자의의 id
		String strNo = request.getParameter("no");
		int no = Integer.parseInt(strNo);		//게시판 카테고리 번호
		BoardCategoryInfo board = new BoardCategoryInfo();
		
		board.setIntBoardCreateAdminNo(adminNo);
		board.setStrBoardCateName(boardName);
		board.setIntBoardCateNo(no);
		
		boardCategoryService.boardCategoryUpdate(board);			//db에 게시판 명 수정
			
		mav.setViewName("redirect:/BoardCategory/BoardCategoryList");
		return mav;
	}
	
	//게시판 카테고리 삭제
	@RequestMapping(value="/BoardCategoryDelete")
	public ModelAndView BoardCategoryUpdate(int boardCateNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
	
		boardCategoryService.boardCategoryDelete(boardCateNo);	//게시판 카테고리 삭제(게시글, 댓글 모두 삭제)
		
		mav.setViewName("redirect:/BoardCategory/BoardCategoryList");
		return mav;
	}
	
}
