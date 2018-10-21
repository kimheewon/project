package com.interntraining.admin.loginAdmin.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.authority.domain.AuthItemInfo;
import com.interntraining.admin.authority.domain.AuthMapp;
import com.interntraining.admin.loginAdmin.domain.LoginAdminInfo;
import com.interntraining.member.board.domain.Board;

@Repository("loginAdminDAO")
public class LoginAdminDAO {

	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
	
	//로그인시 관리자ID를 DB에서 확인
	public LoginAdminInfo selectOne(String id) {
		return sqlSession.selectOne("adminloginSql.selectOne",id);	
	}

	//권항 항목 가져오기
	public List<AuthMapp> selectItemList(int authno) {
		return sqlSession.selectList("authSql.selectItemList",authno);
	}

	// 가입자수
	public int count(String word) {
		return sqlSession.selectOne("adminloginSql.count", word);
	}

	//게시글 Top 10
	public List<Board> getBoardList() {
		return sqlSession.selectList("adminloginSql.getBoardList");
	}

	//오늘의 가입자수
	public int enrollCount() {
		return sqlSession.selectOne("adminloginSql.enrollCount");
	}

	//오늘의 게시물 수
	public int boardCount() {
		return sqlSession.selectOne("adminloginSql.boardCount");
	}

	//총 게시물 수
	public int totalBoardCount() {
		return sqlSession.selectOne("adminloginSql.totalBoardCount");
	}

	//vip 회원 구분
	public String getUserGrade(String idG) {
		return sqlSession.selectOne("adminloginSql.getUserGrade", idG);
	}

	

}
