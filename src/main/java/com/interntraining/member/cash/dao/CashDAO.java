package com.interntraining.member.cash.dao;

import java.math.BigInteger;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.member.cash.domain.PGInfo;
import com.interntraining.member.login.domain.User;

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

	//회원 번호 찾기
	public int selectUserId(String id) {
		return sqlSession.selectOne("cashSql.selectUserId",id);
	}

	//Cash 충전
	public void updateUserCashMst(User userNew) {
		sqlSession.update("cashSql.updateUserCashMst", userNew);
	}

	//유저의 기존 보유 캐시 정보 가져오기
	public User selectUserCashInfo(int userNo) {
		return sqlSession.selectOne("cashSql.selectUserCashInfo",userNo);
	}

	//충전한 캐시정보 가져오기
	public int selectPgCashAmount(String orderNo) {		
		return sqlSession.selectOne("cashSql.selectPgCashAmount",orderNo);
	}


}
