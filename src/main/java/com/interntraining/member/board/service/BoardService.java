package com.interntraining.member.board.service;

import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import com.interntraining.member.board.domain.Board;
import com.interntraining.member.board.domain.Comment;


public interface BoardService {


	//게시판 글뿌리기
	public List<Board> selectboardlist(Board board) throws Exception;
	
	//게시글 검색
	public List<Board> searchboardlist(String keyField, String keyWord);
	
	//게시글 작성
	public void insertboard(Board board) throws Exception;

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

	

}
