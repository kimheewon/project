package com.interntraining.member.cash.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.member.cash.dao.CashDAO;

@Service()
public class CashServiceImpl implements CashService{

	@Resource(name = "cashDAO")
	private CashDAO cashDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;
}
