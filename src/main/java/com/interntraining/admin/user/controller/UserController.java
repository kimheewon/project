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
import com.interntraining.admin.user.service.UserService;



@Controller
@RequestMapping(value = "/")
public class UserController {

	@Autowired
	private UserService userService;
	
	
	//첫화면 - 로그인 화면
	@RequestMapping(value = "/")
    public String initPage() throws Exception {
				
		return "login/loginForm";
	
    }
	
	
	//01. 로그인 화면	
	@PostMapping(value = "loginForm")
    public String loginForm(){
        return "/login/loginForm";
    }
	
	//로그인 처리
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception{
					  
		String id = request.getParameter("id");
		String password = request.getParameter("pw");
	
		//로그인 성공
		if(userService.logincheck(id, password)){
			session.setAttribute("userid", id);
			return "login/home";			
		}
		else{//로그인 실패
			session.setAttribute("sessionID", id);
			return "login/loginForm";
		}
				  	 
	}	
	
	//로그아웃
	@RequestMapping(value = "logout")
    public String logout(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception{
		String id = null;
	
		session.setAttribute("sessionID", id);
        return "/login/loginForm";
    }
	
	//게시판
	@ResponseBody
	@RequestMapping("boardlist")
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
	@RequestMapping("boardsave")
    public ModelAndView boardWrite(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		String id = (String) session.getAttribute("userid");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		
		Board board = new Board();
		board.setUid(id);
		board.setTitle(title);
		board.setCnt(contents);
		userService.insertboard(board);
		
		List<Board> boardlist  = userService.selectboardlist(board);
		mav.addObject("boardlist",boardlist);
		mav.setViewName("/board/boardlist");

        return mav;
    }
	
	//게시글 읽기 + 댓글 뿌려주기
	@RequestMapping("boardread")
	public ModelAndView boardread(int bno) throws Exception{
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		
		Board boardread = userService.readboard(bno);
		List<Comment> cmmtlist = userService.selectcmmtlist(bno);
		mv.addObject("board", boardread);
		mv.addObject("commentlist", cmmtlist);
		mv.setViewName("/board/boardread");
		return mv;
	}
	
	//게시글 수정페이지에 글 뿌려주기
	@RequestMapping("boardchange")
	public ModelAndView boardchange(int bno) throws Exception{
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		
		Board boardread = userService.readboard(bno);
		
		mv.addObject("board", boardread);
		mv.setViewName("/board/boardchange");
		return mv;
		
	}
	
	//수정한 게시글 DB에 저장
	@RequestMapping("boardupdate")
	public ModelAndView boardUpdate(HttpServletRequest request,HttpServletResponse response, HttpSession session, int bno) throws Exception{
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
	
		Board board = new Board();
		board.setBno(bno);
		board.setTitle(title);
		board.setCnt(contents);
		userService.updateboard(board);
		
		List<Board> boardlist  = userService.selectboardlist(board);
		mv.addObject("boardlist",boardlist);
		mv.setViewName("/board/boardlist");
		return mv;
	}
}
