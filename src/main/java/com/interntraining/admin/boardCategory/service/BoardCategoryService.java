package com.interntraining.admin.boardCategory.service;

import java.util.List;

import com.interntraining.admin.authority.domain.AuthInfo;
import com.interntraining.admin.boardCategory.domain.BoardCategoryInfo;

public interface BoardCategoryService {

	//게시판 카테고리 모두 가져오기
	public List<BoardCategoryInfo> selectAllBoardCategory();

	//게시판명 중복 체크
	public BoardCategoryInfo selectName(String boardName);

	//db에 게시판 카테고리 저장
	public void boardCategoryInsert(BoardCategoryInfo board);

}
