package com.interntraining.admin.user.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;


import com.interntraining.admin.user.domain.Board;
import com.interntraining.admin.user.domain.User;



@Repository("userDAO")
public class UserDAO {
	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
		
	//로그인
	public User selectOne(String id) throws Exception{

		return sqlSession.selectOne("sql.selectOne",id);
		
	}
	
	//게시판 List 뿌리기
	public List<Board> selectboardlist(Board board) {
		return sqlSession.selectList("sql.selectboardlist", board);
	}
	
	//게시글 작성
	public void insertboard(Board board) {
		sqlSession.insert("sql.insertboard",board);
	}
	
	//게시글 읽기
	public Board readboard(int bno) {
		return sqlSession.selectOne("sql.boardread", bno);
	}
	
	//수정한 게시글 저장
	public void updateboard(Board board) {
		sqlSession.insert("sql.boardupdate",board);
	}
}
