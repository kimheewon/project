package com.interntraining.member.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.member.board.dao.BoardDAO;
import com.interntraining.member.board.domain.Board;
import com.interntraining.member.board.domain.Comment;
import com.interntraining.member.board.domain.Pagination;

@Service()
public class BoardServiceImpl implements BoardService {

	@Resource(name = "boardDAO")
	private BoardDAO boardDAO;

	@Autowired
	@Qualifier("mainDBTransactionManager")
	private DataSourceTransactionManager transactionManager;

	// 게시판 글 뿌리기
	@Override
	public List<Board> selectboardlist(Board board) throws Exception {
		return boardDAO.selectboardlist(board);
	}

	
	//게시글 검색
	@Override
	public List<Board> searchboardlist(String keyField, String keyWord) {
		return boardDAO.searchboardlist(keyField,keyWord);
	}
	
	//게시글 검색 페이징
	@Override
	public List<Board> searchboardlistP(Pagination pagination) {
		return boardDAO.searchboardlistP(pagination);
	}

	
	// 게시글 작성
	@Override
	public void insertboard(Board board) throws Exception {
		boardDAO.insertboard(board);
	}

	// 게시글 읽기
	@Override
	public Board readboard(int intBoardNo) throws Exception {
		return boardDAO.readboard(intBoardNo);
	}
	
	//게시글 읽기(조회수 증가)
	@Override
	public Board readboardHit(int intBoardNo) {
		return boardDAO.readboardHit(intBoardNo);
	}

	// 수정한 게시글 저장
	@Override
	public void updateboard(Board board) throws Exception {
		boardDAO.updateboard(board);
	}
	
	//게시글 삭제
	@Override
	public void deleteboard(int bno) {
		boardDAO.deleteboard(bno);
		
	}
	// 댓글 뿌려주기
	@Override
	public List<Comment> selectcmmtlist(int intBoardNo) throws Exception {
		return boardDAO.selectcmmtlist(intBoardNo);
	}

	// 댓글 저장
	@Override
	public void insertComment(Comment comment) throws Exception {
		boardDAO.insertcommnet(comment);
	}

	//댓글 수정
	@Override
	public void updateComment(Comment comment) throws Exception {
		boardDAO.updatecomment(comment);
		
	}

	//댓글 삭제
	@Override
	public void deleteComment(int intCmmtNo) throws Exception {
		boardDAO.deletecomment(intCmmtNo);
		
	}

	//댓글 찾기
	@Override
	public Comment selectComment(Comment comment) {
		return boardDAO.selectcomment(comment);
		
	}


	//게시판 페이징
	@Override
	public List<Board> getBoardList(Pagination pagination){
		return boardDAO.getboardlist(pagination);

	}


	//댓글수
	@Override
	public int totalComment(int intBoardNo) {
		return boardDAO.totalComment(intBoardNo);
	}


	//id로 유저의 등급 찾기
	@Override
	public String getUserGrade(String id) {
		return boardDAO.getUserGrade(id);
	}



}
