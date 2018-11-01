package com.interntraining.admin.boardCategory.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.boardCategory.dao.BoardCategoryDAO;
import com.interntraining.admin.boardCategory.domain.BoardCategoryInfo;

@Service()
public class BoardCategoryServiceImpl implements BoardCategoryService{

	@Resource(name = "boardCategoryDAO")
	private BoardCategoryDAO boardCategoryDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;
	
	
	//게시판 카테고리 모두 가져오기
	@Override
	public List<BoardCategoryInfo> selectAllBoardCategory() {
		return boardCategoryDAO.selectAllBoardCategory();
	}

	//게시판명 중복 체크
	@Override
	public BoardCategoryInfo selectName(String boardName) {
		return boardCategoryDAO.selectName(boardName);
	}

	//db에 게시판 카테고리 저장
	@Override
	public void boardCategoryInsert(BoardCategoryInfo board) {
		boardCategoryDAO.boardCategoryInsert(board);
		
	}
	
	//카테고리 번호로 카테고리 명 찾기
	@Override
	public BoardCategoryInfo selectBoardCategoryName(int intboardCategoryNo) {
		return boardCategoryDAO.selectBoardCategoryName(intboardCategoryNo);
	}

	//게시판 중복인지 찾기
	@Override
	public BoardCategoryInfo searchBoardCateName(String boardName) {
		return boardCategoryDAO.searchBoardCateName(boardName);
	}

	//db에 게시판 명 수정
	@Override
	public void boardCategoryUpdate(BoardCategoryInfo board) {
		boardCategoryDAO.boardCategoryUpdate(board);
	}

	//게시판 카테고리 삭제(게시글, 댓글 모두 삭제)
	@Override
	public void boardCategoryDelete(int boardCateNo) {
		boardCategoryDAO.boardCategoryDelete(boardCateNo);		
	}

	//카테고리 명 찾기
	@Override
	public String selectCategoryName(int boardCateNo) {
		return boardCategoryDAO.selectCategoryName(boardCateNo);
	}

	//Child 게시판  모두 가져오기
	@Override
	public List<BoardCategoryInfo> selectChildBoardCategory(int boardCateNo) {
		return boardCategoryDAO.selectChildBoardCategory(boardCateNo);
	}

	//Child 게시판 정보 찾기
	@Override
	public BoardCategoryInfo selectChildBoardCategoryInfo(int intboardCategoryNo) {
		return boardCategoryDAO.selectChildBoardCategoryInfo(intboardCategoryNo);
	}

	//부모 카테고리 번호 찾기
	@Override
	public int searchParentBoardCateNo(int boardCateNo) {
		// TODO Auto-generated method stub
		return boardCategoryDAO.searchParentBoardCateNo(boardCateNo);
	}
	
}
