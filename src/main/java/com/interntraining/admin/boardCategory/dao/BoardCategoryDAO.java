package com.interntraining.admin.boardCategory.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.boardCategory.domain.BoardCategoryInfo;

@Repository("boardCategoryDAO")
public class BoardCategoryDAO {

	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
	
	//게시판 카테고리 모두 가져오기
	public List<BoardCategoryInfo> selectAllBoardCategory() {
		return sqlSession.selectList("boardCategorySql.selectAllBoardCategory");
	}

	//게시판명 중복 체크
	public BoardCategoryInfo selectName(String boardName) {
		return sqlSession.selectOne("boardCategorySql.selectName",boardName);
	}

	//db에 게시판 카테고리 저장
	public void boardCategoryInsert(BoardCategoryInfo board) {
		sqlSession.insert("boardCategorySql.boardCategoryInsert", board);
	}

	//카테고리 번호로 카테고리 명 찾기
	public BoardCategoryInfo selectBoardCategoryName(int intboardCategoryNo) {
		return sqlSession.selectOne("boardCategorySql.selectBoardCategoryName",intboardCategoryNo);
	}

	//게시판 중복인지 찾기
	public BoardCategoryInfo searchBoardCateName(String boardName) {
		return sqlSession.selectOne("boardCategorySql.searchBoardCateName",boardName);
	}

	//db에 게시판 명 수정
	public void boardCategoryUpdate(BoardCategoryInfo board) {
		sqlSession.update("boardCategorySql.boardCategoryUpdate", board);
		
	}

	//게시판 카테고리 삭제(게시글, 댓글 모두 삭제)
	public void boardCategoryDelete(int boardCateNo) {
		sqlSession.delete("boardCategorySql.boardCategoryDelete", boardCateNo);
	}
	
	//카테고리 명 찾기
	public String selectCategoryName(int boardCateNo) {
		return sqlSession.selectOne("boardCategorySql.selectCategoryName", boardCateNo);
	}

	//Child 게시판  모두 가져오기
	public List<BoardCategoryInfo> selectChildBoardCategory(int boardCateNo) {
		return sqlSession.selectList("boardCategorySql.selectChildBoardCategory",boardCateNo);
	}

	//Child 게시판 정보 찾기
	public BoardCategoryInfo selectChildBoardCategoryInfo(int intboardCategoryNo) {
		return sqlSession.selectOne("boardCategorySql.selectChildBoardCategoryInfo", intboardCategoryNo);
	}

	//부모 카테고리 번호 찾기
	public int searchParentBoardCateNo(int boardCateNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardCategorySql.searchParentBoardCateNo",boardCateNo);
	}

}
