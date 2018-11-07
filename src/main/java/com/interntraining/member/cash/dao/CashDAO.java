package com.interntraining.member.cash.dao;

import java.math.BigInteger;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.member.cash.domain.PGInfo;

@Repository("cashDAO")
public class CashDAO {
	
	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;

	//결재번호
	public BigInteger selectOrderNo() {
		return sqlSession.selectOne("cashSql.selectOrderNo");
	}

	//PK 저장
	public void insertOrderNo(BigInteger intOrderNo) {
		sqlSession.insert("cashSql.insertOrderNo", intOrderNo);
	}

	//DB에  결제 결과값 저장
	public void insertPgResult(PGInfo pgInfo) {
		sqlSession.insert("cashSql.insertPgResult", pgInfo);		
	}


}
