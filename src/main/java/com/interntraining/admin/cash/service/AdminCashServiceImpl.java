package com.interntraining.admin.cash.service;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.interntraining.admin.cash.domain.CashInfo;
import com.interntraining.admin.cash.domain.CashMemoInfo;
import com.interntraining.admin.cash.domain.PgCancelInfo;
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
			String AdminId = adminCashDAO.selectAdminId(cash.get(i).getIntAdminNo());	//관리자 아이디
			cash.get(i).setStrAdminId(AdminId);
			if(kind == null) {
				cash.get(i).setStrPurchasekind("");
				cash.get(i).setAmount(0);
			}
			else {
				if(kind.equals("mobile")) {
					cash.get(i).setStrPurchasekind("휴대폰");
					cash.get(i).setStrReason("0");
				}
				else if(kind.equals("creditcard")){
					cash.get(i).setStrPurchasekind("신용카드");
					cash.get(i).setStrReason("0");
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
			memo.setStrState("관리자 지급");
		}
		else {
			memo.setStrState("관리자 회수");
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
		memo.setStrState("관리자 지급");
			
		adminCashDAO.insertCashMstPayment(memo);	//캐시 정보 테이블에 입력
		
	}

	//cash 충전(회원번호, 충전액)
	@Override
	public void updateUserCashMst(CashMemoInfo memo) {
		User user = new User();
		user = adminCashDAO.selectUserCashInfo(memo.getIntUserNo());	//유저의 기존 보유 캐시 정보 가져오기
		
		int cash = memo.getIntAmount();	//충전금액
		int totalInCash = user.getIntTotalInCashAmt() + cash;
		int totalCash = user.getIntTotalCashAmt() + cash;
		
		User userNew = new User();
		userNew.setIntUserNo(memo.getIntUserNo());//no
		userNew.setIntTotalInCashAmt(totalInCash);//in
		userNew.setIntTotalCashAmt(totalCash);//total
				
		adminCashDAO.updateUserCashMst(userNew);	//cash 충전(회원번호, 충전액)
		
	}

	//전체 결제 내역 가져오기
	@Override
	public List<PGInfo> selectAllCashList() {
		List<PGInfo> cash= adminCashDAO.selectAllCashList();

		for(int i=0; i<cash.size(); i++) {
			String AdminId = adminCashDAO.selectAdminId(cash.get(i).getIntAdminNo());	//관리자 아이디
			cash.get(i).setStrAdminId(AdminId);
			String kind = cash.get(i).getPgcode();
			if(kind == null) {
				cash.get(i).setStrPurchasekind("");
				cash.get(i).setAmount(0);
			}
			else {
				if(kind.equals("mobile")) {
					cash.get(i).setStrPurchasekind("휴대폰");
					cash.get(i).setStrReason("0");
				}
				else if(kind.equals("creditcard")){
					cash.get(i).setStrPurchasekind("신용카드");
					cash.get(i).setStrReason("0");
				}
			}
		}
		return cash;
	}

	//회원 목록 가져오기
	@Override
	public List<User> selectCashMember() {		
		return adminCashDAO.selectCashMember();
	}

	//현재 보유 캐시 정보 가져오기
	@Override
	public int selectTotalCash(int intUserNo) {
		return adminCashDAO.selectUserCashAmt(intUserNo);
	}

	//캐시 회수
	@Override
	public void cashRecall(CashMemoInfo memo) {
		String RecallItemName = "캐시 회수";
		int recallItemNo = adminCashDAO.selectRecallItemNo(RecallItemName);	//캐시 회수 번호 가져오기(0)
		memo.setIntItemNo(recallItemNo);		
		
		String inputCash = memo.getStrCash();
		String cash = inputCash.replaceAll(",", "");		
		memo.setIntAmount(Integer.parseInt(cash));	//회수 금액
		
		memo.setIntItemCount(1);
		memo.setIntTotalPrice(Integer.parseInt(cash));
		
		adminCashDAO.insertItemPurchaseRecall(memo);	//아이템 구매 테이블 insert
		
		memo.setIntType(2);	//회수
		adminCashDAO.insertMemo(memo); 		//회수,지급 테이블에 insert
	}

	//구매 매핑테이블에 insert
	@Override
	public void insertRecallMapping(CashMemoInfo memo) {
		List<CashInfo> list = adminCashDAO.selectCashAllList(memo.getIntUserNo());	//remaincash가 있는 리스트 가져오기
		List<CashInfo> mapping = new ArrayList<CashInfo>();
		CashInfo info = new CashInfo();
		int cash = memo.getIntAmount();	//차감할 캐시
		int sum = 0;
		int remain = 0;

		
		for(int i=0; i<list.size(); i++) {
			sum = + list.get(i).getIntRemainCash();	
			info.setIntUserNo(memo.getIntUserNo());
			info.setIntPurchaseNo(memo.getIntNumber());			
			if(sum < cash) {
				BigInteger cashNo = list.get(i).getIntCashNo();
				info.setIntCashNo(cashNo);				
				remain=0;
				info.setIntRemainCash(remain);
				mapping.add(info);
			}
			else if(sum == cash){
				BigInteger cashNo = list.get(i).getIntCashNo();
				info.setIntCashNo(cashNo);	
				remain=0;
				info.setIntRemainCash(remain);
				mapping.add(info);
				break;
			}else {
				BigInteger cashNo = list.get(i).getIntCashNo();
				info.setIntCashNo(cashNo);	
				remain = sum - cash;
				info.setIntRemainCash(remain);
				mapping.add(info);
				break;
			}
		}
		
		adminCashDAO.insertRecallMapping(mapping);
		
	}
	
	
}
