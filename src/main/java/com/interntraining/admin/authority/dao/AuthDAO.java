package com.interntraining.admin.authority.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.authority.domain.AuthInfo;
import com.interntraining.admin.authority.domain.AuthItemInfo;
import com.interntraining.admin.authority.domain.AuthMapp;

@Repository("authDAO")
public class AuthDAO {
	
	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;

	
	//권한명 중복 체크
	public AuthInfo selectName(String name) {
		return sqlSession.selectOne("authSql.selectName",name);
	}

	//모든 권한 항목 불러오기
	public List<AuthItemInfo> selectAllAuthItem() {
		return sqlSession.selectList("authSql.selectAllAuthItem");
	}

	//권한명 저장
	public void insertAuthName(String authName) {
		sqlSession.insert("authSql.insertAuth", authName);		
	}

	//권한명 번호가져오기
	public int selectAuthNo(String authName) {
	 	return sqlSession.selectOne("authSql.selectAuthNo", authName);
	}
	

	//매핑테이블에 저장
	public void insertAuthMapp(AuthMapp authMapp) {
		sqlSession.insert("authSql.insertAuthMapp",authMapp);
		
	}

	//권한명 모두 가져오기
	public List<AuthInfo> selectAllAuth() {
		return sqlSession.selectList("authSql.selectAllAuth");
	}

	//권한번호로 권한명 찾기(Auth 테이블에서)
	public String selectAuthName(int authNo) {
		return sqlSession.selectOne("authSql.selectAuthName", authNo);
	}

	//권한번호로 권한항목 찾기(AuthMapp 테이블에서)
	public List<AuthMapp> selectAuthItem(int authNo) {
		return sqlSession.selectList("authSql.selectAuthItem", authNo);
	}

	//수정에서 권한명 중복체크
	public AuthInfo selectUpdateAuthName(AuthInfo auth) {
		return sqlSession.selectOne("authSql.selectUpdateAuthName", auth);
	}

	//권한명 업데이트
	public void updateAuthName(AuthInfo auth) {
		sqlSession.update("authSql.updateAuthName",auth);
	}

	//권한 번호로 Mapp 테이블에 있는 데이터 삭제
	public void deleteItems(int authNo) {
		sqlSession.delete("authSql.deleteItems", authNo);
	}
	


}
