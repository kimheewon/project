package com.interntraining.member.login.service;


import com.interntraining.member.login.domain.User;

public interface UserService {

	//로그인 - DB에서 id 확인
	public boolean logincheck(String id, String password) throws Exception;

	//로그인
	public User selectOne(String id) throws Exception;
	
	
}
