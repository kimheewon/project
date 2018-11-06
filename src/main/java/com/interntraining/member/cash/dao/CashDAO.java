package com.interntraining.member.cash.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("cashDAO")
public class CashDAO {
	
	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;

	//결재번호
	public int selectOrderNo() {
		sqlSession.insert("cashSql.insertOrderNo");
		return sqlSession.selectOne("cashSql");
	}


}
