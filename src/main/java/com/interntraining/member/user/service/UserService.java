package com.interntraining.member.user.service;

import com.interntraining.member.user.domain.Member;

public interface UserService {

	//DB에서 id 체크
	public Member selectId(String id);

	//회원 가입
	public void insertMember(Member member);
		

	
	
	
}
