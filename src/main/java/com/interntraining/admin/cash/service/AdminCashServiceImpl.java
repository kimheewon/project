package com.interntraining.admin.cash.service;

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

import com.interntraining.admin.cash.dao.AdminCashDAO;
import com.interntraining.admin.cash.domain.CashMemoInfo;
import com.interntraining.admin.cash.domain.PgCancelInfo;
import com.interntraining.member.cash.dao.CashDAO;
import com.interntraining.member.cash.domain.PGInfo;
import com.interntraining.member.login.domain.User;

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
			if(kind == null) {
				cash.get(i).setStrPurchasekind("");
				cash.get(i).setAmount(0);
			}
			else {
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

	//유저 아이디 찾기
	@Override
	public String selectUserId(int userNo) {
		return adminCashDAO.selectUserId(userNo);
	}

	//결제 취소
	@Override
	public PgCancelInfo cashCancel(BigInteger cashNo) {
		
		int check=2;
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
		
		//값비교
		if(cancelInfo.getTid().equals(result.getTid())) {
			check = 1;
		}
		if(cancelInfo.getAmount() == result.getAmount()) {
			check = 0;
		}
		
		if(check == 0){
			return result;
		}
		else {
			PgCancelInfo fail = new PgCancelInfo();
			
			fail.setCode(result.getCode());
			fail.setMessage(result.getMessage());
			return fail; 			
		}
	}

	//DB에 결제 취소 내역 update
	@Override
	public void updateCancel(PgCancelInfo cancel) {
		cancel.setStrPurchaseStae("결제 취소");		
		adminCashDAO.updateCancel(cancel);
		
	}

	//사용자 번호 가져오기
	@Override
	public int selectCancelUserNo(BigInteger cashNo) {
		return adminCashDAO.selectCancelUserNo(cashNo);
	}

	
	//사용자 캐시AMT update(결제 취소)
	@Override
	public void updateUserCashMst(PgCancelInfo cancel) {
		User user = new User();
		user = adminCashDAO.selectUserCashInfo(cancel.getIntUserNo());	//유저의 기존 보유 캐시 정보 가져오기
		
		int totalOutCash = user.getIntTotalOutCashAmt() + cancel.getAmount();
		int totalCash = user.getIntTotalCashAmt() - cancel.getAmount();
		
		User userNew = new User();
		userNew.setIntUserNo(cancel.getIntUserNo());//no
		userNew.setIntTotalOutCashAmt(totalOutCash);//in
		userNew.setIntTotalCashAmt(totalCash);//total
		
		adminCashDAO.updateCancelUserCashMst(userNew);	//사용자 캐시AMT update(결제 취소)
	}

	//캐시 내역 가져오기
	@Override
	public int selectUserCashAmt(int userNo) {
		return adminCashDAO.selectUserCashAmt(userNo);
	}

	//캐시 지급
	@Override
	public void cashPayment(CashMemoInfo memo) {
		
		if(memo.getIntType() == 1){	//지급인지 회수인지 결정
			memo.setStrState("지급");
		}
		else {
			memo.setStrState("회수");
		}
		
		adminCashDAO.insertMemo(memo);	//사유 테이블에 입력
		
	
	}

	//번호 생성
	@Override
	public BigInteger selectOrderNo() {
		BigInteger lastOrderNo = adminCashDAO.selectOrderNo();	//마지막 번호
		String lastDate = String.valueOf(lastOrderNo).substring(0,8);	//년월일
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyyMMdd", Locale.KOREA);
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format (currentTime);	//오늘일
		
		BigInteger intOrderNo;
		//String orderNo;
		if(mTime.equals(lastDate)) {	//마지막번호 == 오늘(최초 등록)
			
			intOrderNo = lastOrderNo.add(BigInteger.valueOf(1));	//1더하기
			adminCashDAO.insertOrderNo(intOrderNo);	//pk 저장
		}
		else {	//마지막번호 != 오늘
			String lastNum = mTime + "00001";
			intOrderNo = new BigInteger(lastNum);
			adminCashDAO.insertOrderNo(intOrderNo);	//pk 저장
		}
		
		return intOrderNo;
	}

	//캐시 정보 테이블에 입력
	@Override
	public void insertCashMstPayment(CashMemoInfo memo) {
		//캐시 내역 테이블에 입력
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss", Locale.KOREA );
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format (currentTime);	//오늘일
		memo.setIntType(1);		
		memo.setStrDate(mTime);
		memo.setStrState("지급");
		
		adminCashDAO.insertCashMstPayment(memo);	//캐시 정보 테이블에 입력
		
	}
	
	
}
