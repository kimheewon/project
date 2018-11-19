package com.interntraining.member.login.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.boardCategory.domain.BoardCategoryInfo;
import com.interntraining.member.login.domain.User;
import com.interntraining.member.user.domain.Member;



@Repository("loginDAO")
public class LoginDAO {
	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
		
	//로그인
	public User selectOne(String id) throws Exception{
		return sqlSession.selectOne("sql.selectOne",id);		
	}

	//마이페이지
	public User selectUser(String id) {
		return sqlSession.selectOne("sql.selectUser",id);
	}

	//회원정보 수정	
	public void updateMember(User user) {
		sqlSession.insert("sql.updateMember",user);
		
	}

	//db에서 게시판 카테고리 항목 불러오기
	public List<BoardCategoryInfo> boardCategoryList() {
		return sqlSession.selectList("sql.boardCategoryList");
	}

	//보유캐시 정보
	public User selectCashInfo(int userNo) {
		return sqlSession.selectOne("sql.selectCashInfo",userNo);
	}

	//비밀번호 확인
	public String passwordCheck(User user) {
		return sqlSession.selectOne("userSql.passwordCheck",user);
	}

	

}
