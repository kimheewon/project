package com.interntraining.member.itemShop.domain;

import java.math.BigInteger;

public class ItemShopInfo {

	private int 	intItemNo;			//상품번호
	private String 	strItemName;		//아이템명	
    private String 	strfileUrl;			//파일위치  
    private int 	intDeliveryPrice;	//배송료
    private int 	intItemPrice;		//상품가격
    
    private String	strName;
    private int		intUserNo;
    private String  strTel;
    private String 	strPostcode;
	private String 	strAddress;
	
	private String 	strAddress2;
	private String 	strDeliverMsg;
	private int 	itemNo;
	private int 	itemCount;
	private String 	deliveryPrice;
	
	private String 	itemPrice;
	private BigInteger intNumber;
	private int 	intItemTotalPrice;
	private int 	intMiddlePrice;
	
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
	public String getStrfileUrl() {
		return strfileUrl;
	}
	public void setStrfileUrl(String strfileUrl) {
		this.strfileUrl = strfileUrl;
	}
	public int getIntDeliveryPrice() {
		return intDeliveryPrice;
	}
	public void setIntDeliveryPrice(int intDeliveryPrice) {
		this.intDeliveryPrice = intDeliveryPrice;
	}
	public int getIntItemPrice() {
		return intItemPrice;
	}
	public void setIntItemPrice(int intItemPrice) {
		this.intItemPrice = intItemPrice;
	}
	public String getStrName() {
		return strName;
	}
	public void setStrName(String strName) {
		this.strName = strName;
	}
	public int getIntUserNo() {
		return intUserNo;
	}
	public void setIntUserNo(int intUserNo) {
		this.intUserNo = intUserNo;
	}
	public String getStrTel() {
		return strTel;
	}
	public void setStrTel(String strTel) {
		this.strTel = strTel;
	}
	
	public String getStrPostcode() {
		return strPostcode;
	}
	public void setStrPostcode(String strPostcode) {
		this.strPostcode = strPostcode;
	}
	public String getStrAddress() {
		return strAddress;
	}
	public void setStrAddress(String strAddress) {
		this.strAddress = strAddress;
	}
	public String getStrAddress2() {
		return strAddress2;
	}
	public void setStrAddress2(String strAddress2) {
		this.strAddress2 = strAddress2;
	}
	public String getStrDeliverMsg() {
		return strDeliverMsg;
	}
	public void setStrDeliverMsg(String strDeliverMsg) {
		this.strDeliverMsg = strDeliverMsg;
	}
	public int getItemNo() {
		return itemNo;
	}
	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}
	public int getItemCount() {
		return itemCount;
	}
	public void setItemCount(int itemCount) {
		this.itemCount = itemCount;
	}

	
	public int getIntMiddlePrice() {
		return intMiddlePrice;
	}
	public void setIntMiddlePrice(int intMiddlePrice) {
		this.intMiddlePrice = intMiddlePrice;
	}
	public String getDeliveryPrice() {
		return deliveryPrice;
	}
	public void setDeliveryPrice(String deliveryPrice) {
		this.deliveryPrice = deliveryPrice;
	}
	public String getItemPrice() {
		return itemPrice;
	}
	public void setItemPrice(String itemPrice) {
		this.itemPrice = itemPrice;
	}
	public BigInteger getIntNumber() {
		return intNumber;
	}
	public void setIntNumber(BigInteger intNumber) {
		this.intNumber = intNumber;
	}
	public int getIntItemTotalPrice() {
		return intItemTotalPrice;
	}
	public void setIntItemTotalPrice(int intItemTotalPrice) {
		this.intItemTotalPrice = intItemTotalPrice;
	}
    
    
}
