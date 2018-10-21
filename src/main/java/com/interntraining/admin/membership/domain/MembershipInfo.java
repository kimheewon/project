package com.interntraining.admin.membership.domain;

import java.util.Date;

public class MembershipInfo {

	private int intUserNo;
	private String strUserId;
	private String strUserPw;
	private String strUserName;
	private String strUserPhone;
	private String strUserEmail;
	private String strUserSex;	
	private Date dateUserDate;
	private String strUserGrade;
	
	public int getIntUserNo() {
		return intUserNo;
	}
	public void setIntUserNo(int intUserNo) {
		this.intUserNo = intUserNo;
	}
	public String getStrUserId() {
		return strUserId;
	}
	public void setStrUserId(String strUserId) {
		this.strUserId = strUserId;
	}
	public String getStrUserPw() {
		return strUserPw;
	}
	public void setStrUserPw(String strUserPw) {
		this.strUserPw = strUserPw;
	}
	public String getStrUserName() {
		return strUserName;
	}
	public void setStrUserName(String strUserName) {
		this.strUserName = strUserName;
	}
	public String getStrUserPhone() {
		return strUserPhone;
	}
	public void setStrUserPhone(String strUserPhone) {
		this.strUserPhone = strUserPhone;
	}
	public String getStrUserEmail() {
		return strUserEmail;
	}
	public void setStrUserEmail(String strUserEmail) {
		this.strUserEmail = strUserEmail;
	}
	public String getStrUserSex() {
		return strUserSex;
	}
	public void setStrUserSex(String strUserSex) {
		this.strUserSex = strUserSex;
	}
	
	public Date getDateUserDate() {
		return dateUserDate;
	}
	public void setDateUserDate(Date dateUserDate) {
		this.dateUserDate = dateUserDate;
	}
	public String getStrUserGrade() {
		return strUserGrade;
	}
	public void setStrUserGrade(String strUserGrade) {
		this.strUserGrade = strUserGrade;
	}
	

	
}
