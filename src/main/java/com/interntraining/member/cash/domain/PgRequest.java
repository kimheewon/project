package com.interntraining.member.cash.domain;

import java.math.BigInteger;

public class PgRequest {
	private String pgcode;
	private String user_id;
	private int user_no;	
	private int	   amount;
	private int intOrderNo;	//order
	public String getPgcode() {
		return pgcode;
	}
	public void setPgcode(String pgcode) {
		this.pgcode = pgcode;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getIntOrderNo() {
		return intOrderNo;
	}
	public void setIntOrderNo(int intOrderNo) {
		this.intOrderNo = intOrderNo;
	}
	
	
}
