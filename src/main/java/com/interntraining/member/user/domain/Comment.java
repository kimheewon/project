package com.interntraining.member.user.domain;

import java.util.Date;

public class Comment {
	private int intCmmtNo;		//댓글번호
	private int intBoardNo;		//게시글번호
	private String strUserId;		//아이디
	private String strCmmtComment;	//댓글
	private Date dateCmmtDate;		//작성일
	
	public int getIntCmmtNo() {
		return intCmmtNo;
	}
	public void setIntCmmtNo(int intCmmtNo) {
		this.intCmmtNo = intCmmtNo;
	}
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
	public String getStrCmmtComment() {
		return strCmmtComment;
	}
	public void setStrCmmtComment(String strCmmtComment) {
		this.strCmmtComment = strCmmtComment;
	}
	public Date getDateCmmtDate() {
		return dateCmmtDate;
	}
	public void setDateCmmtDate(Date dateCmmtDate) {
		this.dateCmmtDate = dateCmmtDate;
	}
	
	

}
