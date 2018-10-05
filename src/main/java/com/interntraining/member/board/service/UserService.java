package com.interntraining.member.board.service;

import java.util.List;

import com.interntraining.member.board.domain.Board;
import com.interntraining.member.board.domain.Comment;


public interface UserService {


	//게시판 글뿌리기
	public List<Board> selectboardlist(Board board) throws Exception;
	
	//게시글 작성
	public void insertboard(Board board) throws Exception;

	//게시글 읽기
	public Board readboard(int intBoardNo) throws Exception;

	//수정한 게시글 저장
	public void updateboard(Board board) throws Exception;
	
	//댓글 불러오기
	public List<Comment> selectcmmtlist(int intBoardNo) throws Exception;

	//댓글 저장
	public void insertComment(Comment comment) throws Exception;
}
