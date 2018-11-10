package com.interntraining.admin.cash.controller;

import java.math.BigInteger;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.cash.service.AdminCashService;
import com.interntraining.member.cash.domain.PGInfo;

@Controller
@RequestMapping(value= "/AdminCash")
public class AdminCashController {
	
	@Autowired
	private AdminCashService admincashService;
	
	//캐시 내역 페이지로 이동
	@RequestMapping(value="/AdminCashList")
	public ModelAndView adminCashList(int userNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<PGInfo> cash = admincashService.selectCashList(userNo);	//캐시 내역 가져오기
		
		String id = admincashService.selectUserId(userNo);	//유저 아이디 찾기
		mav.addObject("cash", cash);
		mav.addObject("id",id);
		mav.setViewName("/admin/membership/CashList");
		return mav;
	}
	

	//결제 취소
	@RequestMapping(value="/CashCancel",produces="application/json")
	public ModelAndView cashCancel(BigInteger cashNo) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		admincashService.cashCancel(cashNo);	//결제 취소
		
		mav.setViewName("");
		return mav;
	}
}
