package com.interntraining.member.login.service;

import com.interntraining.member.login.domain.User;


public interface LoginService {

	//로그인 - DB에서 id 확인
	public boolean logincheck(String id, String password) throws Exception;

	//로그인
	public User selectOne(String id) throws Exception;

	//마이페이지
	public User myPage(String id);

	//회원정보 수정
	public void updateMember(User user);

	
	
}
