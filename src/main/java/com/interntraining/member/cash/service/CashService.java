package com.interntraining.member.cash.service;

import java.math.BigInteger;
import java.util.List;

import com.interntraining.member.board.domain.Pagination;
import com.interntraining.member.cash.domain.PGInfo;
import com.interntraining.member.cash.domain.PaginationCash;
import com.interntraining.member.cash.domain.PgRequest;
import com.interntraining.member.itemShop.domain.ItemShopInfo;
import com.interntraining.member.login.domain.User;

public interface CashService {

	public PGInfo purchase(PGInfo sendObject);

	//결재번호
	public BigInteger selectOrderNo();

	//DB에  결제 결과값 저장
	public void insertPgResult(PGInfo pgInfo);

	//Cash 충전
	public void updateUserCashMst(PGInfo pgInfo);

	//회원 번호 찾기
	public int selectUserNo(String id);

	//회원의 현재 보유 캐시정보
	public User selectUserCashInfo(int userNo, String orderNo);

	//캐시 내역 가져오기
	public List<PGInfo> selectCashList(int userNo);

	//캐시 내역 페이징처리
	public List<PGInfo> selectCashPaging(PaginationCash pagination);

	
	//요청값과 결과값 비교
	public int checkResult(PGInfo pgInfo);

	//상태 update
	public void updateState(int orderNo);

	//캐시 내역 가져오기(날짜검색)
	public List<PGInfo> searchCashList(ItemShopInfo info);

	//캐시 내역 페이징처리(날짜검색)
	public List<PGInfo> searchCashPaging(PaginationCash pagination);


}
