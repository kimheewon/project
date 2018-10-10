package com.interntraining.admin.administrator.service;

import java.util.List;

import com.interntraining.admin.administrator.domain.AdministratorInfo;

public interface AdministratorService {

	//관리자 목록
	public List<AdministratorInfo> selectAdminList();

}
