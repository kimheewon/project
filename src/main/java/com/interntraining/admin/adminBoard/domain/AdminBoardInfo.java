package com.interntraining.admin.adminBoard.domain;

import java.util.Date;

public class AdminBoardInfo {

	private int intBoardNo;
	private String strUserId;
	private String strBoardTitle;
	private String strBoardContent;
	private Date dateBoardDate;
	private String strBoardDate;
	private int intNewCheck;
	private int intHit;
	private int inttotalComment;
	private String strGrade;
	private int intBoardCateNo;
	private String strBoardCateNo;	//카테고리 번호(문자열)
	private int intBoardNotice;		//공지여부
	private int intAdmincheck;		//관리자 작성 여부
	private int intAdminNo;			//관리자 번호
	private String strAdminId;		//관리자 ID
	private String strBoardCateName;
	
	
	public String getStrBoardCateName() {
		return strBoardCateName;
	}
	public void setStrBoardCateName(String strBoardCateName) {
		this.strBoardCateName = strBoardCateName;
	}
	public int getIntBoardNo() {
		return intBoardNo;
	}
	public void setIntBoardNo(int intBoardNo) {
		this.intBoardNo = intBoardNo;
	}
	public String getStrUserId() {
		return strUserId;
	}
	public void setStrUserId(String strUserId) {
		this.strUserId = strUserId;
	}
	public String getStrBoardTitle() {
		return strBoardTitle;
	}
	public void setStrBoardTitle(String strBoardTitle) {
		this.strBoardTitle = strBoardTitle;
	}
	public String getStrBoardContent() {
		return strBoardContent;
	}
	public void setStrBoardContent(String strBoardContent) {
		this.strBoardContent = strBoardContent;
	}
	public Date getDateBoardDate() {
		return dateBoardDate;
	}
	public void setDateBoardDate(Date dateBoardDate) {
		this.dateBoardDate = dateBoardDate;
	}
	public String getStrBoardDate() {
		return strBoardDate;
	}
	public void setStrBoardDate(String strBoardDate) {
		this.strBoardDate = strBoardDate;
	}
	public int getIntNewCheck() {
		return intNewCheck;
	}
	public void setIntNewCheck(int intNewCheck) {
		this.intNewCheck = intNewCheck;
	}
	public int getIntHit() {
		return intHit;
	}
	public void setIntHit(int intHit) {
		this.intHit = intHit;
	}
	public int getInttotalComment() {
		return inttotalComment;
	}
	public void setInttotalComment(int inttotalComment) {
		this.inttotalComment = inttotalComment;
	}
	public String getStrGrade() {
		return strGrade;
	}
	public void setStrGrade(String strGrade) {
		this.strGrade = strGrade;
	}
	public int getIntBoardCateNo() {
		return intBoardCateNo;
	}
	public void setIntBoardCateNo(int intBoardCateNo) {
		this.intBoardCateNo = intBoardCateNo;
	}
	public int getIntBoardNotice() {
		return intBoardNotice;
	}
	public void setIntBoardNotice(int intBoardNotice) {
		this.intBoardNotice = intBoardNotice;
	}
	public String getStrBoardCateNo() {
		return strBoardCateNo;
	}
	public void setStrBoardCateNo(String strBoardCateNo) {
		this.strBoardCateNo = strBoardCateNo;
	}
	public int getIntAdmincheck() {
		return intAdmincheck;
	}
	public void setIntAdmincheck(int intAdmincheck) {
		this.intAdmincheck = intAdmincheck;
	}
	public int getIntAdminNo() {
		return intAdminNo;
	}
	public void setIntAdminNo(int intAdminNo) {
		this.intAdminNo = intAdminNo;
	}
	public String getStrAdminId() {
		return strAdminId;
	}
	public void setStrAdminId(String strAdminId) {
		this.strAdminId = strAdminId;
	}
	
	
	
}
