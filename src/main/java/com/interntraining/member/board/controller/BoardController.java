package com.interntraining.member.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.member.board.domain.Board;
import com.interntraining.member.board.domain.Comment;
import com.interntraining.member.board.service.BoardService;

/*
 * 게시판 관리
 * 	- 게시글 등록/수정/삭제
 * 	- 댓글 등록/수정/삭제 
 * 
 */
@Controller
@RequestMapping(value = "/board")
public class BoardController {

	@Autowired
	private BoardService boardService;

	// 게시판
	@ResponseBody
	@RequestMapping(value="/boardlist")
	public ModelAndView boardlist(Board board) throws Exception {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());

		List<Board> boardlist = boardService.selectboardlist(board);
		mav.addObject("boardlist", boardlist);
		mav.setViewName("/board/boardlist");
		return mav;

	}

	// 게시글 작성 페이지
	@RequestMapping("/boardwrite")
	public String boardwrite() {
		return "/board/boardwrite";
	}

	// 게시글 저장
	@RequestMapping("/boardsave")
	public ModelAndView boardWrite(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());

		String id = (String) session.getAttribute("id");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");

		Board board = new Board();
		board.setStrUserId(id);
		board.setStrBoardTitle(title);
		board.setStrBoardContent(contents);
		boardService.insertboard(board);

		List<Board> boardlist = boardService.selectboardlist(board);
		mav.addObject("boardlist", boardlist);
		mav.setViewName("/board/boardlist");

		return mav;
	}

	// 게시글 읽기 + 댓글 뿌려주기
	@RequestMapping("/boardread")
	public ModelAndView boardread(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			int intBoardNo) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		String id = (String) session.getAttribute("id"); // 세션

		Board boardread = boardService.readboard(intBoardNo);
		List<Comment> cmmtlist = boardService.selectcmmtlist(intBoardNo);

		mv.addObject("board", boardread);
		mv.addObject("commentlist", cmmtlist);
		mv.addObject("id", id);
		mv.setViewName("/board/boardread");
		return mv;
	}

	// 게시글 수정페이지에 글 뿌려주기
	@RequestMapping("/boardchange")
	public ModelAndView boardchange(int intBoardNo) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		Board boardread = boardService.readboard(intBoardNo);

		mv.addObject("board", boardread);
		mv.setViewName("/board/boardchange");
		return mv;

	}

	// 수정한 게시글 DB에 저장
	@RequestMapping("/boardupdate")
	public ModelAndView boardUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			int bno) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		String title = request.getParameter("title");
		String contents = request.getParameter("contents");

		Board board = new Board();
		board.setIntBoardNo(bno);
		board.setStrBoardTitle(title);
		board.setStrBoardContent(contents);
		boardService.updateboard(board);

		List<Board> boardlist = boardService.selectboardlist(board);
		mv.addObject("boardlist", boardlist);
		mv.setViewName("/board/boardlist");
		return mv;
	}

	// 댓글 등록
	@RequestMapping("/commentsave")
	public ModelAndView coimmentWrite(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			int intBoardNo) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		String id = (String) session.getAttribute("id"); // 세션
		String content = request.getParameter("comment");

		// 댓글 DB에 저장
		Comment comment = new Comment();
		comment.setIntBoardNo(intBoardNo);
		comment.setStrUserId(id);
		comment.setStrCmmtComment(content);
		boardService.insertComment(comment);

		// 상세보기에 게시글과 댓글뿌려주기
		Board boardread = boardService.readboard(intBoardNo);
		List<Comment> cmmtlist = boardService.selectcmmtlist(intBoardNo);
		mv.addObject("board", boardread);
		mv.addObject("commentlist", cmmtlist);
		mv.setViewName("/board/boardread");
		return mv;
	}
}
