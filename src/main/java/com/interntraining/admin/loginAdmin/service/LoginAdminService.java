package com.interntraining.admin.loginAdmin.service;

import com.interntraining.admin.loginAdmin.domain.LoginAdminInfo;

public interface LoginAdminService {

	//로그인 정보 가져오기
	public LoginAdminInfo selectOne(String id);

	//로그인 - DB에서 id 확인
	public boolean logincheck(String id, String password) throws Exception;
}
