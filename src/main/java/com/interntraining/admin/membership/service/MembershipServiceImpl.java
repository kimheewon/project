package com.interntraining.admin.membership.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.membership.dao.MembershipDAO;

@Service()
public class MembershipServiceImpl implements MembershipService{

	@Resource(name = "membershipDAO")
	private MembershipDAO membershipDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;
	
}
