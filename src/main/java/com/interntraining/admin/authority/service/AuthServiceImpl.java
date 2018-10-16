package com.interntraining.admin.authority.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.authority.dao.AuthDAO;
import com.interntraining.admin.authority.domain.AuthInfo;
import com.interntraining.admin.authority.domain.AuthItemInfo;
import com.interntraining.admin.authority.domain.AuthMapp;


@Service()
public class AuthServiceImpl implements AuthService{

	@Resource(name = "authDAO")
	private AuthDAO authDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;
	
			
	//권한명 이름 중복 체크
	@Override
	public AuthInfo selectName(String name) {
		return authDAO.selectName(name) ;
	}

	//모든 권한 항목 불러오기
	@Override
	public List<AuthItemInfo> selectAllAuthItem() {
		return authDAO.selectAllAuthItem();
	}

	//권한명 저장
	@Override
	public void insertAuthName(String authName) {
		authDAO.insertAuthName(authName);
	}

	//등록한 권한명의 번호 불러오기
	@Override
	public int selectAuthNo(String authName) {
		return authDAO.selectAuthNo(authName);
	}

	//매핑테이블에 저장
	@Override
	public void insertAuthMapp(AuthMapp authMapp) {
		authDAO.insertAuthMapp(authMapp);
		
	}

	//권한명 모두 가져오기
	@Override
	public List<AuthInfo>  selectAllAuth() {
		return authDAO.selectAllAuth();
	}

	//권한번호로 권한명 찾기(Auth 테이블에서)
	@Override
	public String selectAuthName(int authNo) {
		return authDAO.selectAuthName(authNo);
	}

	//권한번호로 권한항목 찾기(AuthMapp 테이블에서)
	@Override
	public List<AuthMapp> selectAuthItem(int authNo) {
		return authDAO.selectAuthItem(authNo);
	}

}
