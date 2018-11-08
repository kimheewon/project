package com.interntraining.member.cash.service;

import java.math.BigInteger;

import com.interntraining.member.cash.domain.PGInfo;
import com.interntraining.member.login.domain.User;

public interface CashService {

	public PGInfo purchase(PGInfo sendObject);

	//결재번호
	public String selectOrderNo();

	//DB에  결제 결과값 저장
	public void insertPgResult(PGInfo pgInfo);

	//Cash 충전
	public void updateUserCashMst(PGInfo pgInfo);

	//회원 번호 찾기
	public int selectUserId(String id);

	//회원의 현재 보유 캐시정보
	public User selectUserCashInfo(int userNo, String orderNo);


}
