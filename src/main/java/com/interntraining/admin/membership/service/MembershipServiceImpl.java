package com.interntraining.admin.membership.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.membership.dao.MembershipDAO;
import com.interntraining.admin.membership.domain.MembershipInfo;
import com.interntraining.member.login.domain.User;

@Service 
public class MembershipServiceImpl implements MembershipService{

	@Resource(name = "membershipDAO")
	private MembershipDAO membershipDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;

	//DB에 저장된 회원들의 정보 모두 가져오기
	@Override
	public List<MembershipInfo> selectAllMember() {
		return membershipDAO.selectAllMember();
	}

	//회원 번호를 통해 DB에서 회원 정보 받아오기
	@Override
	public MembershipInfo selectMember(int intUserNo) {
		return membershipDAO.selectMember(intUserNo);
	}
	
	//회웑 정보 번호를 통해 DB에 수정한 정보들 업데이트
	@Override
	public void updateMember(MembershipInfo member) {
		membershipDAO.updateMember(member);
		
	}

	//회원 정보 DB에 저장
	@Override
	public void insertMember(MembershipInfo member) {
		membershipDAO.insertMember(member);
	}

	//DB에서 Id 체크
	@Override
	public String checkId(String id) {
		return membershipDAO.checkId(id);
	}

	//회원의 계좌정보 가져오기
	@Override
	public User selectMemberCashAmt(int intUserNo) {
		return membershipDAO.selectMemberCashAmt(intUserNo);
	}
	
	
}
