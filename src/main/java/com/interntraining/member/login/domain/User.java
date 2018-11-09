package com.interntraining.member.login.domain;

import java.math.BigInteger;
import java.util.Date;

public class User {
	private int    intUserNo;
	private String strUserid;
	private String StrUserPw;
	private String StrUserName;
	private String StrUserPhone;
	private String StrUserEmail;
	private String StrUserSex;	
	private String StrUserBirth;
	private Date   DateUserDate;
	private String StrUserGrade;
	private String StrPostCode;
	private String StrAdress;
	private String StrAdress2;
	private int	   intTotalCashAmt;
	private int	   intTotalInCashAmt;
	private int	   intTotalOutCashAmt;
	private String strOrderNo;
	private int    intAmount;
	private BigInteger intcashNo;
	
	public int getIntUserNo() {
		return intUserNo;
	}
	public void setIntUserNo(int intUserNo) {
		this.intUserNo = intUserNo;
	}
	
	public String getStrUserid() {
		return strUserid;
	}
	public void setStrUserid(String strUserid) {
		this.strUserid = strUserid;
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
	public String getStrPostCode() {
		return StrPostCode;
	}
	public void setStrPostCode(String strPostCode) {
		StrPostCode = strPostCode;
	}
	public String getStrAdress() {
		return StrAdress;
	}
	public void setStrAdress(String strAdress) {
		StrAdress = strAdress;
	}
	public String getStrAdress2() {
		return StrAdress2;
	}
	public void setStrAdress2(String strAdress2) {
		StrAdress2 = strAdress2;
	}
	public int getIntTotalCashAmt() {
		return intTotalCashAmt;
	}
	public void setIntTotalCashAmt(int intTotalCashAmt) {
		this.intTotalCashAmt = intTotalCashAmt;
	}
	public int getIntTotalInCashAmt() {
		return intTotalInCashAmt;
	}
	public void setIntTotalInCashAmt(int intTotalInCashAmt) {
		this.intTotalInCashAmt = intTotalInCashAmt;
	}
	public int getIntTotalOutCashAmt() {
		return intTotalOutCashAmt;
	}
	public void setIntTotalOutCashAmt(int intTotalOutCashAmt) {
		this.intTotalOutCashAmt = intTotalOutCashAmt;
	}
	public String getStrOrderNo() {
		return strOrderNo;
	}
	public void setStrOrderNo(String strOrderNo) {
		this.strOrderNo = strOrderNo;
	}
	public int getIntAmount() {
		return intAmount;
	}
	public void setIntAmount(int intAmount) {
		this.intAmount = intAmount;
	}
	public BigInteger getIntcashNo() {
		return intcashNo;
	}
	public void setIntcashNo(BigInteger intcashNo) {
		this.intcashNo = intcashNo;
	}

	
}
