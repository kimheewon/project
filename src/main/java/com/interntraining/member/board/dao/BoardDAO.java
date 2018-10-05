package com.interntraining.member.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;


import com.interntraining.member.board.domain.Board;
import com.interntraining.member.board.domain.Comment;


@Repository("boardDAO")
public class BoardDAO {
	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
		
	
	//게시판 List 뿌리기
	public List<Board> selectboardlist(Board board) {
		return sqlSession.selectList("sql.selectboardlist", board);
	}
	
	//게시글 작성
	public void insertboard(Board board) {
		sqlSession.insert("sql.insertboard",board);
	}
	
	//게시글 읽기
	public Board readboard(int intBoardNo) {
		return sqlSession.selectOne("sql.boardread", intBoardNo);
	}
	
	//수정한 게시글 저장
	public void updateboard(Board board) {
		sqlSession.insert("sql.boardupdate",board);
	}
	
	//댓글 뿌리기
	public List<Comment> selectcmmtlist(int intBoardNo){
		return sqlSession.selectList("sql.selectcmmtlist", intBoardNo);
	}
	
	//댓글 저장
	public void insertcommnet(Comment comment) {
		sqlSession.insert("sql.insertcomment", comment);
	}
}
