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
		
		//DB에서 Id 체크
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
		
		mav.setViewName("/admin/boardCategory/BoardCategoryList");
		return mav;
	}
}
