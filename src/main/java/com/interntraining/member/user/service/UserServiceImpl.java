package com.interntraining.member.user.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.member.user.dao.UserDAO;



@Service()
public class UserServiceImpl implements UserService {
	
    @Resource(name = "userDAO")
    private UserDAO userDAO;

    @Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;
    
   
    
}
