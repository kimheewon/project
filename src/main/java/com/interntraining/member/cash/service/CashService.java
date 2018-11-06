package com.interntraining.member.cash.service;

import com.interntraining.member.cash.domain.PGInfo;

public interface CashService {

	public PGInfo purchase(PGInfo sendObject);

	//결재번호
	public int selectOrderNo();

}
