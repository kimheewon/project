package com.interntraining.member.cash.service;

import java.math.BigInteger;

import com.interntraining.member.cash.domain.PGInfo;

public interface CashService {

	public PGInfo purchase(PGInfo sendObject);

	//결재번호
	public String selectOrderNo();

	//DB에  결제 결과값 저장
	public void insertPgResult(PGInfo pgInfo);

}
