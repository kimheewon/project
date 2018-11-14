package com.interntraining.member.itemShop.domain;

import java.util.Date;

public class ItemShopInfo {

	private int 	intItemNo;			//상품번호
	private String 	strItemName;		//아이템명	
    private String 	strfileUrl;			//파일위치  
    private int 	intDeliveryPrice;	//배송료
    private int 	intItemPrice;		//상품가격
    
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
    
    
}
