package com.interntraining.member.login.service;

import java.util.List;

import com.interntraining.admin.boardCategory.domain.BoardCategoryInfo;
import com.interntraining.member.login.domain.User;


public interface LoginService {

	//로그인 - DB에서 id 확인
	public boolean logincheck(String id, String password) throws Exception;

	//로그인
	public User selectOne(String id) throws Exception;

	//마이페이지
	public User myPage(String id);

	//회원정보 수정
	public void updateMember(User user);

	//db에서 게시판 카테고리 항목 불러오기
	public List<BoardCategoryInfo> boardCategoryList();

	//보유캐시 정보
	public User selectCashInfo(int userNo);

	
	
}
