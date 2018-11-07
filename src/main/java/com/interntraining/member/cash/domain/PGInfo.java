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
	
	private String code;
	private String message;
	private String tid;
	private String cid;
	private String pay_info;
	private String billkey;
	private String domestic_flag;
	private String transaction_date;
	private int install_month;
	private String card_info;
	private String payhash;
	
	private BigInteger intCashNo;
	private int intUserNo;
	private int intCashAmt;	//현재 변환된 캐시
	private int intRemainCashAmt;	//남은캐시
	private String strPurchaseState;	//상태
	
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
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
	public String getPay_info() {
		return pay_info;
	}
	public void setPay_info(String pay_info) {
		this.pay_info = pay_info;
	}
	public String getBillkey() {
		return billkey;
	}
	public void setBillkey(String billkey) {
		this.billkey = billkey;
	}
	public String getDomestic_flag() {
		return domestic_flag;
	}
	public void setDomestic_flag(String domestic_flag) {
		this.domestic_flag = domestic_flag;
	}
	public String getTransaction_date() {
		return transaction_date;
	}
	public void setTransaction_date(String transaction_date) {
		this.transaction_date = transaction_date;
	}
	public int getInstall_month() {
		return install_month;
	}
	public void setInstall_month(int install_month) {
		this.install_month = install_month;
	}
	public String getCard_info() {
		return card_info;
	}
	public void setCard_info(String card_info) {
		this.card_info = card_info;
	}
	public String getPayhash() {
		return payhash;
	}
	public void setPayhash(String payhash) {
		this.payhash = payhash;
	}
	public int getIntUserNo() {
		return intUserNo;
	}
	public void setIntUserNo(int intUserNo) {
		this.intUserNo = intUserNo;
	}
	public int getIntCashAmt() {
		return intCashAmt;
	}
	public void setIntCashAmt(int intCashAmt) {
		this.intCashAmt = intCashAmt;
	}
	public int getIntRemainCashAmt() {
		return intRemainCashAmt;
	}
	public void setIntRemainCashAmt(int intRemainCashAmt) {
		this.intRemainCashAmt = intRemainCashAmt;
	}
	public String getStrPurchaseState() {
		return strPurchaseState;
	}
	public void setStrPurchaseState(String strPurchaseState) {
		this.strPurchaseState = strPurchaseState;
	}
	public BigInteger getIntCashNo() {
		return intCashNo;
	}
	public void setIntCashNo(BigInteger intCashNo) {
		this.intCashNo = intCashNo;
	}

	
	
	
}
