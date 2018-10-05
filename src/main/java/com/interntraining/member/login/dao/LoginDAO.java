package com.interntraining.member.login.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;


import com.interntraining.member.login.domain.User;
import com.interntraining.member.user.domain.Member;



@Repository("loginDAO")
public class LoginDAO {
	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
		
	//로그인
	public User selectOne(String id) throws Exception{
		return sqlSession.selectOne("sql.selectOne",id);		
	}

	//마이페이지
	public User selectUser(String id) {
		return sqlSession.selectOne("sql.selectUser",id);
	}

	//회원정보 수정	
	public void updateMember(User user) {
		sqlSession.insert("sql.updateMember",user);
		
	}

	

}
