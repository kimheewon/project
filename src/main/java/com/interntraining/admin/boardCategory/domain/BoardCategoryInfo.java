package com.interntraining.admin.boardCategory.domain;

import java.util.Date;

public class BoardCategoryInfo {

	private int intBoardCateNo;					//게시판 카테고리 번호
	private String strBoardCateName;			//게시판 카테고리명
	private int intBoardCreateAdminNo;		//게시판 생성자 관리자번호
	private String strBoardCreateAdminId;		//게시판 생성자 관리자아이디
	private Date dateBoardDate;					//게시판 생성일
	private int intParentBoardCateNo;			//부모 게시판 카테고리 번호
	private String strParentBoardCateName;			//부모 게시판 카테고리 이름
	
	public int getIntBoardCateNo() {
		return intBoardCateNo;
	}
	public void setIntBoardCateNo(int intBoardCateNo) {
		this.intBoardCateNo = intBoardCateNo;
	}
	public String getStrBoardCateName() {
		return strBoardCateName;
	}	
	public void setStrBoardCateName(String strBoardCateName) {
		this.strBoardCateName = strBoardCateName;
	}		
	public int getIntBoardCreateAdminNo() {
		return intBoardCreateAdminNo;
	}
	public void setIntBoardCreateAdminNo(int intBoardCreateAdminNo) {
		this.intBoardCreateAdminNo = intBoardCreateAdminNo;
	}
	public String getStrBoardCreateAdminId() {
		return strBoardCreateAdminId;
	}
	public void setStrBoardCreateAdminId(String strBoardCreateAdminId) {
		this.strBoardCreateAdminId = strBoardCreateAdminId;
	}
	public Date getDateBoardDate() {
		return dateBoardDate;
	}
	public void setDateBoardDate(Date dateBoardDate) {
		this.dateBoardDate = dateBoardDate;
	}
	public int getIntParentBoardCateNo() {
		return intParentBoardCateNo;
	}
	public void setIntParentBoardCateNo(int intParentBoardCateNo) {
		this.intParentBoardCateNo = intParentBoardCateNo;
	}
	public String getStrParentBoardCateName() {
		return strParentBoardCateName;
	}
	public void setStrParentBoardCateName(String strParentBoardCateName) {
		this.strParentBoardCateName = strParentBoardCateName;
	}
	
	
	
}
