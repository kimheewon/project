package com.interntraining.member.cash.service;


import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
import com.interntraining.member.cash.domain.PaginationCash;
import com.interntraining.member.cash.domain.PgRequest;
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
	
	@Value("${url}")
	String url;
	
	@Resource(name = "cashDAO")
	private CashDAO cashDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;

	//pg 결제 요청
	@Override
	public PGInfo purchase(PGInfo sendObject){
		

		int orderNo = cashDAO.selectRequestOrderNo() +1 ;	//order번호 가져오기
		
		String strNo = Integer.toString(orderNo);
		RestTemplate restTemplate = new RestTemplate();
	//	String url = "https://testpgapi.payletter.com/v1.0/payments/request";
		sendObject.setIntorderNo(orderNo);
		//PGInfo sendObject = new PGInfo();
		//sendObject.setPgcode("creditcard");
		//sendObject.setUser_id("test_user_id");	//사용자 id
		//sendObject.setUser_name("테스터"); 		////사용자 이름
		sendObject.setService_name(service_name);
		sendObject.setClient_id(client_id);
		sendObject.setOrder_no(strNo);	//주문번호
		//sendObject.setAmount(1000);
		sendObject.setProduct_name(product_name);
		sendObject.setEmail_flag(email_flag);
		sendObject.setEmail_addr(email_addr);
		sendObject.setAutopay_flag(autopay_flag);
		sendObject.setReceipt_flag(receipt_flag);
		sendObject.setCustom_parameter(custom_parameter);
		sendObject.setReturn_url(return_url);
		sendObject.setCallback_url(callback_url);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Host", "testpgapi.payletter.com");
		headers.add("Authorization", "PLKEY NUQyQ0RGNTBEODQ5NTg4OTc1MEQyNTdCRjY5NTRFNjg=");
		headers.add("Content-Type", "application/json");
		
		HttpEntity<PGInfo> objPGInfo = new HttpEntity<PGInfo>(sendObject, headers);

		PGInfo result = restTemplate.postForObject(url, objPGInfo, PGInfo.class);
		
		cashDAO.insertCashRequest(sendObject);	//결제 요청 저장
		
		//System.out.println(result);	
		//System.out.println(result.getOnline_url());
		//System.out.println(result.getMobile_url());
		return result;
	}

	//결재번호
	@Override
	public BigInteger selectOrderNo() {
		
		BigInteger lastOrderNo = cashDAO.selectOrderNo();	//마지막 번호
		String lastDate = String.valueOf(lastOrderNo).substring(0,8);	//년월일
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMdd", Locale.KOREA );
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format (currentTime);	//오늘일
		
		BigInteger intOrderNo;
		//String orderNo;
		if(mTime.equals(lastDate)) {	//마지막번호 == 오늘(최초 등록)
			
			intOrderNo = lastOrderNo.add(BigInteger.valueOf(1));	//1더하기
			//orderNo = String.valueOf(intOrderNo);	
			cashDAO.insertOrderNo(intOrderNo);//pk 저장
		}
		else {	//마지막번호 != 오늘
			String lastNum = mTime + "00001";
			intOrderNo = new BigInteger(lastNum);
			//orderNo = String.valueOf(intOrderNo);
			cashDAO.insertOrderNo(intOrderNo);//pk 저장
		}
		
		return intOrderNo;
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
	public int selectUserNo(String id) {		
		return cashDAO.selectUserNo(id);
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

	//캐시 내역 가져오기
	@Override
	public List<PGInfo> selectCashList(int userNo) {
		List<PGInfo> cash= cashDAO.selectCashList(userNo);
		/*for(int i=0; i<cash.size(); i++) {
			String kind = cash.get(i).getPgcode();
			if(kind.equals("mobile")) {
				cash.get(i).setStrPurchasekind("휴대폰");
			}
			else if(kind.equals("creditcard")){
				cash.get(i).setStrPurchasekind("신용카드");
			}
		}*/
		return cash;
	}

	//캐시 내역 페이징처리
	@Override
	public List<PGInfo> selectCashPaging(PaginationCash pagination) {
		List<PGInfo> cash= cashDAO.selectCashPaging(pagination);
		for(int i=0; i<cash.size(); i++) {
			String kind = cash.get(i).getPgcode();
			if(kind == null) {
				cash.get(i).setStrPurchasekind("");
			}
			else{
				if(kind.equals("mobile")) {
					cash.get(i).setStrPurchasekind("휴대폰");
				}
				else if(kind.equals("creditcard")){
					cash.get(i).setStrPurchasekind("신용카드");
				}				
			}
		}
		return cash;
	}



	//요청값과 결과값 비교
	@Override
	public int checkResult(PGInfo pgInfo) {
		
		int resultCheck = 5; //실패
		String order = pgInfo.getOrder_no();	
		int orderNo = Integer.parseInt(order);	//orderNo
		
		String id = pgInfo.getUser_id();
		int userNo = cashDAO.selectUserNo(id);	//회원 번호 찾기
		
		PgRequest requestInfo = new PgRequest();
		
		requestInfo = cashDAO.selectRequestInfo(orderNo);		//DB에서 정보 가져오기
		
		int requestOrderNo= requestInfo.getIntOrderNo();//값 비교
		int requestUserNo = requestInfo.getUser_no();
		String requestUserId= requestInfo.getUser_id();
		int requestPayAmt= requestInfo.getAmount();
		String requestPgCode = requestInfo.getPgcode();
		
		if(requestOrderNo == orderNo) {
			resultCheck = 4;
		}
		if(requestUserNo == userNo) {
			resultCheck = 3;
		}
		if(requestUserId.equals(pgInfo.getUser_id())) {
			resultCheck = 2;
		}
		if(requestPayAmt == pgInfo.getAmount()) {
			resultCheck = 1;
		}
		if(requestPgCode.equals(pgInfo.getPgcode())) {
			resultCheck = 0;
		}
		
		
		return resultCheck;
	}

	//상태 update
	@Override
	public void updateState(int orderNo) {
		cashDAO.updateState(orderNo);
	}


}
