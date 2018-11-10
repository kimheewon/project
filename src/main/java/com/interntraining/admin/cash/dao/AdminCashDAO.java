package com.interntraining.admin.cash.dao;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.cash.domain.PgCancelInfo;
import com.interntraining.member.cash.domain.PGInfo;

@Repository("adminCashDAO")
public class AdminCashDAO {
	
	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;

	//캐시 내역 가져오기
	public List<PGInfo> selectCashList(int userNo) {		
		return sqlSession.selectList("cashSql.selectCashList", userNo);
	}
	
	//유저 아이디 찾기
	public String selectUserId(int userNo) {
		return sqlSession.selectOne("cashSql.selectUserId", userNo);
	}

	//보낼 취소 정보 가져오기
	public PgCancelInfo cashCancel(BigInteger cashNo) {
		return sqlSession.selectOne("cashSql.cashCancel", cashNo);
	}

}
