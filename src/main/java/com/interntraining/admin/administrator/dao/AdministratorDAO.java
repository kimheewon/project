package com.interntraining.admin.administrator.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.administrator.domain.AdministratorInfo;
import com.interntraining.admin.authority.domain.AuthInfo;

@Repository("administratorDAO")
public class AdministratorDAO {

	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
	
	public List<AdministratorInfo> selectAdminList() {
		return sqlSession.selectList("administratorSql.selectAll");
	}

	//DB에서 id 체크
	public AdministratorInfo selectId(String id) {
		return sqlSession.selectOne("administratorSql.selectId",id);
	}

	//관리자 등록
	public void insertmember(AdministratorInfo admin) {
		sqlSession.insert("administratorSql.insertAdmin",admin);
	}

	//권한명 모두 가져오기
	public List<AuthInfo> selectAllAuth() {
		return sqlSession.selectList("authSql.selectAllAuth");
	}

	//권한명 가져오기
	public String selectAuth(int auth) {
		return sqlSession.selectOne("authSql.selectAuth", auth);
	}

	//관리자 정보 가져오기
	public AdministratorInfo selectAdmin(int intAdminNo) {
		return sqlSession.selectOne("administratorSql.selectAdmin", intAdminNo);
	}


}
