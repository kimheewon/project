package com.interntraining.member.itemShop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.itemShop.service.ItemShopService;

@Controller
@RequestMapping(value= "/ItemShop")
public class ItemShopController {
	
	@Autowired
	private  ItemShopService itemShopService;

	//아이템샵 목록페이지로 이동
	@RequestMapping(value="/ItemShopList")
	public ModelAndView itemshopList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<ProductInfo> items = itemShopService.selectAllItemList();		//아이템 전체 목록
		
		mav.addObject("items", items);
		mav.setViewName("/itemShop/ItemShopList");
		return mav;
	}
}
