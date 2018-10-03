package com.interntraining.admin.user.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.user.dao.UserDAO;
import com.interntraining.admin.user.domain.Board;
import com.interntraining.admin.user.domain.User;



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
	    	String oPwd = result.getPassword(); //db 명(키, 값)
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

	//로그인
	@Override
	public User selectOne(String id) throws Exception {
		return userDAO.selectOne(id);
	}

	//게시판 글 뿌리기
	@Override
	public List<Board> selectboardlist(Board board) throws Exception {
		return userDAO.selectboardlist(board);
	}

	//게시글 작성
	@Override
	public void insertboard(Board board) throws Exception{
		userDAO.insertboard(board);
	}

	//게시글 읽기
	@Override
	public Board readboard(int bno) throws Exception{
		return userDAO.readboard(bno);
	}
	
	//수정한 게시글 저장
	@Override
	public void updateboard(Board board) throws Exception{
		userDAO.updateboard(board);
	}
		
}
