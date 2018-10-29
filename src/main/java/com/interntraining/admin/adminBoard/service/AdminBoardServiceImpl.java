package com.interntraining.admin.adminBoard.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.adminBoard.dao.AdminBoardDAO;
import com.interntraining.admin.adminBoard.domain.AdminBoardInfo;

@Service()
public class AdminBoardServiceImpl implements AdminBoardService{

	@Resource(name = "adminBoardDAO")
	private AdminBoardDAO adminBoardDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;	
		
	//해당 게시판 글 모두 가져오기
	@Override
	public List<AdminBoardInfo> selectAllBoard(int boardCateNo) {
		return adminBoardDAO.selectAllBoard(boardCateNo);
	}

	//게시판 명 불러오기
	@Override
	public String selectBoardName(int boardCateNo) {
		return adminBoardDAO.selectBoardName(boardCateNo);
	}

}
