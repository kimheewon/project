package com.interntraining.admin.adminBoard.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.adminBoard.dao.AdminBoardDAO;
import com.interntraining.admin.adminBoard.domain.AdminBoardInfo;
import com.interntraining.member.board.domain.Comment;

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

	//입력한 정보 DB에 저장
	@Override
	public void insertBoardInfo(AdminBoardInfo adminBoardInfo) {
		adminBoardDAO.insertBoardInfo(adminBoardInfo);
		
	}

	//관리자 id 찾기
	@Override
	public String selectAdminId(int intAdminNo) {
		return adminBoardDAO.selectAdminId(intAdminNo);
	}

	//게시글 정보 가져오기(제목, 작성자, adminId, 글내용)
	@Override
	public AdminBoardInfo selectBoardInfo(int boardNo) {
		return adminBoardDAO.selectBoardInfo(boardNo);
	}

	//댓글 내용 가져오기
	@Override
	public List<Comment> selectCommentList(int boardNo) {
		return adminBoardDAO.selectCommentList(boardNo);
	}

	//글 삭제
	@Override
	public void deleteboard(int boardNo) {
		adminBoardDAO.deleteboard(boardNo);
	}

	//글번호로 게시글 내용 가져오기
	@Override
	public AdminBoardInfo selectBoard(int boardNo) {
		return adminBoardDAO.selectBoard(boardNo);
	}

	//부모게시판 명 불러오기
	@Override
	public AdminBoardInfo selectCategoryParentName(int boardCateNo) {
		return adminBoardDAO.selectCategoryParentName(boardCateNo);
	}

	

}
