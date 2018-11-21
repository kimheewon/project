package com.interntraining.member.user.service;

import com.interntraining.member.user.domain.Member;

public interface UserService {

	//DB에서 id 체크
	public Member selectId(String id);

	//회원 가입
	public void insertMember(Member member);

	//회원번호 찾기
	public int selectUserNo(String strUserId);

	//계좌만들기
	public void insertUserCashAmt(int userNo);
		

	
	
	
}
