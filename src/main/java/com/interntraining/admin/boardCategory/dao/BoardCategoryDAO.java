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

}
