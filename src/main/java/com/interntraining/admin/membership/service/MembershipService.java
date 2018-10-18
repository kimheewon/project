package com.interntraining.admin.membership.service;

import java.util.List;

import com.interntraining.admin.membership.domain.MembershipInfo;

public interface MembershipService {

	//DB에 저장된 회원들의 정보 모두 가져오기
	public List<MembershipInfo> selectAllMember();

	//회원 번호를 통해 DB에서 회원 정보 받아오기
	public MembershipInfo selectMember(int intUserNo);
	
	//회웑 정보 번호를 통해 DB에 수정한 정보들 업데이트
	public void updateMember(MembershipInfo member);

	//회원 정보 DB에 저장
	public void insertMember(MembershipInfo member);

	//DB에서 Id 체크
	public String checkId(String id);

}
