package com.interntraining.admin.product.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class ProductInfo {
	
	private int 	intItemNo;			//상품번호
	private String 	strItemName;		//아이템명
	private String 	strPrice;		//가격
	private Date	dateItemDate;		//날짜
	private Date	dateUpdateItemDate;		//날짜
	private int 	intAdminNo;			//관리자번호
	private String 	strAdminName;		//관리자 이름
	private String 	strfileName;     		//저장할 파일
    private String 	strfileOriName;  		//실제 파일
    private String 	strfileUrl;			//파일위치
    private String	keyField;
    private String 	keyWord;
    private int 	intDeliveryPrice;
    private int 	intItemPrice;
	private String 	strAdminId;
	private String 	strdate;
	
	
	public String getStrdate() {
		return strdate;
	}
	public void setStrdate(String strdate) {
		this.strdate = strdate;
	}
	private MultipartFile 	file;
	
	
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
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
		
	public String getStrPrice() {
		return strPrice;
	}
	public void setStrPrice(String strPrice) {
		this.strPrice = strPrice;
	}
	public int getIntItemPrice() {
		return intItemPrice;
	}
	public void setIntItemPrice(int intItemPrice) {
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
	public Date getDateUpdateItemDate() {
		return dateUpdateItemDate;
	}
	public void setDateUpdateItemDate(Date dateUpdateItemDate) {
		this.dateUpdateItemDate = dateUpdateItemDate;
	}
	public String getKeyField() {
		return keyField;
	}
	public void setKeyField(String keyField) {
		this.keyField = keyField;
	}
	public String getKeyWord() {
		return keyWord;
	}
	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}
	public int getIntDeliveryPrice() {
		return intDeliveryPrice;
	}
	public void setIntDeliveryPrice(int intDeliveryPrice) {
		this.intDeliveryPrice = intDeliveryPrice;
	}
	public String getStrAdminId() {
		return strAdminId;
	}
	public void setStrAdminId(String strAdminId) {
		this.strAdminId = strAdminId;
	}

	
	
}
