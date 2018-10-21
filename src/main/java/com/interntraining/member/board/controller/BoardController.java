package com.interntraining.member.board.controller;

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
	        
	        //글 스쿼스 번호
	        int c = listCnt - (curPage-1)*10;
	        for(int i=0; i<boardList.size(); i++) {
	        	boardList.get(i).setIntNum(c--);
	        
	        }
	        
	        
	        
	        //vip 회원 구분
	        for(int i=0; i<boardList.size(); i++){
	        	String id = boardList.get(i).getStrUserId();
	        	String grade = boardService.getUserGrade(id); //id로 유저의 등급 찾기
	        	boardList.get(i).setStrGrade(grade);
	        }
	        
	        //날짜 변환
	        Date dateB = new Date();
	        String boardDate;
	        int Commentotal;

	        
	        Date today = new Date();
	        SimpleDateFormat date = new SimpleDateFormat("yyy/MM/dd");
	        SimpleDateFormat dateTime = new SimpleDateFormat("hh:mm a",Locale.US);
	        int check;
	        for(int j=0; j<boardList.size();j++) {
	        	dateB = boardList.get(j).getDateBoardDate();
	        	check=0;
	        	//댓글 수
	        	Commentotal = boardService.totalComment(boardList.get(j).getIntBoardNo());
	        	boardList.get(j).setInttotalComment(Commentotal);
	        	
		       
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
			
			 //글 스쿼스 번호
	        int c = listCnt - (curPage-1)*10;
	        for(int i=0; i<list.size(); i++) {
	        	list.get(i).setIntNum(c--);
	        
	        }
	        
			
			//vip 회원 구분
	        for(int i=0; i<list.size(); i++){
	        	String id = list.get(i).getStrUserId();
	        	String grade = boardService.getUserGrade(id); //id로 유저의 등급 찾기
	        	list.get(i).setStrGrade(grade);
	        }
	        
	        
			//날짜 변환
	        Date dateB = new Date();
	        String boardDate;
	        int Commentotal;

	        
	        Date today = new Date();
	        SimpleDateFormat date = new SimpleDateFormat("yyy/MM/dd");
	        SimpleDateFormat dateTime = new SimpleDateFormat("hh:mm a",Locale.US);
	        int check;
	        for(int j=0; j<list.size();j++) {
	        	dateB = list.get(j).getDateBoardDate();
	        	check=0;
	        	//댓글 수
	        	Commentotal = boardService.totalComment(list.get(j).getIntBoardNo());
	        	list.get(j).setInttotalComment(Commentotal);
	        	
		       
		        if(! date.format(today).equals(date.format(dateB))) {	//오늘 쓴 글이 아니면
		        	boardDate = date.format(dateB);
		        	list.get(j).setStrBoardDate(boardDate);
		        }
		        else {	//오늘 쓴 글이면
		        	check=1;
		        	boardDate=dateTime.format(dateB);
		        	list.get(j).setStrBoardDate(boardDate);
		        	list.get(j).setIntNewCheck(check); //오늘 글인지 확인 new
		        }
		    }
			
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
	public ModelAndView boardWrite(HttpServletRequest request, HttpServletResponse response, HttpSession session,@RequestParam(required=false) Integer nowPage,@RequestParam(required=false)Integer nowBlock,
            @RequestParam(required=false) String keyField, @RequestParam(required=false) String keyWord, @RequestParam(defaultValue="1") int curPage)
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

		List<Board> boardCount = boardService.selectboardlist(board);	//게시글 총 개수
		int listCnt = boardCount.size();
	
		Pagination pagination = new Pagination(listCnt, curPage);
					
		//List<Board> boardlist = boardService.selectboardlist(board);
		List<Board> boardlist = boardService.getBoardList(pagination); // 리스트

		 //글 스쿼스 번호
		int c = listCnt - (curPage-1)*10;
		for(int i=0; i<boardlist.size(); i++) {
			boardlist.get(i).setIntNum(c--);
       
		}
		//vip 회원 구분
        for(int i=0; i<boardlist.size(); i++){
        	String idG = boardlist.get(i).getStrUserId();
        	String grade = boardService.getUserGrade(idG); //id로 유저의 등급 찾기
        	boardlist.get(i).setStrGrade(grade);
        }
        
        
        
		 //날짜 변환+new
        Date dateB = new Date();
        String boardDate;
        int Commentotal;

        
        Date today = new Date();
        SimpleDateFormat date = new SimpleDateFormat("yyy/MM/dd");
        SimpleDateFormat dateTime = new SimpleDateFormat("hh:mm a",Locale.US);
        int check;
        for(int j=0; j<boardlist.size();j++) {
        	dateB = boardlist.get(j).getDateBoardDate();
        	check=0;
        	//댓글 수
        	Commentotal = boardService.totalComment(boardlist.get(j).getIntBoardNo());
        	boardlist.get(j).setInttotalComment(Commentotal);
        	
	       
	        if(! date.format(today).equals(date.format(dateB))) {	//오늘 쓴 글이 아니면
	        	boardDate = date.format(dateB);
	        	boardlist.get(j).setStrBoardDate(boardDate);
	        }
	        else {	//오늘 쓴 글이면
	        	check=1;
	        	boardDate=dateTime.format(dateB);
	        	boardlist.get(j).setStrBoardDate(boardDate);
	        	boardlist.get(j).setIntNewCheck(check); //오늘 글인지 확인 new
	        }
	    }
        
        
        
		mav.addObject("boardlist", boardlist);
		mav.addObject("listCnt", listCnt);
		mav.addObject("pagination", pagination);
		mav.setViewName("/board/boardlist");

		return mav;
	}

	// 게시글 읽기 + 댓글 뿌려주기(조회수 증가)
	@RequestMapping("/boardreadHit")
	public ModelAndView boardreadHit(HttpServletRequest request, HttpServletResponse response, HttpSession session,
		int intBoardNo) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		String id = (String) session.getAttribute("id"); // 세션

		Board boardread = boardService.readboardHit(intBoardNo);	//조회수 증가
		List<Comment> cmmtlist = boardService.selectcmmtlist(intBoardNo);
		int cmmlistCount = cmmtlist.size();

		//vip 회원 구분       
       	String idG = boardread.getStrUserId();
       	String grade = boardService.getUserGrade(idG); //id로 유저의 등급 찾기
        boardread.setStrGrade(grade);
      
        
		mv.addObject("board", boardread);
		mv.addObject("commentlist", cmmtlist);
		mv.addObject("cmmlistCount",cmmlistCount);//댓글수
		mv.addObject("id", id);
		mv.setViewName("/board/boardread");
		return mv;
	}	
		
		
	// 게시글 읽기 + 댓글 뿌려주기
	@RequestMapping("/boardread")
	public ModelAndView boardread(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			int intBoardNo) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		String id = (String) session.getAttribute("id"); // 세션

		Board boardread = boardService.readboard(intBoardNo);	//조회수 증가No
		List<Comment> cmmtlist = boardService.selectcmmtlist(intBoardNo);
		int cmmlistCount = cmmtlist.size();

       
		//vip 회원 구분       
       	String idG = boardread.getStrUserId();
       	String grade = boardService.getUserGrade(idG); //id로 유저의 등급 찾기
        boardread.setStrGrade(grade);
        
		mv.addObject("board", boardread);
		mv.addObject("commentlist", cmmtlist);
		mv.addObject("cmmlistCount",cmmlistCount);//댓글수
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
			int bno,@RequestParam(required=false) Integer nowPage,@RequestParam(required=false)Integer nowBlock,
            @RequestParam(required=false) String keyField, @RequestParam(required=false) String keyWord, @RequestParam(defaultValue="1") int curPage) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		String title = request.getParameter("title");
		String contents = request.getParameter("contents");

		Board board = new Board();
		board.setIntBoardNo(bno);
		board.setStrBoardTitle(title);
		board.setStrBoardContent(contents);
		boardService.updateboard(board);

		List<Board> boardCount = boardService.selectboardlist(board);	//게시글 총 개수
		int listCnt = boardCount.size();
		
		Pagination pagination = new Pagination(listCnt, curPage);
		
		List<Board> boardlist = boardService.getBoardList(pagination); // 리스트
		//List<Board> boardlist = boardService.selectboardlist(board);
		
		 //글 스쿼스 번호
        int c = listCnt - (curPage-1)*10;
        for(int i=0; i<boardlist.size(); i++) {
        	boardlist.get(i).setIntNum(c--);
        
        }
		
		//vip 회원 구분
        for(int i=0; i<boardlist.size(); i++){
        	String idG = boardlist.get(i).getStrUserId();
        	String grade = boardService.getUserGrade(idG); //id로 유저의 등급 찾기
        	boardlist.get(i).setStrGrade(grade);
        }
        
        
		 //날짜 변환+new
        Date dateB = new Date();
        String boardDate;
        int Commentotal;

        
        Date today = new Date();
        SimpleDateFormat date = new SimpleDateFormat("yyy/MM/dd");
        SimpleDateFormat dateTime = new SimpleDateFormat("hh:mm a",Locale.US);
        int check;
        for(int j=0; j<boardlist.size();j++) {
        	dateB = boardlist.get(j).getDateBoardDate();
        	check=0;
        	//댓글 수
        	Commentotal = boardService.totalComment(boardlist.get(j).getIntBoardNo());
        	boardlist.get(j).setInttotalComment(Commentotal);
        	
	       
	        if(! date.format(today).equals(date.format(dateB))) {	//오늘 쓴 글이 아니면
	        	boardDate = date.format(dateB);
	        	boardlist.get(j).setStrBoardDate(boardDate);
	        }
	        else {	//오늘 쓴 글이면
	        	check=1;
	        	boardDate=dateTime.format(dateB);
	        	boardlist.get(j).setStrBoardDate(boardDate);
	        	boardlist.get(j).setIntNewCheck(check); //오늘 글인지 확인 new
	        }
	    }
        
		mv.addObject("boardlist", boardlist);
		mv.addObject("listCnt", listCnt);
		mv.addObject("pagination", pagination);
		mv.setViewName("/board/boardlist");
		return mv;
	}

	//게시글 삭제
	@RequestMapping("/boardDelete")
	public ModelAndView boardDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			int intBoardNo, @RequestParam(required=false) Integer nowPage,@RequestParam(required=false)Integer nowBlock,
            @RequestParam(required=false) String keyField, @RequestParam(required=false) String keyWord, @RequestParam(defaultValue="1") int curPage) throws Exception {
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		boardService.deleteboard(intBoardNo);	
		
		Board board = new Board();
		List<Board> boardlistA = boardService.selectboardlist(board);
		int listCnt = boardlistA.size();
		
		Pagination pagination = new Pagination(listCnt, curPage);
		
		List<Board> boardlist = boardService.getBoardList(pagination); // 리스트
		
		 //글 스쿼스 번호
        int c = listCnt - (curPage-1)*10;
        for(int i=0; i<boardlist.size(); i++) {
        	boardlist.get(i).setIntNum(c--);
        
        }
        
		//vip 회원 구분
        for(int i=0; i<boardlist.size(); i++){
        	String idG = boardlist.get(i).getStrUserId();
        	String grade = boardService.getUserGrade(idG); //id로 유저의 등급 찾기
        	boardlist.get(i).setStrGrade(grade);
        }
        
        
		 //날짜 변환+new
        Date dateB = new Date();
        String boardDate;
        int Commentotal;

        
        Date today = new Date();
        SimpleDateFormat date = new SimpleDateFormat("yyy/MM/dd");
        SimpleDateFormat dateTime = new SimpleDateFormat("hh:mm a",Locale.US);
        int check;
        for(int j=0; j<boardlist.size();j++) {
        	dateB = boardlist.get(j).getDateBoardDate();
        	check=0;
        	//댓글 수
        	Commentotal = boardService.totalComment(boardlist.get(j).getIntBoardNo());
        	boardlist.get(j).setInttotalComment(Commentotal);
        	
	       
	        if(! date.format(today).equals(date.format(dateB))) {	//오늘 쓴 글이 아니면
	        	boardDate = date.format(dateB);
	        	boardlist.get(j).setStrBoardDate(boardDate);
	        }
	        else {	//오늘 쓴 글이면
	        	check=1;
	        	boardDate=dateTime.format(dateB);
	        	boardlist.get(j).setStrBoardDate(boardDate);
	        	boardlist.get(j).setIntNewCheck(check); //오늘 글인지 확인 new
	        }
	    }
        
		mv.addObject("boardlist", boardlist);
		mv.addObject("listCnt", listCnt);
		mv.addObject("pagination", pagination);
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
		
		//vip 회원 구분	       
       	String idG = boardread.getStrUserId();
       	String grade = boardService.getUserGrade(idG); //id로 유저의 등급 찾기
        boardread.setStrGrade(grade);
        
        
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

		//vip 회원 구분	       
       	String idG = boardread.getStrUserId();
       	String grade = boardService.getUserGrade(idG); //id로 유저의 등급 찾기
        boardread.setStrGrade(grade);
        
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