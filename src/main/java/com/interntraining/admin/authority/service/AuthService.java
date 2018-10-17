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

	//권한번호로 권한명 찾기(Auth 테이블에서)
	public String selectAuthName(int authNo);

	//권한번호로 권한항목 찾기(AuthMapp 테이블에서)
	public List<AuthMapp> selectAuthItem(int authNo);

	//수정에서 권한명 중복체크
	public AuthInfo selectUpdateAuthName(AuthInfo auth);

	//권한명 업데이트
	public void updateAuthName(AuthInfo auth);

	//권한 번호로 Mapp 테이블에 있는 데이터 삭제
	public void deleteItems(int authNo);

	

}
