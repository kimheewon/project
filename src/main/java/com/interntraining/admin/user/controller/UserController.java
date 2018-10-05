package com.interntraining.admin.user.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;


import com.interntraining.admin.user.domain.Board;
import com.interntraining.admin.user.domain.Comment;
import com.interntraining.admin.user.domain.User;
import com.interntraining.admin.user.service.UserService;

/*
 * 회원 정보 관리
 * 	- 회원 가입
 * 	- 회원 정보 수정
 * 
 */
@Controller
@RequestMapping(value = "/")
public class UserController {

	@Autowired
	private UserService userService;
	
	
	//첫화면 - 로그인 화면
	@RequestMapping(value = "/")
    public String initPage() throws Exception {				
		return "/login/loginForm";	
    }
	
	

	//로그인 처리
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String login(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception{
		
		//로그인 폼에서 id와 pw 가져옴
		String id = request.getParameter("id");
		String password = request.getParameter("pw");
		
		
		if(session.getAttribute("login") != null) {
			//기존에 login이란 세션 값이 존재한다면
			session.removeAttribute("login");	//기존값 제거
		}
		
		User user = new User();
		//로그인 성공
		if(userService.logincheck(id, password)){
			user = userService.selectOne(id);		//로그인 성공시 정보 담아놓음
			session.setAttribute("login", user);	//세션에 login이란 이름으로 user 객체를 저장함
			session.setAttribute("id", user.getStrUserid());
			return "/login/home";			//로그인 성공시 홈화면으로 이동			
		}
		else{//로그인 실패
			return "/login/loginForm";		//로그인 실패시 로그인 폼 화면으로 이동
		}
	
	}	
	
	//로그아웃
	@RequestMapping(value = "logout.do")
    public String logout(HttpSession session) throws Exception{
		session.invalidate();    //세션 전체를 날려버림
		return "/login/loginForm";
    }
	
	//회원가입
	@RequestMapping("joinForm")
    public String joinForm(){		
        return "/login/sample";
    }
	
	//회원정보 저장
	@RequestMapping(value = "joinsave.do")
	public ModelAndView joinSave() {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		return mav;
		
	}
	
	
	//게시판
	@ResponseBody
	@RequestMapping("boardlist.do")
	public ModelAndView boardlist(Board board) throws Exception {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<Board> boardlist  = userService.selectboardlist(board);
		mav.addObject("boardlist",boardlist);
		mav.setViewName("/board/boardlist");
		return mav;
		        
		       
	}
	
	//게시글 작성 페이지
	@RequestMapping("boardwrite")
    public String boardwrite(){		
        return "/board/boardwrite";
    }
	
	
	//게시글 저장
	@RequestMapping("boardsave.do")
    public ModelAndView boardWrite(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		String id = (String) session.getAttribute("id");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		
		Board board = new Board();
		board.setStrUserId(id);
		board.setStrBoardTitle(title);
		board.setStrBoardContent(contents);
		userService.insertboard(board);
		
		List<Board> boardlist  = userService.selectboardlist(board);
		mav.addObject("boardlist",boardlist);
		mav.setViewName("/board/boardlist");

        return mav;
    }
	
	//게시글 읽기 + 댓글 뿌려주기
	@RequestMapping("boardread.do")
	public ModelAndView boardread(HttpServletRequest request,HttpServletResponse response, HttpSession session, int intBoardNo) throws Exception{
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		
		String id = (String) session.getAttribute("id"); //세션
		
		Board boardread = userService.readboard(intBoardNo);
		List<Comment> cmmtlist = userService.selectcmmtlist(intBoardNo);
		
		mv.addObject("board", boardread);
		mv.addObject("commentlist", cmmtlist);
		mv.addObject("id", id);
		mv.setViewName("/board/boardread");
		return mv;
	}
	
	//게시글 수정페이지에 글 뿌려주기
	@RequestMapping("boardchange.do")
	public ModelAndView boardchange(int intBoardNo) throws Exception{
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		
		Board boardread = userService.readboard(intBoardNo);
		
		mv.addObject("board", boardread);
		mv.setViewName("/board/boardchange");
		return mv;
		
	}
	
	//수정한 게시글 DB에 저장
	@RequestMapping("boardupdate.do")
	public ModelAndView boardUpdate(HttpServletRequest request,HttpServletResponse response, HttpSession session, int bno) throws Exception{
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
	
		Board board = new Board();
		board.setIntBoardNo(bno);
		board.setStrBoardTitle(title);
		board.setStrBoardContent(contents);
		userService.updateboard(board);
		
		List<Board> boardlist  = userService.selectboardlist(board);
		mv.addObject("boardlist",boardlist);
		mv.setViewName("/board/boardlist");
		return mv;
	}
	
	//댓글 등록
	@RequestMapping("commentsave.do")
	public ModelAndView coimmentWrite(HttpServletRequest request,HttpServletResponse response, HttpSession session, int intBoardNo) throws Exception{
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
	
		String id = (String) session.getAttribute("id"); //세션
		String content = request.getParameter("comment");
		
		//댓글 DB에 저장
		Comment comment = new Comment();
		comment.setIntBoardNo(intBoardNo);
		comment.setStrUserId(id);
		comment.setStrCmmtComment(content);
		userService.insertComment(comment);
		
		//상세보기에 게시글과 댓글뿌려주기
		Board boardread = userService.readboard(intBoardNo);
		List<Comment> cmmtlist = userService.selectcmmtlist(intBoardNo);
		mv.addObject("board", boardread);
		mv.addObject("commentlist", cmmtlist);
		mv.setViewName("/board/boardread");
		return mv;
	}
		
}
