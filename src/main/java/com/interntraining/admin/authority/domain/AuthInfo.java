package com.interntraining.admin.authority.domain;

public class AuthInfo {
	
	
	private int intAuthNo;		//권한명 번호
	private String strAuthName;	//권한명
	private String strAuthNameUpdate;	//입력한 권한명
	
	
	
	public int getIntAuthNo() {
		return intAuthNo;
	}
	public void setIntAuthNo(int intAuthNo) {
		this.intAuthNo = intAuthNo;
	}
	public String getStrAuthName() {
		return strAuthName;
	}
	public void setStrAuthName(String strAuthName) {
		this.strAuthName = strAuthName;
	}
	public String getStrAuthNameUpdate() {
		return strAuthNameUpdate;
	}
	public void setStrAuthNameUpdate(String strAuthNameUpdate) {
		this.strAuthNameUpdate = strAuthNameUpdate;
	}
	

}
