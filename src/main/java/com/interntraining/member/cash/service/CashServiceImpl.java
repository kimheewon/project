package com.interntraining.member.cash.service;


import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import org.springframework.web.client.RestTemplate;


import com.interntraining.member.cash.dao.CashDAO;
import com.interntraining.member.cash.domain.PGInfo;


@Service()
public class CashServiceImpl implements CashService{

	@Value("${service_name}")
	String service_name;
	
	@Value("${client_id}")
	String client_id;
	
	@Value("${product_name}")
	String product_name;
	
	@Value("${email_flag}")
	String email_flag;
	
	@Value("${email_addr}")
	String email_addr;
	
	@Value("${autopay_flag}")
	String autopay_flag;
	
	@Value("${receipt_flag}")
	String receipt_flag;
	
	@Value("${custom_parameter}")
	String custom_parameter;
	
	@Value("${return_url}")
	String return_url;
	
	@Value("${callback_url}")
	String callback_url;
	
	@Value("${cancel_url}")
	String cancel_url;
	
	@Resource(name = "cashDAO")
	private CashDAO cashDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;

	//pg 결제 요청
	@Override
	public PGInfo purchase(PGInfo sendObject){
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "https://testpgapi.payletter.com/v1.0/payments/request";
		
		//PGInfo sendObject = new PGInfo();
		//sendObject.setPgcode("creditcard");
		//sendObject.setUser_id("test_user_id");	//사용자 id
		//sendObject.setUser_name("테스터"); 		////사용자 이름
		sendObject.setService_name(service_name);
		sendObject.setClient_id(client_id);
		sendObject.setOrder_no("1234567890");
		//sendObject.setAmount(1000);
		sendObject.setProduct_name(product_name);
		sendObject.setEmail_flag(email_flag);
		sendObject.setEmail_addr(email_addr);
		sendObject.setAutopay_flag(autopay_flag);
		sendObject.setReceipt_flag(receipt_flag);
		sendObject.setCustom_parameter(custom_parameter);
		sendObject.setReturn_url(return_url);
		sendObject.setCallback_url(callback_url);
		sendObject.setCancel_url(cancel_url);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Host", "testpgapi.payletter.com");
		headers.add("Authorization", "PLKEY NUQyQ0RGNTBEODQ5NTg4OTc1MEQyNTdCRjY5NTRFNjg=");
		headers.add("Content-Type", "application/json");
		
		HttpEntity<PGInfo> objPGInfo = new HttpEntity<PGInfo>(sendObject, headers);

		PGInfo result = restTemplate.postForObject(url, objPGInfo, PGInfo.class);
		System.out.println(result);
	
		System.out.println(result.getOnline_url());
		System.out.println(result.getMobile_url());
		return result;
	}

	//결재번호
	@Override
	public int selectOrderNo() {
		return cashDAO.selectOrderNo();
	}
}
