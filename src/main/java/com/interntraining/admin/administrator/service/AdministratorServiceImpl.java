package com.interntraining.admin.administrator.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.administrator.dao.AdministratorDAO;
import com.interntraining.admin.administrator.domain.AdministratorInfo;
import com.interntraining.admin.authority.domain.AuthInfo;

@Service()
public class AdministratorServiceImpl implements AdministratorService{

	@Resource(name = "administratorDAO")
	private AdministratorDAO administratorDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;
	
	//관리자 목록
	@Override
	public List<AdministratorInfo> selectAdminList() {
		return administratorDAO.selectAdminList();
	}

    //DB에서 id 체크
	@Override
	public AdministratorInfo selectId(String id) {
		return administratorDAO.selectId(id);
	}

	//관리자 등록
	@Override
	public void insertAdmin(AdministratorInfo admin) {
		administratorDAO.insertmember(admin);
		
	}

	//권한명 모두 가져오기
	@Override
	public List<AuthInfo> selectAllAuth() {
		return administratorDAO.selectAllAuth();
	}

	//권한명 가져오기
	@Override
	public String selectAuth(int auth) {
		return administratorDAO.selectAuth(auth);
	}

	//관리자 정보 가져왹
	@Override
	public AdministratorInfo selectAdmin(int intAdminNo) {
		return administratorDAO.selectAdmin(intAdminNo);
	}

	//권한번호로 맨 상위 권한 항목 가져오기
	@Override
	public int selectItemNo(int authNo) {
		return administratorDAO.selectItemNo(authNo);
	}

	//수정할 권한번호로 권한항목 개수 가져오기
	@Override
	public int selectItemCount(int authNo) {
		return administratorDAO.selectItemCount(authNo);
	}

	//수정할 관리자의 번호로 권한 번호 찾기
	@Override
	public int selectAuthNo(int adminNo) {
		return administratorDAO.selectAuthNo(adminNo);
	}

	//관리자 정보 업데이트
	@Override
	public void updateAdmin(AdministratorInfo admin) {
		administratorDAO.updateAdmin(admin);
	}

}
