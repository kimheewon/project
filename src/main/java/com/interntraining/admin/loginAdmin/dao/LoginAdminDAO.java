package com.interntraining.admin.loginAdmin.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.loginAdmin.domain.LoginAdminInfo;

@Repository("loginAdminDAO")
public class LoginAdminDAO {

	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
	
	//로그인시 관리자ID를 DB에서 확인
	public LoginAdminInfo selectOne(String id) {
		return sqlSession.selectOne("adminloginSql.selectOne",id);	
	}

}
