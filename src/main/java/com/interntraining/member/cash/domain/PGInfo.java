package com.interntraining.member.cash.domain;

import java.math.BigInteger;

public class PGInfo {

	private String pgcode;
	private String user_id;
	private String user_name;    
	private String service_name;    
	private String client_id;
	private String order_no;
	private int	   amount;
	private String product_name;  
	private String email_flag;
	private String email_addr;
	private String autopay_flag;  
	private String receipt_flag;
	private String custom_parameter; 
	private String return_url;
	private String callback_url;
	private String cancel_url;
	private BigInteger token;
	private String online_url;
	private String mobile_url;
	
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
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getService_name() {
		return service_name;
	}
	public void setService_name(String service_name) {
		this.service_name = service_name;
	}
	public String getClient_id() {
		return client_id;
	}
	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}
	public String getOrder_no() {
		return order_no;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getEmail_flag() {
		return email_flag;
	}
	public void setEmail_flag(String email_flag) {
		this.email_flag = email_flag;
	}
	public String getEmail_addr() {
		return email_addr;
	}
	public void setEmail_addr(String email_addr) {
		this.email_addr = email_addr;
	}
	public String getAutopay_flag() {
		return autopay_flag;
	}
	public void setAutopay_flag(String autopay_flag) {
		this.autopay_flag = autopay_flag;
	}
	public String getReceipt_flag() {
		return receipt_flag;
	}
	public void setReceipt_flag(String receipt_flag) {
		this.receipt_flag = receipt_flag;
	}
	public String getCustom_parameter() {
		return custom_parameter;
	}
	public void setCustom_parameter(String custom_parameter) {
		this.custom_parameter = custom_parameter;
	}
	public String getReturn_url() {
		return return_url;
	}
	public void setReturn_url(String return_url) {
		this.return_url = return_url;
	}
	public String getCallback_url() {
		return callback_url;
	}
	public void setCallback_url(String callback_url) {
		this.callback_url = callback_url;
	}
	public String getCancel_url() {
		return cancel_url;
	}
	public void setCancel_url(String cancel_url) {
		this.cancel_url = cancel_url;
	}
	
	public BigInteger getToken() {
		return token;
	}
	public void setToken(BigInteger token) {
		this.token = token;
	}
	public String getOnline_url() {
		return online_url;
	}
	public void setOnline_url(String online_url) {
		this.online_url = online_url;
	}
	public String getMobile_url() {
		return mobile_url;
	}
	public void setMobile_url(String mobile_url) {
		this.mobile_url = mobile_url;
	}
	
	
}
