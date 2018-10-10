package com.interntraining.admin.administrator.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.administrator.dao.AdministratorDAO;
import com.interntraining.admin.administrator.domain.AdministratorInfo;

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

}
