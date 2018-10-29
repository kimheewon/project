package com.interntraining.admin.adminBoard.service;

import java.util.List;

import com.interntraining.admin.adminBoard.domain.AdminBoardInfo;

public interface AdminBoardService {

	//해당 게시판 글 모두 가져오기
	public List<AdminBoardInfo> selectAllBoard(int boardCateNo);

	//게시판 명 불러오기
	public String selectBoardName(int boardCateNo);


}
