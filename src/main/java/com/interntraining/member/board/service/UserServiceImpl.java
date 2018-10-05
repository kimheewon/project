package com.interntraining.member.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.member.board.dao.UserDAO;
import com.interntraining.member.board.domain.Board;
import com.interntraining.member.board.domain.Comment;


@Service()
public class UserServiceImpl implements UserService {
	
    @Resource(name = "userDAO")
    private UserDAO userDAO;

    @Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;
    
   
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
	public Board readboard(int intBoardNo) throws Exception{
		return userDAO.readboard(intBoardNo);
	}
	
	//수정한 게시글 저장
	@Override
	public void updateboard(Board board) throws Exception{
		userDAO.updateboard(board);
	}
	
	//댓글 뿌려주기
	@Override
	public List<Comment> selectcmmtlist(int intBoardNo) throws Exception{
		return userDAO.selectcmmtlist(intBoardNo); 
	}

	//댓글 저장
	@Override
	public void insertComment(Comment comment) throws Exception {
		userDAO.insertcommnet(comment);;
	}
}
