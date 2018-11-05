package com.interntraining.member.cash.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	@RequestMapping(value="/Purchase")
	public ModelAndView purchase(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws JsonProcessingException {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
			
		String id = (String) session.getAttribute("login.getintUserNo"); 
		
		 HttpClient client = new DefaultHttpClient();


		String url = "https://testpgapi.payletter.com";
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("POST", "/v1.0/payments/request HTTP/1.1");
		httpPost.setHeader("Host","testpgapi.payletter.com");
		httpPost.setHeader("Content-Type", "application/json");
		httpPost.setHeader("Authorization", "PLKEY B9B190294F0DCAA4662963D81C17B2A7");

		PGInfo sendObject = new PGInfo();
		sendObject.setPgcode("mobile");
		sendObject.setUser_id("test_user_id");
		sendObject.setUser_name("테스터"); 
		sendObject.setService_name("페이레터");
		sendObject.setClient_id("pay_test");
		sendObject.setOrder_no("1234567890");
		sendObject.setAmount(1000);
		sendObject.setProduct_name("테스트상품");
		sendObject.setEmail_flag("Y");
		sendObject.setEmail_addr("payletter@payletter.com");
		sendObject.setAutopay_flag("N");
		sendObject.setReceipt_flag("Y");
		sendObject.setCustom_parameter("this is custom parameter");
		sendObject.setReturn_url("https://testpg.payletter.com/result");
		sendObject.setCallback_url("https://testpg.payletter.com/callback");
		sendObject.setCancel_url("https://testpg.payletter.com/cancel");

		ObjectMapper objectMapper = new ObjectMapper();
		String jsonValue = objectMapper.writeValueAsString(sendObject);
		HttpEntity httpEntity = new StringEntity(jsonValue, "utf-8");

		httpPost.setEntity(httpEntity);
		HttpResponse httpResponse = client.execute(httpPost);

		System.out.println(httpResponse);

		
		return mav;
	}
}
