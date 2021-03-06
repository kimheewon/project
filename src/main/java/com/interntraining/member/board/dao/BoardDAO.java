package com.interntraining.member.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.boardCategory.domain.BoardCategoryInfo;
import com.interntraining.member.board.domain.Board;
import com.interntraining.member.board.domain.Comment;
import com.interntraining.member.board.domain.Pagination;


@Repository("boardDAO")
public class BoardDAO {
	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
		
	
	//게시판 List 뿌리기
	public List<Board> selectboardlist(Board board) {
		return sqlSession.selectList("sql.selectboardlist", board);
	}
	
	//게시글 검색
	public List<Board> searchboardlist(Board boardInfo) {
		return sqlSession.selectList("sql.searchboardlist", boardInfo);
		
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
		sqlSession.update("sql.boardupdate",board);
	}
	
	//게시글 삭제
	public void deleteboard(int intBoardNo) {
		sqlSession.delete("sql.boarddelete",intBoardNo);
	}
		
	//댓글 뿌리기
	public List<Comment> selectcmmtlist(int intBoardNo){
		return sqlSession.selectList("sql.selectcmmtlist", intBoardNo);
	}
	
	//댓글 저장
	public void insertcommnet(Comment comment) {
		sqlSession.insert("sql.insertcomment", comment);
	}
	
	//댓글 수정
	public void updatecomment(Comment comment) {
		sqlSession.update("sql.updatecmmt", comment);
	}
	
	//댓글 삭제
	public void deletecomment(int intCmmtNo) {
		sqlSession.delete("sql.deletecmmt", intCmmtNo);
	}

	//댓글 찾기
	public Comment selectcomment(Comment comment) {
		return sqlSession.selectOne("sql.commentread",comment);
	}

	//게시판 페이징
	public List<Board> getboardlist(Pagination pagination) {
		return sqlSession.selectList("sql.getboardlist",pagination);
	}


	//게시글 검색 페이징
	public List<Board> searchboardlistP(Pagination pagination) {
		return sqlSession.selectList("sql.searchboardlistP",pagination);
	}

	//댓글수
	public int totalComment(int intBoardNo) {
		return sqlSession.selectOne("sql.totalComment",intBoardNo);
	}

	//게시글 읽기(조회수 증가)
	public Board readboardHit(int intBoardNo) {
		return sqlSession.selectOne("sql.boardreadHit", intBoardNo);
	}

	//id로 유저의 등급 찾기
	public String getUserGrade(String id) {
		return sqlSession.selectOne("sql.getUserGrade", id);
	}

	//db에서 게시판 카테고리 항목 불러오기
	public List<BoardCategoryInfo> boardCategoryList() {
		return sqlSession.selectList("sql.boardCategoryList");
	}

	//게시판 카테고리 번호 찾기
	public int selectBoardCateNo(int intBoardNo) {
		return sqlSession.selectOne("sql.selectBoardCateNo", intBoardNo);
	}

	//댓글의 게시글번호 찾기
	public int selectBoardNo(int intCmmtNo) {
		return sqlSession.selectOne("sql.selectBoardNo", intCmmtNo);
	}

	//카테고리 번호로 게시판명 찾기
	public String selectBoardCateName(int intBoardCateNo) {
		return sqlSession.selectOne("sql.selectBoardCateName", intBoardCateNo);
	}

	
}
