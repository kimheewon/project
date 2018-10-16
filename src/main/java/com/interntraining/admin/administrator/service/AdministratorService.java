package com.interntraining.admin.administrator.service;

import java.util.List;

import com.interntraining.admin.administrator.domain.AdministratorInfo;
import com.interntraining.admin.authority.domain.AuthInfo;

public interface AdministratorService {

	//관리자 목록
	public List<AdministratorInfo> selectAdminList();

	//DB에서 Id 체크
	public AdministratorInfo selectId(String id);

	//관리자 등록
	public void insertAdmin(AdministratorInfo admin);

	//권한명 모두 가져오기
	public List<AuthInfo> selectAllAuth();

	//권한명 가져오기
	public String selectAuth(int auth);

	//관리자 정보 가져오기
	public AdministratorInfo selectAdmin(int intAdminNo);

}
