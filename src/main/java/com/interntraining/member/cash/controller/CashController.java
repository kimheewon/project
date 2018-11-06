package com.interntraining.member.cash.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
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


@Controller
@RequestMapping(value= "/Cash")
public class CashController {

	@Autowired
	private CashService purchaseCashService;
	
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
		
		String userName = (String) session.getAttribute("login.getStrUserName()");
		String id = (String) session.getAttribute("id");	//id
		//int OrderNo = purchaseCashService.selectOrderNo();	//결재번호
	
		sendObject.setUser_name(userName); //이름
		sendObject.setUser_id(id); 		//id
		sendObject.setAmount(amount);	//충전할 캐시
		sendObject.setPgcode(pgcode);	//결제 종류(휴대폰/신용카드)
		sendObject = purchaseCashService.purchase(sendObject);
		
		//휴대폰인지 신용카드인지 구별
		mav.addObject("mobileUrl", sendObject.getOnline_url());		
		
		return mav;
	}
}
