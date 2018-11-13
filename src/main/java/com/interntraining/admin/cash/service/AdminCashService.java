package com.interntraining.admin.cash.service;

import java.math.BigInteger;
import java.util.List;

import com.interntraining.admin.cash.domain.CashMemoInfo;
import com.interntraining.admin.cash.domain.PgCancelInfo;
import com.interntraining.member.cash.domain.PGInfo;
import com.interntraining.member.login.domain.User;

public interface AdminCashService {

	//캐시 내역 가져오기
	public List<PGInfo> selectCashList(int userNo);

	//유저 아이디 찾기
	public String selectUserId(int userNo);

	//결제 취소
	public PgCancelInfo cashCancel(BigInteger cashNo);

	//DB에 결제 취소 내역 update
	public void updateCancel(PgCancelInfo cancel);

	//사용자 번호 가져오기
	public int selectCancelUserNo(BigInteger cashNo);

	//사용자 캐시AMT update
	public void updateUserCashMst(PgCancelInfo cancel);

	//캐시 내역 가져오기
	public int selectUserCashAmt(int userNo);

	//캐시 지급
	public void cashPayment(CashMemoInfo memo);

	//번호 생성
	public BigInteger selectOrderNo();

	//캐시 정보 테이블에 입력
	public void insertCashMstPayment(CashMemoInfo memo);

	//cash 충전(회원번호, 충전액)
	public void updateUserCashMst(CashMemoInfo memo);

	//전체 결제 내역 가져오기
	public List<PGInfo> selectAllCashList();

	//회원 목록 가져오기
	public List<User> selectCashMember();

	//현재 보유 캐시 정보 가져오기
	public int selectTotalCash(int intUserNo);

	//캐시 회수
	public void cashRecall(CashMemoInfo memo);

	//구매 매핑테이블에 insert
	public void insertRecallMapping(CashMemoInfo memo);

}
