package com.interntraining.member.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.member.board.domain.Board;
import com.interntraining.member.board.domain.Comment;
import com.interntraining.member.board.domain.Pagination;
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
	public ModelAndView boardlist(HttpServletRequest request, HttpServletResponse response, HttpSession session, Board board,@RequestParam(required=false) Integer nowPage,@RequestParam(required=false)Integer nowBlock,
            @RequestParam(required=false) String keyField, @RequestParam(required=false) String keyWord, @RequestParam(defaultValue="1") int curPage) throws Exception {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		String KeyWord = request.getParameter("keyWord");
		String KeyField = request.getParameter("keyField");
		
		//setAttribute로 세션에 검색어 담기?
		//session.setAttribute("keyWord", KeyWord);
		//session.setAttribute("keyField", KeyField);
		if(KeyWord == null) {
			List<Board> boardCount = boardService.selectboardlist(board);	//게시글 총 개수
			int listCnt = boardCount.size();
			
			Pagination pagination = new Pagination(listCnt, curPage);
	        
	        /* List */
	        List<Board> boardList = boardService.getBoardList(pagination); // 리스트
	        
		
			mav.addObject("boardlist", boardList);
			mav.addObject("listCnt", listCnt);
			mav.addObject("pagination", pagination);
			mav.setViewName("/board/boardlist");
			
			return mav;
			
			
		}
		else {//검색어
			List<Board> boardCount = boardService.searchboardlist(KeyField, KeyWord);	//게시글 총 개수
			int listCnt = boardCount.size();
		Pagination pagination = new Pagination(listCnt, curPage);
		pagination.setKeyField(KeyField);
		pagination.setKeyWord(KeyWord);
		pagination.setCurPage(curPage);
		List<Board> list = boardService.searchboardlistP(pagination);
		mav.addObject("boardlist", list);
		mav.addObject("listCnt", listCnt);
		mav.addObject("pagination", pagination);
		mav.setViewName("/board/boardlist");
		
		return mav;
		}
	}


	// 게시글 작성 페이지
	@RequestMapping("/boardwrite")
	public String boardwrite() {
		return "/board/boardwrite";
	}

	//게시글 검색
	

	
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

	//게시글 삭제
	@RequestMapping("/boardDelete")
	public ModelAndView boardDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			int intBoardNo) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		boardService.deleteboard(intBoardNo);

		Board board = new Board();
		List<Board> boardlist = boardService.selectboardlist(board);
		mv.addObject("boardlist", boardlist);
		mv.setViewName("/board/boardlist");
		return mv;
	}
	
	// 댓글 등록
	@RequestMapping("/commentsave")
	public ModelAndView commentWrite(HttpServletRequest request, HttpServletResponse response, HttpSession session,
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
	
	//댓글 정보 찾기
	@RequestMapping("/commentchange")
	public ModelAndView commentSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session,int intCmmtNo) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		
		Comment comment = new Comment();
		comment.setIntCmmtNo(intCmmtNo);
		
		Comment commentread = boardService.selectComment(comment);
		
		//boardService.updateComment(comment);

		// 상세보기에 게시글과 댓글뿌려주기
		//Board boardread = boardService.readboard(intBoardNo);
		//List<Comment> cmmtlist = boardService.selectcmmtlist(intBoardNo);
		mv.addObject("comment", commentread);
		//mv.addObject("commentlist", cmmtlist);
		mv.setViewName("/board/commentUpdateForm");
		return mv;
	}
	
	//댓글 삭제
	@RequestMapping("/commentDelete")
	public ModelAndView commentDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session,int intCmmtNo,int intBoardNo ) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		String id = (String) session.getAttribute("id"); // 세션
		boardService.deleteComment(intCmmtNo);

		Board boardread = boardService.readboard(intBoardNo);
		List<Comment> cmmtlist = boardService.selectcmmtlist(intBoardNo);

		mv.addObject("board", boardread);
		mv.addObject("commentlist", cmmtlist);
		mv.addObject("id", id);
		mv.setViewName("/board/boardread");
		return mv;
	}
	
	//댓글 수정
	@RequestMapping(value = "/commentUpdate", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public ModelAndView commentUpdate(int intCmmtNo, String strCmmtContent ) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		
		Comment comment = new Comment();
		comment.setIntCmmtNo(intCmmtNo);
		comment.setStrCmmtComment(strCmmtContent);
		
		boardService.updateComment(comment);		//댓글 DB에 수정
		
		Comment commentread = boardService.selectComment(comment);
		int intBoardNo = commentread.getIntBoardNo();
		Board boardread = boardService.readboard(intBoardNo);
		List<Comment> cmmtlist = boardService.selectcmmtlist(intBoardNo);

		mv.addObject("board", boardread);
		mv.addObject("commentlist", cmmtlist);

		
		
		
		return mv;
	}
}