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

	//카테고리 번호로 카테고리 명 찾기
	public BoardCategoryInfo selectBoardCategoryName(int intboardCategoryNo);

	//게시판 중복인지 찾기
	public BoardCategoryInfo searchBoardCateName(String boardName);

	//db에 게시판 명 수정
	public void boardCategoryUpdate(BoardCategoryInfo board);

	//게시판 카테고리 삭제(게시글, 댓글 모두 삭제)
	public void boardCategoryDelete(int boardCateNo);

	//카테고리 명 찾기
	public String selectCategoryName(int boardCateNo);

	//Child 게시판  모두 가져오기
	public List<BoardCategoryInfo> selectChildBoardCategory(int boardCateNo);

	//Child 게시판 정보 찾기
	public BoardCategoryInfo selectChildBoardCategoryInfo(int intboardCategoryNo);

	//부모 카테고리 번호 찾기
	public int searchParentBoardCateNo(int boardCateNo);

	

}
