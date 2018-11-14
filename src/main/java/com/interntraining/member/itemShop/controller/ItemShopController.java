package com.interntraining.member.itemShop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.board.domain.Pagination;
import com.interntraining.member.itemShop.domain.ItemShopInfo;
import com.interntraining.member.itemShop.domain.PaginationItem;
import com.interntraining.member.itemShop.service.ItemShopService;

@Controller
@RequestMapping(value= "/ItemShop")
public class ItemShopController {
	
	@Autowired
	private  ItemShopService itemShopService;

	//아이템샵 목록페이지로 이동
	@RequestMapping(value="/ItemShopList")
	public ModelAndView itemshopList(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(required=false) Integer nowPage,@RequestParam(required=false)Integer nowBlock,
            @RequestParam(required=false) String keyField, @RequestParam(required=false) String keyWord, @RequestParam(defaultValue="1") int curPage) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		String KeyWord = request.getParameter("keyWord");
		String KeyField = request.getParameter("keyField");
		

		if(KeyWord == null) {	//검색어 없을 경우
			List<ProductInfo> itemsCount = itemShopService.selectAllItemList();		//아이템 전체 목록 개수
			int listCnt = itemsCount.size();
			PaginationItem pagination = new PaginationItem(listCnt, curPage);
			
			  /* List */
	        List<ProductInfo> items = itemShopService.selectAllItem(pagination);	// 페이징 리스트
	        
	        mav.addObject("items", items);
	        mav.addObject("listCnt", listCnt);
			mav.addObject("pagination", pagination);
			mav.setViewName("/user/itemShop/ItemShopList");
	        
		}else {
			ProductInfo info = new ProductInfo();
			info.setKeyField(KeyField);
			info.setKeyWord(KeyWord);
			List<ProductInfo> itemsCount = itemShopService.countItemList(info);	//검색시 아이템 개수
			int listCnt = itemsCount.size();
					
			Pagination pagination = new Pagination(listCnt, curPage);
			pagination.setKeyField(KeyField);
			pagination.setKeyWord(KeyWord);
			pagination.setCurPage(curPage);
			
			List<ProductInfo> items = itemShopService.selectAllItemSearch(pagination);	//검색시 아이템 전체 목록 개수
					
			mav.addObject("keyWord", KeyWord);
			mav.addObject("listCnt", listCnt);
			mav.addObject("items", items);
			mav.addObject("pagination", pagination);
			mav.setViewName("/user/itemShop/ItemShopList");
		}
		
		return mav;
	}
	
	//아이템 구매 페이지로 이동
	@RequestMapping(value="/ItemPurchaseForm")
	public ModelAndView ItemPurchaseForm(int itemNo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		ItemShopInfo item = itemShopService.selectItemInfo(itemNo);		//아이템 번호로 아이템 정보 가져오기
		//회원목록에서 배송지 정보 가져오기
		mav.addObject("item", item);
		mav.setViewName("/user/itemShop/ItemPurchase");
		return mav;
		}
}
