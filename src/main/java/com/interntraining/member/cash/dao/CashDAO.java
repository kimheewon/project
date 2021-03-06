package com.interntraining.member.cash.dao;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.member.board.domain.Pagination;
import com.interntraining.member.cash.domain.PGInfo;
import com.interntraining.member.cash.domain.PaginationCash;
import com.interntraining.member.cash.domain.PgRequest;
import com.interntraining.member.itemShop.domain.ItemShopInfo;
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
	public int selectUserNo(String id) {
		return sqlSession.selectOne("cashSql.selectUserNo",id);
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

	//캐시 내역 가져오기
	public List<PGInfo> selectCashList(int userNo) {
		return sqlSession.selectList("cashSql.selectCashList",userNo);
	}

	//캐시 내역 페이징처리
	public List<PGInfo> selectCashPaging(PaginationCash pagination) {
		return sqlSession.selectList("cashSql.selectCashPaging",pagination);
	}

	//결제 요청 저장
	public void insertCashRequest(PGInfo sendObject) {
		sqlSession.insert("cashSql.insertCashRequest", sendObject);
	}

	//order번호 가져오기
	public int selectRequestOrderNo() {
		return sqlSession.selectOne("cashSql.selectRequestOrderNo");
	}

	//DB에서 요청 정보 가져오기
	public PgRequest selectRequestInfo(int orderNo) {
		return sqlSession.selectOne("cashSql.selectRequestInfo",orderNo);
	}

	//상태 update
	public void updateState(int orderNo) {
		sqlSession.update("cashSql.updateState",orderNo );
	}
	
	//캐시 내역 가져오기(날짜검색)
	public List<PGInfo> searchCashList(ItemShopInfo info) {
		return sqlSession.selectList("cashSql.searchCashList",info);
	}

	//캐시 내역 페이징처리(날짜검색)
	public List<PGInfo> searchCashPaging(PaginationCash pagination) {
		return sqlSession.selectList("cashSql.searchCashPaging",pagination);
	}


}
