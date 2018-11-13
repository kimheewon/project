package com.interntraining.admin.cash.dao;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.cash.domain.CashInfo;
import com.interntraining.admin.cash.domain.CashMemoInfo;
import com.interntraining.admin.cash.domain.PgCancelInfo;
import com.interntraining.member.cash.domain.PGInfo;
import com.interntraining.member.login.domain.User;

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

	//DB에 결제 취소 내역 update
	public void updateCancel(PgCancelInfo cancel) {
		sqlSession.update("cashSql.updateCancel", cancel);
	}

	//사용자 번호 가져오기
	public int selectCancelUserNo(BigInteger cashNo) {
		return sqlSession.selectOne("cashSql.selectCancelUserNo",cashNo);
	}

	//사용자 캐시AMT update(결제 취소)
	public void updateCancelUserCashMst(User userNew) {
		sqlSession.update("cashSql.updateCancelUserCashMst", userNew);		
	}

	//유저의 기존 보유 캐시 정보 가져오기
	public User selectUserCashInfo(int userNo) {
		return sqlSession.selectOne("cashSql.selectUserCashInfo",userNo);
	}

	//캐시 내역 가져오기
	public int selectUserCashAmt(int userNo) {
		return sqlSession.selectOne("cashSql.selectUserCashAmt",userNo);
	}

	//마지막 번호
	public BigInteger selectOrderNo() {
		return sqlSession.selectOne("cashSql.selectOrderNo");
	}

	//pk 저장
	public void insertOrderNo(BigInteger intOrderNo) {
		sqlSession.insert("cashSql.insertOrderNo", intOrderNo);
	}

	//사유 테이블에 입력
	public void insertMemo(CashMemoInfo memo) {
		sqlSession.insert("cashSql.insertMemo", memo);
	}
	
	//캐시 정보 테이블에 입력
	public void insertCashMstPayment(CashMemoInfo memo) {
		sqlSession.insert("cashSql.insertCashMstPayment", memo);
	}

	//cash 충전(회원번호, 충전액)
	public void updateUserCashMst(User userNew) {
		sqlSession.update("cashSql.updateUserCashMst", userNew);		
	}

	//전체 결제 내역 가져오기
	public List<PGInfo> selectAllCashList() {
		return sqlSession.selectList("cashSql.selectAllCashList");
	}

	//관리자 아이디
	public String selectAdminId(int intAdminNo) {
		return sqlSession.selectOne("cashSql.selectAdminId", intAdminNo);
	}

	//회원 목록 가져오기
	public List<User> selectCashMember() {
		return sqlSession.selectList("cashSql.selectCashMember");
	}

	//캐시 회수 번호 가져오기
	public int selectRecallItemNo(String recallItemName) {
		return sqlSession.selectOne("itemSql.selectRecallItemNo",recallItemName);
	}

	//아이템 구매 테이블 insert
	public void insertItemPurchaseRecall(CashMemoInfo memo) {
		sqlSession.insert("itemSql.insertItemPurchaseRecall", memo);
	}

	//remaincash가 있는 리스트 가져오기
	public List<CashInfo> selectCashAllList(int userNo) {
		return sqlSession.selectList("itemSql.selectCashAllList",userNo);
	}

	//구매 매핑테이블에 insert
	public void insertRecallMapping(List<CashInfo> mapping) {
		sqlSession.insert("itemSql.insertRecallMapping", mapping);
	}

	
}
