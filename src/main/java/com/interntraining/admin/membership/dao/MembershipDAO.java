package com.interntraining.admin.membership.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.membership.domain.MembershipInfo;
import com.interntraining.member.login.domain.User;

@Repository("membershipDAO")
public class MembershipDAO {

	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;

	//DB에 저장된 회원들의 정보 모두 가져오기
	public List<MembershipInfo> selectAllMember() {
		return sqlSession.selectList("membershipSql.selectAll");
	}

	//회원 번호를 통해 DB에서 회원 정보 받아오기
	public MembershipInfo selectMember(int intUserNo) {
		return sqlSession.selectOne("membershipSql.selectMember", intUserNo);
	}

	//회웑 정보 번호를 통해 DB에 수정한 정보들 업데이트
	public void updateMember(MembershipInfo member) {
		sqlSession.update("membershipSql.updateMember", member);
		
	}

	//회원 정보 DB에 저장
	public void insertMember(MembershipInfo member) {
		sqlSession.insert("membershipSql.insertMember",member);
		
	}

	//DB에서 Id 체크
	public String checkId(String id) {
		return sqlSession.selectOne("membershipSql.checkId", id);
	}

	//회원의 계좌정보 가져오기
	public User selectMemberCashAmt(int intUserNo) {
		return sqlSession.selectOne("membershipSql.selectMemberCashAmt", intUserNo);
	}
}
