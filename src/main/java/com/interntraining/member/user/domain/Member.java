package com.interntraining.member.user.domain;

import java.util.Date;

public class Member {
	private int intUserNo;
	private String StrUserId;
	private String StrUserPw;
	private String StrUserName;
	private String StrUserPhone;
	private String StrUserEmail;
	private String StrUserSex;	
	private String StrUserBirth;
	private Date DateUserDate;
	private String StrUserGrade;

	public int getIntUserNo() {
		return intUserNo;
	}
	public void setIntUserNo(int intUserNo) {
		this.intUserNo = intUserNo;
	}
	public String getStrUserId() {
		return StrUserId;
	}
	public void setStrUserId(String strUserid) {
		StrUserId = strUserid;
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
	public String getStrUserSex() {
		return StrUserSex;
	}
	public void setStrUserSex(String strUserSex) {
		StrUserSex = strUserSex;
	}
	public String getStrUserBirth() {
		return StrUserBirth;
	}
	public void setStrUserBirth(String strUserBirth) {
		StrUserBirth = strUserBirth;
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
