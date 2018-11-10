package com.interntraining.admin.cash.service;

import java.math.BigInteger;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import org.springframework.web.client.RestTemplate;

import com.interntraining.admin.cash.dao.AdminCashDAO;
import com.interntraining.admin.cash.domain.PgCancelInfo;
import com.interntraining.member.cash.domain.PGInfo;

@Service()
public class AdminCashServiceImpl implements AdminCashService {

	@Value("${client.id}")
	String client_id;
	
	@Value("${ip.addr}")
	String ip_addr;
	
	@Value("${cashCancel.url}")
	String url;
	
	@Resource(name = "adminCashDAO")
	private AdminCashDAO adminCashDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;

	//캐시 내역 가져오기
	@Override
	public List<PGInfo> selectCashList(int userNo) {
		List<PGInfo> cash= adminCashDAO.selectCashList(userNo);

		for(int i=0; i<cash.size(); i++) {
			String kind = cash.get(i).getPgcode();
			if(kind.equals("mobile")) {
				cash.get(i).setStrPurchasekind("휴대폰");
			}
			else if(kind.equals("creditcard")){
				cash.get(i).setStrPurchasekind("신용카드");
			}
		}
		return cash;
	}

	//유저 아이디 찾기
	@Override
	public String selectUserId(int userNo) {
		return adminCashDAO.selectUserId(userNo);
	}

	//결제 취소
	@Override
	public void cashCancel(BigInteger cashNo) {
		
		RestTemplate restTemplate = new RestTemplate();
		
		PgCancelInfo cancelInfo = adminCashDAO.cashCancel(cashNo);	//보낼 취소 정보 가져오기
		cancelInfo.setClient_id(client_id);
		cancelInfo.setIp_addr(ip_addr);
		
		//cancelInfo.setPgcode("creditcard");
		//cancelInfo.setUser_id("lion1234");	//사용자 id
		//cancelInfo.setTid("ttestintern-201811107195589");
		//cancelInfo.setAmount(1000);
		HttpHeaders headers = new HttpHeaders();
		headers.add("Host", "testpgapi.payletter.com");
		headers.add("Authorization", "PLKEY NUQyQ0RGNTBEODQ5NTg4OTc1MEQyNTdCRjY5NTRFNjg=");
		headers.add("Content-Type", "application/json");
		
		HttpEntity<PgCancelInfo> objPGInfo = new HttpEntity<PgCancelInfo>(cancelInfo, headers);

		PgCancelInfo result = restTemplate.postForObject(url, objPGInfo, PgCancelInfo.class);
		
		
	}
	
	
}
