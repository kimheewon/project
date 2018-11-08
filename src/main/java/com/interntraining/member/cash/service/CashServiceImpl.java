package com.interntraining.member.cash.service;


import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

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
import com.interntraining.member.login.domain.User;


@Service()
public class CashServiceImpl implements CashService{

	@Value("${service.name}")
	String service_name;
	
	@Value("${client.id}")
	String client_id;
	
	@Value("${product.name}")
	String product_name;
	
	@Value("${email.flag}")
	String email_flag;
	
	@Value("${email.addr}")
	String email_addr;
	
	@Value("${autopay.flag}")
	String autopay_flag;
	
	@Value("${receipt.flag}")
	String receipt_flag;
	
	@Value("${custom.parameter}")
	String custom_parameter;
	
	@Value("${return.url}")
	String return_url;
	
	@Value("${callback.url}")
	String callback_url;
	
	@Value("${cancel.url}")
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
		//sendObject.setOrder_no("1234567890");
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
		//System.out.println(result);	
		//System.out.println(result.getOnline_url());
		//System.out.println(result.getMobile_url());
		return result;
	}

	//결재번호
	@Override
	public String selectOrderNo() {
		
		BigInteger lastOrderNo = cashDAO.selectOrderNo();	//마지막 번호
		String lastDate = String.valueOf(lastOrderNo).substring(0,8);	//년월일
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMdd", Locale.KOREA );
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format (currentTime);	//오늘일
		
		BigInteger intOrderNo;
		String orderNo;
		if(mTime.equals(lastDate)) {	//마지막번호 == 오늘(최초 등록)
			
			intOrderNo = lastOrderNo.add(BigInteger.valueOf(1));	//1더하기
			orderNo = String.valueOf(intOrderNo);	
			cashDAO.insertOrderNo(intOrderNo);//pk 저장
		}
		else {	//마지막번호 != 오늘
			String lastNum = mTime + "00001";
			intOrderNo = new BigInteger(lastNum);
			orderNo = String.valueOf(intOrderNo);
			cashDAO.insertOrderNo(intOrderNo);//pk 저장
		}
		
		return orderNo;
	}

	//DB에  결제 결과값 저장
	@Override
	public void insertPgResult(PGInfo pgInfo) {
		cashDAO.insertPgResult(pgInfo);
/*		
		//결과값 전송
		PGInfo msg = new PGInfo();
		
		//String code = pgInfo.getCode();
		String message = pgInfo.getMessage();
		msg.setCode("0");
		msg.setMessage(message);
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "https://testpgapi.payletter.com/v1.0/payments/request";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Host", "testpgapi.payletter.com");
		headers.add("Authorization", "PLKEY NUQyQ0RGNTBEODQ5NTg4OTc1MEQyNTdCRjY5NTRFNjg=");
		headers.add("Content-Type", "application/json");
		
		HttpEntity<PGInfo> objPGInfo = new HttpEntity<PGInfo>(msg, headers);

		restTemplate.postForObject(url, objPGInfo, PGInfo.class);*/
	}

	//Cash 충전
	@Override
	public void updateUserCashMst(PGInfo pgInfo) {
		User user = new User();
		user = cashDAO.selectUserCashInfo(pgInfo.getIntUserNo());	//유저의 기존 보유 캐시 정보 가져오기
		
		int cash = pgInfo.getIntCashAmt();
		int totalInCash = user.getIntTotalInCashAmt() + cash;
		int totalCash = user.getIntTotalCashAmt() + cash;
		
		User userNew = new User();
		userNew.setIntUserNo(pgInfo.getIntUserNo());//no
		userNew.setIntTotalInCashAmt(totalInCash);//in
		userNew.setIntTotalCashAmt(totalCash);//total
				
		cashDAO.updateUserCashMst(userNew);		
	}

	//회원 번호 찾기
	@Override
	public int selectUserId(String id) {		
		return cashDAO.selectUserId(id);
	}

	//회원의 현재 보유 캐시정보
	@Override
	public User selectUserCashInfo(int userNo, String orderNo) {
		User user = new User();
		user = cashDAO.selectUserCashInfo(userNo);	//totalAmt
		int amount = cashDAO.selectPgCashAmount(orderNo);	//충전한 캐시정보 가져오기
		user.setIntAmount(amount);
		return user;
	}
}
