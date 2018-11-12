package com.interntraining.admin.cash.domain;

import java.math.BigInteger;

public class PgCancelInfo {
	
	private String pgcode;
	private String user_id;  
	private String client_id;
	private int	   amount;
	private String ip_addr;  	
	private String tid;
	private String cid;
	private String cancel_date;
	private int	code;
	private String message;
	private BigInteger intCashNo;
	private String strPurchaseStae;
	private int intUserNo;
	
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
	public String getClient_id() {
		return client_id;
	}
	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getIp_addr() {
		return ip_addr;
	}
	public void setIp_addr(String ip_addr) {
		this.ip_addr = ip_addr;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getCancel_date() {
		return cancel_date;
	}
	public void setCancel_date(String cancel_date) {
		this.cancel_date = cancel_date;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public BigInteger getIntCashNo() {
		return intCashNo;
	}
	public void setIntCashNo(BigInteger intCashNo) {
		this.intCashNo = intCashNo;
	}
	public String getStrPurchaseStae() {
		return strPurchaseStae;
	}
	public void setStrPurchaseStae(String strPurchaseStae) {
		this.strPurchaseStae = strPurchaseStae;
	}
	public int getIntUserNo() {
		return intUserNo;
	}
	public void setIntUserNo(int intUserNo) {
		this.intUserNo = intUserNo;
	}
		
}
