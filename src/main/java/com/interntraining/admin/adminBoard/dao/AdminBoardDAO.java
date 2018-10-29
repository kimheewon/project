package com.interntraining.admin.adminBoard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.adminBoard.domain.AdminBoardInfo;

@Repository("adminBoardDAO")
public class AdminBoardDAO {

	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
	
	//게시판 글 모듀 가져오기
	public List<AdminBoardInfo> selectAllBoard(int boardCateNo) {
		return sqlSession.selectList("boardSql.selectAllBoard", boardCateNo);
	}

	//게시판 명 불러오기
	public String selectBoardName(int boardCateNo) {
		return sqlSession.selectOne("boardSql.selectBoardName", boardCateNo);
	}

}
