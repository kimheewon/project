package com.interntraining.admin.administrator.domain;

import java.util.Date;

public class AdministratorInfo {

	private int intAdminNo;
	private String StrAdminId;
	private String StrAdminPw;
	private String StrAdminName;	
	private int intAdminAuth;
	private String StrAdminGrade;
	private Date DateAdminDate;
	
	public int getIntAdminNo() {
		return intAdminNo;
	}
	public void setIntAdminNo(int intAdminNo) {
		this.intAdminNo = intAdminNo;
	}
	public String getStrAdminId() {
		return StrAdminId;
	}
	public void setStrAdminId(String strAdminId) {
		StrAdminId = strAdminId;
	}
	public String getStrAdminPw() {
		return StrAdminPw;
	}
	public void setStrAdminPw(String strAdminPw) {
		StrAdminPw = strAdminPw;
	}
	public String getStrAdminName() {
		return StrAdminName;
	}
	public void setStrAdminName(String strAdminName) {
		StrAdminName = strAdminName;
	}
	
	public int getIntAdminAuth() {
		return intAdminAuth;
	}
	public void setIntAdminAuth(int intAdminAuth) {
		this.intAdminAuth = intAdminAuth;
	}
	public String getStrAdminGrade() {
		return StrAdminGrade;
	}
	public void setStrAdminGrade(String strAdminGrade) {
		StrAdminGrade = strAdminGrade;
	}
	public Date getDateAdminDate() {
		return DateAdminDate;
	}
	public void setDateAdminDate(Date dateAdminDate) {
		DateAdminDate = dateAdminDate;
	}


	
}
