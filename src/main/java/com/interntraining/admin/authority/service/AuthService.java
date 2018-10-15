package com.interntraining.admin.authority.service;

import java.util.List;

import com.interntraining.admin.authority.domain.AuthInfo;
import com.interntraining.admin.authority.domain.AuthItemInfo;
import com.interntraining.admin.authority.domain.AuthMapp;

public interface AuthService {

	//권한명 중복 체크
	public AuthInfo selectName(String name);

	//모든 권한 항목 불러오기
	public List<AuthItemInfo> selectAllAuthItem();

	//권한명 저장
	public void insertAuthName(String authName);

	//등록한 권한명의 번호 불러오기
	public int selectAuthNo(String authName);

	//매핑테이블에 저장
	public void insertAuthMapp(AuthMapp authMapp);

	//권한명 모두 가져오기
	public List<AuthInfo> selectAllAuth();
	
	

}
