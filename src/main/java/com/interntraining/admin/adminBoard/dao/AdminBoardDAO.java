package com.interntraining.admin.adminBoard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.adminBoard.domain.AdminBoardInfo;
import com.interntraining.member.board.domain.Comment;

@Repository("adminBoardDAO")
public class AdminBoardDAO {

	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
	
	//게시판 글 모듀 가져오기
	public List<AdminBoardInfo> selectAllBoard(int boardCateNo) {
		return sqlSession.selectList("boardSql.selectAllBoard", boardCateNo);
	}

	//게시판 명 불러오기
	public String selectBoardName(int boardCateNo) {
		return sqlSession.selectOne("boardSql.selectBoardName", boardCateNo);
	}

	//입력한 정보 DB에 저장
	public void insertBoardInfo(AdminBoardInfo adminBoardInfo) {
		sqlSession.insert("boardSql.insertBoardInfo", adminBoardInfo);
	}

	//관리자 id 찾기
	public String selectAdminId(int intAdminNo) {
		return sqlSession.selectOne("boardSql.selectAdminId", intAdminNo);
	}

	//게시글 정보 가져오기(제목, 작성자, adminId, 글내용)
	public AdminBoardInfo selectBoardInfo(int boardNo) {
		return sqlSession.selectOne("boardSql.selectBoardInfo", boardNo);
	}

	//댓글 내용 가져오기
	public List<Comment> selectCommentList(int boardNo) {
		return sqlSession.selectList("boardSql.selectCommentList", boardNo);
	}

	//글 삭제
	public void deleteboard(int boardNo) {
		sqlSession.delete("boardSql.deleteboard", boardNo);
	}

}
