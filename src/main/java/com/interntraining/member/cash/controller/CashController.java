package com.interntraining.member.cash.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import java.net.HttpURLConnection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.interntraining.member.cash.domain.PGInfo;
import com.interntraining.member.cash.service.CashService;
import com.interntraining.member.login.domain.User;


@Controller
@RequestMapping(value= "/Cash")
public class CashController {

	@Autowired
	private CashService cashService;
	
	//캐시 구매 페이지로 이동
	@RequestMapping(value="/PurchaseForm")
	public ModelAndView purchaseForm(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
			
		String id = (String) session.getAttribute("login.getintUserNo"); 
		
		int remainCash = 00 ;//보유액 확인
		
		mav.setViewName("/user/cash/CashPurchase");
		return mav;
	}
	
	//캐시 구매	
	@RequestMapping(value="/Purchase", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public ModelAndView purchase(@RequestParam("money") String money, @RequestParam("pgcode") String pgcode, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ClientProtocolException, IOException {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		int amount = Integer.parseInt(money);
		PGInfo sendObject = new PGInfo();
		User user = (User) session.getAttribute("login");
		String name = user.getStrUserName();	//이름		
		String id = (String) session.getAttribute("id");	//id		
		String lastOrderNo = cashService.selectOrderNo();	// 최근 결재번호
		

		sendObject.setOrder_no(lastOrderNo);//결제번호			
		sendObject.setUser_name(name); //이름
		sendObject.setUser_id(id); 		//id
		sendObject.setAmount(amount);	//충전할 캐시
		sendObject.setPgcode(pgcode);	//결제 종류(휴대폰/신용카드)
		sendObject = cashService.purchase(sendObject);
		
		
		mav.addObject("onlineUrl", sendObject.getOnline_url());		
		
		return mav;
	}
	
	//충전완료(return_url)
	@RequestMapping(value="/Close", produces="application/json;charset=UTF-8")
	@ResponseBody
	public ModelAndView close(PGInfo pgInfo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ClientProtocolException, IOException {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		String orderNo = pgInfo.getOrder_no();
		
		//DB에 결과값 저장
		//System.out.println(pgInfo.getTid());
		//System.out.println(pgInfo.getCard_info());
		mav.addObject("orderNo", orderNo);
		mav.setViewName("/user/cash/close");
		return mav;
	}
	
	//충전완료 페이지
	@RequestMapping(value="/Success", produces="application/json;charset=UTF-8")
	@ResponseBody
	public ModelAndView succes(String orderNo,PGInfo pgInfo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ClientProtocolException, IOException {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
			
		String id = (String) session.getAttribute("id");//아이디
		int userNo = cashService.selectUserId(id);	//회원 번호 찾기
		User user = new User();
		
		
		user.setIntUserNo(userNo);//회원번호
		user.setStrOrderNo(orderNo);//주문번호
		user = cashService.selectUserCashInfo(userNo,orderNo);	//회원의 현재 보유 캐시정보
		session.setAttribute("cash", user.getIntTotalCashAmt());
		
		mav.addObject("id",id);
		mav.addObject("result", user);
	//	mav.addObject("cash",user.getIntTotalCashAmt());
		mav.setViewName("/user/cash/CashSuccess");
		return mav;
	}
	
	//충전완료(callback_url)
	@RequestMapping(value="/PurchaseSave", produces="application/json;charset=UTF-8")
	@ResponseBody
	public ModelAndView purchaseSave(@RequestBody PGInfo pgInfo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ClientProtocolException, IOException {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
	
		String order = pgInfo.getOrder_no();

		String id = pgInfo.getUser_id();
		int userNo = cashService.selectUserId(id);	//회원 번호 찾기
		//System.out.println(order);
		BigInteger orderNo = new BigInteger(order);
		pgInfo.setIntCashNo(orderNo);
		pgInfo.setIntUserNo(userNo);	//회원 번호
		pgInfo.setIntCashAmt(pgInfo.getAmount());//캐시
		pgInfo.setStrPurchaseState("결제완료");//상태
		pgInfo.setCode("0");//성공

		
		cashService.insertPgResult(pgInfo);	//DB에  결제 결과값 저장		
		
		cashService.updateUserCashMst(pgInfo);	//cash 충전(회원번호, 충전액)
		//System.out.println(pgInfo.getTid());
		
		mav.addObject("message","");
		mav.addObject("code",0);
		
		return mav;
	}
}
