package com.interntraining.member.board.service;

import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import com.interntraining.admin.boardCategory.domain.BoardCategoryInfo;
import com.interntraining.member.board.domain.Board;
import com.interntraining.member.board.domain.Comment;
import com.interntraining.member.board.domain.Pagination;


public interface BoardService {


	//게시판 글뿌리기
	public List<Board> selectboardlist(Board board) throws Exception;
	
	//게시글 검색
	public List<Board> searchboardlist(Board boardInfo);
	
	//검색 페이징
	public List<Board> searchboardlistP(Pagination pagination);
	
	//게시글 작성
	public void insertboard(Board board) throws Exception;
	
	//게시글 읽기(조회수 증가)
	public Board readboardHit(int intBoardNo);	

	//게시글 읽기
	public Board readboard(int intBoardNo) throws Exception;

	//수정한 게시글 저장
	public void updateboard(Board board) throws Exception;
	
	//게시글 삭제
	public void deleteboard(int bno);
	
	//댓글 불러오기
	public List<Comment> selectcmmtlist(int intBoardNo) throws Exception;

	//댓글 저장
	public void insertComment(Comment comment) throws Exception;
	
	//댓글수정
	public void updateComment(Comment comment) throws Exception;
	
	//댓글삭제
	public void deleteComment(int intCmmtNo) throws Exception;

	//댓글 찾기
	public Comment selectComment(Comment comment);

	//게시판(페이징)
	public List<Board> getBoardList(Pagination pagination);

	//댓글수
	public int totalComment(int intBoardNo);

	//id로 유저의 등급 찾기
	public String getUserGrade(String id);

	//db에서 게시판 카테고리 항목 불러오기
	public List<BoardCategoryInfo> boardCategoryList();

	//게시판 카테고리 번호 찾기
	public int selectBoardCateNo(int intBoardNo);

	//댓글의 게시글번호 찾기
	public int selectBoardNo(int intCmmtNo);

	//카테고리 번호로 게시판명 찾기
	public String selectBoardCateName(int intBoardCateNo);

	

	

	

}
