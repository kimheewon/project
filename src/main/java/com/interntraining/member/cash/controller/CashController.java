package com.interntraining.member.cash.controller;

import java.io.BufferedReader;
import java.io.Console;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONArray;
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
import com.interntraining.member.cash.domain.PaginationCash;
import com.interntraining.member.cash.domain.PgRequest;
import com.interntraining.member.cash.service.CashService;
import com.interntraining.member.itemShop.domain.ItemShopInfo;
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
		
			
		mav.setViewName("/user/cash/CashPurchase");
		return mav;
	}
	
	//캐시 구매	
	@RequestMapping(value="/Purchase", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public ModelAndView purchase(@RequestParam("money") String money, @RequestParam("pgcode") String pgcode, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ClientProtocolException, IOException {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		String strMoney = money.replaceAll(",", "");		
		int amount = Integer.parseInt(strMoney);
		PGInfo sendObject = new PGInfo();
		User user = (User) session.getAttribute("login");
		String name = user.getStrUserName();	//이름		
		String id = (String) session.getAttribute("id");	//id	
		int no = (int) session.getAttribute("no");//no
		//String lastOrderNo = cashService.selectOrderNo();	// 최근 결재번호
		
		sendObject.setIntUserNo(no);
		//sendObject.setOrder_no(lastOrderNo);//결제번호			
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
	public ModelAndView succes(String orderNo,HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ClientProtocolException, IOException {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
			
		String id = (String) session.getAttribute("id");//아이디
		int userNo = cashService.selectUserNo(id);	//회원 번호 찾기
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
		
		int check = cashService.checkResult(pgInfo);	//요청값과 결과값 비교
		
		if(check == 0) {	//결과 성공
			
			String order = pgInfo.getOrder_no();	
			int orderNo = Integer.parseInt(order);	//orderNo
			
			

			String id = pgInfo.getUser_id();
			int userNo = cashService.selectUserNo(id);	//회원 번호 찾기
			
			BigInteger CashNo = cashService.selectOrderNo();	// 최근 결재번호
			

			pgInfo.setIntCashNo(CashNo);	//cashNo	
			
			//BigInteger orderNo = new BigInteger(order);
			pgInfo.setIntorderNo(orderNo);
			pgInfo.setIntUserNo(userNo);	//회원 번호
			pgInfo.setIntCashAmt(pgInfo.getAmount());//캐시		
			pgInfo.setStrPurchaseState("결제 완료");//상태
			pgInfo.setCode("0");//성공
			
			cashService.insertPgResult(pgInfo);	//DB에  결제 결과값 저장		
			cashService.updateState(orderNo);	//상태 update
			cashService.updateUserCashMst(pgInfo);	//cash 충전(회원번호, 충전액)
				
			mav.addObject("message","");
			mav.addObject("code",0);
			
		}
		else {	//실패
			mav.addObject("message","결제 정보가 다름");
			mav.addObject("code",1);					
		}
		
		
		
		return mav;
	}
	
	//캐시 내역 페이지로 이동
	@RequestMapping(value="/CashList")
	public ModelAndView cashList(@RequestParam(required=false) String searchStartDate, @RequestParam(required=false) String searchEndDate,HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(required=false) Integer nowPage,@RequestParam(required=false)Integer nowBlock, @RequestParam(defaultValue="1") int curPage) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		int userNo = (int) session.getAttribute("no");	//회원 번호
		
		if(searchStartDate == null && searchEndDate == null) {	//날짜 검색 없음
			List<PGInfo> cash = cashService.selectCashList(userNo);	//캐시 내역 가져오기
			
			int listCnt = cash.size();		
			PaginationCash pagination = new PaginationCash(listCnt, curPage);		
			pagination.setIntUserNo(userNo);
			pagination.setPageSize(25);
			pagination.setRangeSize(25);
			
			/* List */
	        List<PGInfo> cashList = cashService.selectCashPaging(pagination);	//캐시 내역 페이징처리
	        
	        //글 시퀀스 번호
	        int c = listCnt - (curPage-1)*25;
	        for(int i=0; i<cashList.size(); i++) {
	        	cashList.get(i).setIntNum(c--);	        
	        }
	        
	        
			mav.addObject("cashList", cashList);
			mav.addObject("listCnt", listCnt);
			mav.addObject("pagination", pagination);
		}
		else {	//날짜 검색		

			ItemShopInfo info = new ItemShopInfo();
			info.setIntUserNo(userNo);
			info.setSearchStartDate(searchStartDate);
			info.setSearchEndDate(searchEndDate);
			
			List<PGInfo> cash = cashService.searchCashList(info);	//캐시 내역 가져오기(날짜검색)
			
			int listCnt = cash.size();		
			PaginationCash pagination = new PaginationCash(listCnt, curPage);		
			pagination.setIntUserNo(userNo);
			pagination.setPageSize(25);
			pagination.setRangeSize(25);
			pagination.setSearchStartDate(searchStartDate);
			pagination.setSearchEndDate(searchEndDate);
			
			/* List */
	        List<PGInfo> cashList = cashService.searchCashPaging(pagination);	//캐시 내역 페이징처리(날짜검색)
	        
	        //글 시퀀스 번호
	        int c = listCnt - (curPage-1)*25;
	        for(int i=0; i<cashList.size(); i++) {
	        	cashList.get(i).setIntNum(c--);	        
	        }
	        
	        
			mav.addObject("cashList", cashList);
			mav.addObject("listCnt", listCnt);
			mav.addObject("pagination", pagination);
			mav.addObject("searchStartDate", searchStartDate);
			mav.addObject("searchEndDate", searchEndDate);
		}
		mav.setViewName("/user/cash/CashList");
		return mav;
	}
	
	
	
}
