package com.interntraining.admin.cash.controller;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.cash.domain.CashMemoInfo;
import com.interntraining.admin.cash.domain.PgCancelInfo;
import com.interntraining.admin.cash.service.AdminCashService;
import com.interntraining.member.cash.domain.PGInfo;
import com.interntraining.member.login.domain.User;

@Controller
@RequestMapping(value= "/AdminCash")
public class AdminCashController {
	
	@Autowired
	private AdminCashService admincashService;
	
	//결제 내역 페이지로 이동
	@RequestMapping(value="/AdminCashList")
	public ModelAndView adminCashList(int userNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<PGInfo> cash = admincashService.selectCashList(userNo);	//캐시 내역 가져오기
		
		String id = admincashService.selectUserId(userNo);	//유저 아이디 찾기
		
		mav.addObject("cash", cash);
		mav.addObject("id",id);
		mav.addObject("userNo",userNo);
		mav.setViewName("/admin/membership/CashList");
		return mav;
	}
	

	//결제 취소
	@RequestMapping(value="/CashCancel",produces="application/json")
	public ModelAndView cashCancel(BigInteger cashNo) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		PgCancelInfo cancel = admincashService.cashCancel(cashNo);	//결제 취소
		
		cancel.setIntCashNo(cashNo);
		
		int userNo = admincashService.selectCancelUserNo(cashNo);		//사용자 번호 가져오기
		cancel.setIntUserNo(userNo);
		
		if(cancel.getTid()!= null) {	//결제 취소 성공
			admincashService.updateCancel(cancel);	//DB에 결제 취소 내역 update
			admincashService.updateUserCashMst(cancel);	//사용자 캐시AMT update
		}
		
		
		mav.addObject("userNo", userNo);
		mav.setViewName("redirect:/AdminCash/AdminCashList");
		return mav;
	}
	
	//캐시 지급 페이지로 이동
	@RequestMapping(value="AdminCashPaymentForm")
	public ModelAndView cashCancel(int userNo) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
	
		int cash = admincashService.selectUserCashAmt(userNo);		//캐시 내역 가져오기
		
		String id = admincashService.selectUserId(userNo);	//유저 아이디 찾기
		
		mav.addObject("cash", cash);
		mav.addObject("id",id);
		mav.addObject("userNo", userNo);
		mav.setViewName("/admin/membership/CashPayment");
		
		return mav;		
	}
	
	//캐시 지급
	@RequestMapping(value="/AdminCashPayment", method = RequestMethod.POST)
	public ModelAndView adminCashPayment(CashMemoInfo memo, HttpServletResponse response, HttpSession session){	
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());		
		
		int adminNo = (int) session.getAttribute("AdminNo");
		memo.setIntAdminNo(adminNo);
		
		String inputCash = memo.getStrCash();
		String cash = inputCash.replaceAll(",", "");		
		memo.setIntAmount(Integer.parseInt(cash));
		
		BigInteger number = admincashService.selectOrderNo();		//번호 생성
		memo.setIntNumber(number);
		
		admincashService.cashPayment(memo);		// 사유 테이블에 저장		
		admincashService.insertCashMstPayment(memo);	//캐시 정보 테이블에 입력		
		admincashService.updateUserCashMst(memo);	//cash 충전(회원번호, 충전액)
		
		int totalCash = admincashService.selectTotalCash(memo.getIntUserNo());	//현재 보유 캐시 정보 가져오기
		
		mav.addObject("id", memo.getStrUserId());
		mav.addObject("totalCash", totalCash);
		mav.addObject("memo", memo);
		mav.setViewName("admin/cash/CashSuccess");
		return mav;
	}
	
	//결제 내역 전체
	@RequestMapping(value="/AdminCashAllList")
	public ModelAndView adminCashAllList() {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<PGInfo> cash = admincashService.selectAllCashList();	//전체 결제 내역 가져오기
		
		
		mav.addObject("cash", cash);
		mav.setViewName("admin/cash/CashList");
		return mav;
	}
	
	//결제 취소
	@RequestMapping(value="/CashAllCancel",produces="application/json")
	public ModelAndView cashAllCancel(BigInteger cashNo) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
			
		PgCancelInfo cancel = admincashService.cashCancel(cashNo);	//결제 취소
			
		cancel.setIntCashNo(cashNo);
			
		int userNo = admincashService.selectCancelUserNo(cashNo);		//사용자 번호 가져오기
		cancel.setIntUserNo(userNo);
			
		if(cancel.getTid()!= null) {	//결제 취소 성공
			admincashService.updateCancel(cancel);	//DB에 결제 취소 내역 update
			admincashService.updateUserCashMst(cancel);	//사용자 캐시AMT update
		}		
			
		mav.addObject("userNo", userNo);
		mav.setViewName("redirect:/AdminCash/AdminAllCashList");
		return mav;
	}
	
	//지급/회수 회원 목록페이지
	@RequestMapping(value="AdminCashMember")
	public ModelAndView adminCashMember() {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<User> member = admincashService.selectCashMember();	//회원 캐시 목록 가져오기
		
		mav.addObject("member", member);
		mav.setViewName("/admin/cash/CashEarningRecall");
		return mav;
	}
	
	//회수 페이지로 이동
	@RequestMapping(value="AdminCashRecallForm")
	public ModelAndView adminCashRecallForm(int userNo) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		int cash = admincashService.selectUserCashAmt(userNo);		//캐시 내역 가져오기
		
		String id = admincashService.selectUserId(userNo);	//유저 아이디 찾기
		
		mav.addObject("cash", cash);
		mav.addObject("id",id);
		mav.addObject("userNo", userNo);
		mav.setViewName("admin/cash/CashRecall");
		
		return mav;
	}
	
	//캐시 회수
	@RequestMapping(value="AdminCashRecall", method = RequestMethod.POST)
	public ModelAndView adminCashRecall(CashMemoInfo memo, HttpServletResponse response, HttpSession session){	
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());		
		
		int adminNo = (int) session.getAttribute("AdminNo");
		memo.setIntAdminNo(adminNo);
		
		BigInteger number = admincashService.selectOrderNo();		//아이템 구매 번호 생성
		memo.setIntNumber(number);  //아이템 구매 번호
		
		admincashService.cashRecall(memo);	//캐시 회수(아이템 구매 테이블과 회수,지급 테이블에 insert)
		admincashService.insertRecallMapping(memo);	//구매 매핑테이블에 insert
		//회원 계좌 정보 update
		return mav;
	}
		
	
}
