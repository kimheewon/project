package com.interntraining.admin.cash.domain;

import java.math.BigInteger;

public class CashInfo {

	private int intUserNo;
	private BigInteger intCashNo;
	private int intItemNo;
	private int intRemainCash;
	private BigInteger intPurchaseNo;
	
	
	public int getIntUserNo() {
		return intUserNo;
	}
	public void setIntUserNo(int intUserNo) {
		this.intUserNo = intUserNo;
	}
	public BigInteger getIntCashNo() {
		return intCashNo;
	}
	public void setIntCashNo(BigInteger intCashNo) {
		this.intCashNo = intCashNo;
	}
	public int getIntItemNo() {
		return intItemNo;
	}
	public void setIntItemNo(int intItemNo) {
		this.intItemNo = intItemNo;
	}
	public int getIntRemainCash() {
		return intRemainCash;
	}
	public void setIntRemainCash(int intRemainCash) {
		this.intRemainCash = intRemainCash;
	}
	public BigInteger getIntPurchaseNo() {
		return intPurchaseNo;
	}
	public void setIntPurchaseNo(BigInteger intPurchaseNo) {
		this.intPurchaseNo = intPurchaseNo;
	}
	
	
}
