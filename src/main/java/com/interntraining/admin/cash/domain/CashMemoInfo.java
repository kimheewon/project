package com.interntraining.admin.cash.domain;

import java.math.BigInteger;

public class CashMemoInfo {

	private int intUserNo;		//userNo
	private int intType;		//1:지급	2:회수
	private String strMemo;		//사유
	private BigInteger intNumber;		//번호(cashNo or 상품번호)
	private int intAmount;		//캐시
	
	private String strState;	//상태
	private String strDate; 	//날짜
	private String strCash;
	private int intAdminNo;
	
	public int getIntUserNo() {
		return intUserNo;
	}
	public void setIntUserNo(int intUserNo) {
		this.intUserNo = intUserNo;
	}
	public int getIntType() {
		return intType;
	}
	public void setIntType(int intType) {
		this.intType = intType;
	}
	public String getStrMemo() {
		return strMemo;
	}
	public void setStrMemo(String strMemo) {
		this.strMemo = strMemo;
	}
	
	public BigInteger getIntNumber() {
		return intNumber;
	}
	public void setIntNumber(BigInteger intNumber) {
		this.intNumber = intNumber;
	}
	public int getIntAmount() {
		return intAmount;
	}
	public void setIntAmount(int intAmount) {
		this.intAmount = intAmount;
	}
	public String getStrState() {
		return strState;
	}
	public void setStrState(String strState) {
		this.strState = strState;
	}
	public String getStrDate() {
		return strDate;
	}
	public void setStrDate(String strDate) {
		this.strDate = strDate;
	}
	
	
	public String getStrCash() {
		return strCash;
	}
	public void setStrCash(String strCash) {
		this.strCash = strCash;
	}
	public int getIntAdminNo() {
		return intAdminNo;
	}
	public void setIntAdminNo(int intAdminNo) {
		this.intAdminNo = intAdminNo;
	}
	
	
}
