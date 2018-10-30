package com.interntraining.member.login.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.boardCategory.domain.BoardCategoryInfo;
import com.interntraining.member.login.dao.LoginDAO;
import com.interntraining.member.login.domain.User;

@Service()
public class LoginServiceImpl implements LoginService {
	
    @Resource(name = "loginDAO")
    private LoginDAO loginDAO;

    @Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;
    
   
    //로그인 - DB에서 id 확인
	@Override
	public boolean logincheck(String id, String password) throws Exception {
		User result = loginDAO.selectOne(id);
		
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
		return loginDAO.selectOne(id);
	}

	//마이페이지
	@Override
	public User myPage(String id) {
		return loginDAO.selectUser(id);
	}

	//회원정보 수정	
	@Override
	public void updateMember(User user) {
		loginDAO.updateMember(user);
		
	}

	//db에서 게시판 카테고리 항목 불러오기
	@Override
	public List<BoardCategoryInfo> boardCategoryList() {
		return loginDAO.boardCategoryList();
	}

	

	
}
