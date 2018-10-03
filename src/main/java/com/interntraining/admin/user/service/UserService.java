package com.interntraining.admin.user.service;

import java.util.List;

import com.interntraining.admin.user.domain.Board;
import com.interntraining.admin.user.domain.User;

public interface UserService {

	//로그인 - DB에서 id 확인
	public boolean logincheck(String id, String password) throws Exception;

	//로그인
	public User selectOne(String id) throws Exception;
	
	//게시판 글뿌리기
	public List<Board> selectboardlist(Board board) throws Exception;
	
	//게시글 작성
	public void insertboard(Board board) throws Exception;

	//게시글 읽기
	public Board readboard(int bno) throws Exception;

	//수정한 게시글 저장
	public void updateboard(Board board) throws Exception;

	
}
