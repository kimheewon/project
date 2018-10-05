package com.interntraining.member.board.domain;

import java.util.Date;

public class User {
	private int intUserNo;
	private String StrUserid;
	private String StrUserPw;
	private String StrUserName;
	private String StrUserPhone;
	private String StrUserEmail;
	private int intUserSex;	
	private int intUserBirth;
	private Date DateUserDate;
	private String StrUserGrade;

	public int getIntUserNo() {
		return intUserNo;
	}
	public void setIntUserNo(int intUserNo) {
		this.intUserNo = intUserNo;
	}
	public String getStrUserid() {
		return StrUserid;
	}
	public void setStrUserid(String strUserid) {
		StrUserid = strUserid;
	}
	public String getStrUserPw() {
		return StrUserPw;
	}
	public void setStrUserPw(String strUserPw) {
		StrUserPw = strUserPw;
	}
	public String getStrUserName() {
		return StrUserName;
	}
	public void setStrUserName(String strUserName) {
		StrUserName = strUserName;
	}
	public String getStrUserPhone() {
		return StrUserPhone;
	}
	public void setStrUserPhone(String strUserPhone) {
		StrUserPhone = strUserPhone;
	}
	public String getStrUserEmail() {
		return StrUserEmail;
	}
	public void setStrUserEmail(String strUserEmail) {
		StrUserEmail = strUserEmail;
	}
	public int getIntUserSex() {
		return intUserSex;
	}
	public void setIntUserSex(int intUserSex) {
		this.intUserSex = intUserSex;
	}
	public int getIntUserBirth() {
		return intUserBirth;
	}
	public void setIntUserBirth(int intUserBirth) {
		this.intUserBirth = intUserBirth;
	}
	public Date getDateUserDate() {
		return DateUserDate;
	}
	public void setDateUserDate(Date dateUserDate) {
		DateUserDate = dateUserDate;
	}
	public String getStrUserGrade() {
		return StrUserGrade;
	}
	public void setStrUserGrade(String strUserGrade) {
		StrUserGrade = strUserGrade;
	}

	
}
