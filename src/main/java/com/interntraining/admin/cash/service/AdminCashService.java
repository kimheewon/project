package com.interntraining.admin.cash.service;

import java.math.BigInteger;
import java.util.List;

import com.interntraining.member.cash.domain.PGInfo;

public interface AdminCashService {

	//캐시 내역 가져오기
	public List<PGInfo> selectCashList(int userNo);

	//유저 아이디 찾기
	public String selectUserId(int userNo);

	//결제 취소
	public void cashCancel(BigInteger cashNo);

}
