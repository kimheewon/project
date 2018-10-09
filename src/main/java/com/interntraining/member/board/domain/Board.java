package com.interntraining.member.board.domain;


import java.util.Date;

public class Board {
	private int intBoardNo;
	private String strUserId;
	private String strBoardTitle;
	private String strBoardContent;
	private Date dateBoardDate;
	private int intHit;
	private int rownumber;
	
	
	public int getIntBoardNo() {
		return intBoardNo;
	}
	public void setIntBoardNo(int intBoardNo) {
		this.intBoardNo = intBoardNo;
	}
	public String getStrUserId() {
		return strUserId;
	}
	public void setStrUserId(String strUserId) {
		this.strUserId = strUserId;
	}
	public String getStrBoardTitle() {
		return strBoardTitle;
	}
	public void setStrBoardTitle(String strBoardTitle) {
		this.strBoardTitle = strBoardTitle;
	}
	public String getStrBoardContent() {
		return strBoardContent;
	}
	public void setStrBoardContent(String strBoardContent) {
		this.strBoardContent = strBoardContent;
	}
	public Date getDateBoardDate() {
		return dateBoardDate;
	}
	public void setDateBoardDate(Date dateBoardDate) {
		this.dateBoardDate = dateBoardDate;
	}
	public int getIntHit() {
		return intHit;
	}
	public void setIntHit(int intHit) {
		this.intHit = intHit;
	}

	public int getRownumber() {
		return rownumber;
	}
	public void setRownumber(int rownumber) {
		this.rownumber = rownumber;
	}
	
	
}
