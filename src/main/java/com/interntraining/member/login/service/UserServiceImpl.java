package com.interntraining.member.login.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.member.login.dao.UserDAO;
import com.interntraining.member.login.domain.User;




@Service()
public class UserServiceImpl implements UserService {
	
    @Resource(name = "userDAO")
    private UserDAO userDAO;

    @Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;
    
   
    //로그인 - DB에서 id 확인
	@Override
	public boolean logincheck(String id, String password) throws Exception {
		User result = userDAO.selectOne(id);
		
		if(result == null) {
	       	return false;
	    } else {  
	    	String oPwd = result.getStrUserPw(); //db 명(키, 값)
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

	//로그인-DB에서 id에 해당하는 회원 정보 가져옴
	@Override
	public User selectOne(String id) throws Exception {
		return userDAO.selectOne(id);
	}

	
}
