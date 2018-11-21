package com.interntraining.member.user.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;


import com.interntraining.member.user.dao.UserDAO;
import com.interntraining.member.user.domain.Member;



@Service()
public class UserServiceImpl implements UserService {
	
    @Resource(name = "userDAO")
    private UserDAO userDAO;

    @Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;

    //DB에서 id 체크
	@Override
	public Member selectId(String id) {
		return userDAO.selectId(id);
		
	}

	//회원 가입
	@Override
	public void insertMember(Member member) {
		userDAO.insertmember(member);
		
	}

	//회원번호 찾기
	@Override
	public int selectUserNo(String strUserId) {
		return userDAO.selectUserNo(strUserId);
	}

	//계좌만들기
	@Override
	public void insertUserCashAmt(int userNo) {
		userDAO.insertUserCashAmt(userNo);
	}
    
    
   
    
}
