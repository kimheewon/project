package com.interntraining.admin.loginAdmin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.authority.domain.AuthItemInfo;
import com.interntraining.admin.authority.domain.AuthMapp;
import com.interntraining.admin.loginAdmin.dao.LoginAdminDAO;
import com.interntraining.admin.loginAdmin.domain.LoginAdminInfo;




@Service()
public class LoginAdminServiceImpl implements LoginAdminService{

	@Resource(name = "loginAdminDAO")
    private LoginAdminDAO loginAdminDAO;

	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;
	
	//로그인 정보 가져오기
	@Override
	public LoginAdminInfo selectOne(String id) {
		return loginAdminDAO.selectOne(id);
	}

	//로그인 - DB에서 id 확인
	@Override
	public boolean logincheck(String id, String password) throws Exception {
		LoginAdminInfo result = loginAdminDAO.selectOne(id);
		
		if(result == null) {
	       	return false;
	    } else {  
	    	String oPwd = result.getStrAdminPw();
	        if(oPwd==null)
	        	return false;
	        else{
	        	if(oPwd.equals(password))
	        		return true;
	        	else
	        		return false;
	        }
	            
	    }
	}

	//권항 항목 가져오기
	@Override
	public List<AuthMapp> selectItemList(int authno) {
		return loginAdminDAO.selectItemList(authno);
	}

}
