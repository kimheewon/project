package com.interntraining.admin.administrator.service;

import java.util.List;

import com.interntraining.admin.administrator.domain.AdministratorInfo;
import com.interntraining.admin.authority.domain.AuthInfo;
import com.interntraining.admin.boardCategory.domain.BoardCategoryInfo;

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

	//권한번호로 맨 상위 권한 항목 가져오기
	public int selectItemNo(int authNo);

	//수정할 권한번호로 권한항목 개수 가져오기
	public int selectItemCount(int authNo);

	//수정할 관리자의 번호로 권한 번호 찾기
	public int selectAuthNo(int adminNo);

	//관리자 정보 업데이트
	public void updateAdmin(AdministratorInfo admin);

	

}
