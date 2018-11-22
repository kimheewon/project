package com.interntraining.admin.adminBoard.service;

import java.util.List;

import com.interntraining.admin.adminBoard.domain.AdminBoardInfo;
import com.interntraining.member.board.domain.Comment;

public interface AdminBoardService {

	//해당 게시판 글 모두 가져오기
	public List<AdminBoardInfo> selectAllBoard(int boardCateNo);

	//게시판 명 불러오기
	public String selectBoardName(int boardCateNo);

	//입력한 정보 DB에 저장
	public void insertBoardInfo(AdminBoardInfo adminBoardInfo);

	//관리자 id 찾기
	public String selectAdminId(int intAdminNo);

	//게시글 정보 가져오기(제목, 작성자, adminId, 글내용)
	public AdminBoardInfo selectBoardInfo(int boardNo);

	//댓글 내용 가져오기
	public List<Comment> selectCommentList(int boardNo);

	//글 삭제
	public void deleteboard(int boardNo);

	//글번호로 게시글 내용 가져오기
	public AdminBoardInfo selectBoard(int boardNo);

	//부모게시판 명 불러오기
	public AdminBoardInfo selectCategoryParentName(int boardCateNo);

	

}
