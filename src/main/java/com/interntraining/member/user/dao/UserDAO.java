package com.interntraining.member.user.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;


import com.interntraining.member.user.domain.Member;






@Repository("userDAO")
public class UserDAO {
	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
	
	
	//DB에서 id 체크
	public Member selectId(String id) {
		return sqlSession.selectOne("sql.selectId",id);
	}


	//회원가입
	public void insertmember(Member member) {
		sqlSession.insert("sql.insertmember",member);
		
	}

	//회원번호 찾기
	public int selectUserNo(String strUserId) {
		return sqlSession.selectOne("sql.selectUserNo",strUserId);
	}

	//계좌만들기
	public void insertUserCashAmt(int userNo) {
		sqlSession.insert("sql.insertUserCashAmt",userNo);
	}
		
	
}
