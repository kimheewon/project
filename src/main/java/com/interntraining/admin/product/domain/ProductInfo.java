package com.interntraining.admin.product.domain;

import java.util.Date;

public class ProductInfo {
	
	private int 	intItemNo;			//상품번호
	private String 	strItemName;		//아이템명
	private String 	intItemPrice;		//가격
	private Date	dateItemDate;		//날짜
	private int 	intAdminNo;			//관리자번호
	private String 	strAdminName;		//관리자 이름
	private int		intUpdateAdminNo;	//최근 수정한 관리자번호
	private String 	strUpdateAdminName;	//최근 수정한 관리자이름
	private String 	strfileName;     		//저장할 파일
    private String 	strfileOriName;  		//실제 파일
    private String 	strfileUrl;			//파일위치


	
	public int getIntItemNo() {
		return intItemNo;
	}
	public void setIntItemNo(int intItemNo) {
		this.intItemNo = intItemNo;
	}
	public String getStrItemName() {
		return strItemName;
	}
	public void setStrItemName(String strItemName) {
		this.strItemName = strItemName;
	}
	public String getIntItemPrice() {
		return intItemPrice;
	}
	public void setIntItemPrice(String intItemPrice) {
		this.intItemPrice = intItemPrice;
	}	
	public Date getDateItemDate() {
		return dateItemDate;
	}
	public void setDateItemDate(Date dateItemDate) {
		this.dateItemDate = dateItemDate;
	}
	public int getIntAdminNo() {
		return intAdminNo;
	}
	public void setIntAdminNo(int intAdminNo) {
		this.intAdminNo = intAdminNo;
	}
	public int getIntUpdateAdminNo() {
		return intUpdateAdminNo;
	}
	public void setIntUpdateAdminNo(int intUpdateAdminNo) {
		this.intUpdateAdminNo = intUpdateAdminNo;
	}
	public String getStrfileName() {
		return strfileName;
	}
	public void setStrfileName(String strfileName) {
		this.strfileName = strfileName;
	}
	public String getStrfileOriName() {
		return strfileOriName;
	}
	public void setStrfileOriName(String strfileOriName) {
		this.strfileOriName = strfileOriName;
	}
	public String getStrfileUrl() {
		return strfileUrl;
	}
	public void setStrfileUrl(String strfileUrl) {
		this.strfileUrl = strfileUrl;
	}
	public String getStrAdminName() {
		return strAdminName;
	}
	public void setStrAdminName(String strAdminName) {
		this.strAdminName = strAdminName;
	}
	public String getStrUpdateAdminName() {
		return strUpdateAdminName;
	}
	public void setStrUpdateAdminName(String strUpdateAdminName) {
		this.strUpdateAdminName = strUpdateAdminName;
	}
	
	
}