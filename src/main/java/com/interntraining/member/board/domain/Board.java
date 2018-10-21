package com.interntraining.member.board.domain;


import java.util.Date;

public class Board {
	private int intBoardNo;
	private String strUserId;
	private String strBoardTitle;
	private String strBoardContent;
	private Date dateBoardDate;
	private String strBoardDate;
	private int intNewCheck;
	private int intHit;
	private int rownumber;
	private int inttotalComment;
	private String strGrade;
	private int intNum;
	
	
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
	
	public String getStrBoardDate() {
		return strBoardDate;
	}
	public void setStrBoardDate(String strBoardDate) {
		this.strBoardDate = strBoardDate;
	}	
	public int getIntNewCheck() {
		return intNewCheck;
	}
	public void setIntNewCheck(int intNewCheck) {
		this.intNewCheck = intNewCheck;
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
	public int getInttotalComment() {
		return inttotalComment;
	}
	public void setInttotalComment(int inttotalComment) {
		this.inttotalComment = inttotalComment;
	}
	public String getStrGrade() {
		return strGrade;
	}
	public void setStrGrade(String strGrade) {
		this.strGrade = strGrade;
	}
	public int getIntNum() {
		return intNum;
	}
	public void setIntNum(int intNum) {
		this.intNum = intNum;
	}

	
}
