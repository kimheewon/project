package com.interntraining.admin.loginAdmin.service;

import java.util.List;

import com.interntraining.admin.authority.domain.AuthMapp;
import com.interntraining.admin.loginAdmin.domain.LoginAdminInfo;

public interface LoginAdminService {

	//로그인 정보 가져오기
	public LoginAdminInfo selectOne(String id);

	//로그인 - DB에서 id 확인
	public boolean logincheck(String id, String password) throws Exception;

	//권항 항목 가져오기
	public List<AuthMapp> selectItemList(int authno);
}
