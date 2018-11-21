package com.interntraining.member.itemShop.controller;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.board.domain.Pagination;
import com.interntraining.member.cash.domain.PaginationCash;
import com.interntraining.member.itemShop.domain.ItemShopInfo;
import com.interntraining.member.itemShop.domain.PaginationItem;
import com.interntraining.member.itemShop.service.ItemShopService;
import com.interntraining.member.login.domain.User;

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
	        
	        //오늘날짜
	        SimpleDateFormat  date = new SimpleDateFormat("yyyy-MM-dd");
	        String today =  date.format(new Date());	           
	        
	        	        
	        mav.addObject("today", today);
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
					
			 //오늘날짜
	        SimpleDateFormat  date = new SimpleDateFormat("yyyy-MM-dd");
	        String today =  date.format(new Date());	           
	        
	        mav.addObject("today", today);
			mav.addObject("keyField", keyField);
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
	
	//회원정보 불러오기
	@RequestMapping(value="/MemberInfo")
	public ModelAndView memberInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		int userNo = (int) session.getAttribute("no");
		
		User user = itemShopService.selectMemberInfo(userNo);	//회원 정보 불러오기
		
		mav.addObject("user",user);
		return mav;
	}
	
	//아이템 구매
	@RequestMapping(value="/ItemPurchase",method = RequestMethod.POST)
	public ModelAndView ItemPurchase(ItemShopInfo item, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		int userNo = (int) session.getAttribute("no");
		item.setIntUserNo(userNo);
		
		item = itemShopService.replace(item); 	//가격들 int로 변환
		int nowTotalCash = itemShopService.selectTotalCash(item.getIntUserNo());	//현재 보유 캐시 정보 가져오기
		
		if(item.getIntItemTotalPrice() <= nowTotalCash) {
			
			BigInteger number = itemShopService.selectOrderNo();		//아이템 구매 번호 생성
			item.setIntNumber(number);  //아이템 구매 번호
			
			itemShopService.insertItemPurchase(item);	//아이템구매(아이템 구매 테이블에 insert)
			itemShopService.insertItemPurchaseMapping(item);	//구매 매핑테이블에 insert
			
			itemShopService.updateUserCashOutMst(item); //회원 계좌 정보 update
			itemShopService.insertDeliveryInfo(item);	//배송정보 insert
			
			int totalCash = itemShopService.selectTotalCash(item.getIntUserNo());	//현재 보유 캐시 정보 가져오기
			session.setAttribute("cash", totalCash);
			
			mav.addObject("PurchaseNo", item.getIntNumber());
			mav.setViewName("redirect:/ItemShop/ItemPurchaseResult");
		}
		else {	//돈없으면 충전페이지로
			mav.setViewName("user/itemShop/ItemPurchaseFail");
		}
		
		return mav;
	}
	
	//아이템 구매 결과 페이지로 이동
	@RequestMapping(value="/ItemPurchaseResult")
	public ModelAndView itemPurchaseResult(BigInteger PurchaseNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		ItemShopInfo item = itemShopService.selectPurchaseItem(PurchaseNo);		//구매한 아이템 정보 가져오기
		ItemShopInfo itemInfo = itemShopService.selectItemInfo(item.getIntItemNo());
		ItemShopInfo deliver = itemShopService.selectDeliveryInfo(PurchaseNo);		//배송정보 가져오기
		
		mav.addObject("PurchaseNo", PurchaseNo);
		mav.addObject("item", item);
		mav.addObject("itemInfo", itemInfo);
		mav.addObject("deliver", deliver);
		mav.setViewName("/user/itemShop/ItemPurchaseResult");
		return mav;
	}

	//아이템 구매 내역 리스트 페이지로 이동
	@RequestMapping(value="/ItemPurchaseList")
	public ModelAndView itemPurchaseList(@RequestParam(required=false) String searchStartDate, @RequestParam(required=false) String searchEndDate, HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(required=false) Integer nowPage,@RequestParam(required=false)Integer nowBlock, @RequestParam(defaultValue="1") int curPage) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		int userNo = (int) session.getAttribute("no");

		if(searchStartDate == null && searchEndDate == null) {	//날짜 검색 없음
			List<ItemShopInfo> itemList = itemShopService.selectAllPurchaseList(userNo);	//아이템 구매 리스트
			
			int listCnt = itemList.size();		
			PaginationCash pagination = new PaginationCash(listCnt, curPage);		
			pagination.setIntUserNo(userNo);
			pagination.setPageSize(25);
			pagination.setRangeSize(25);
			
			/* List */
	        List<ItemShopInfo> item = itemShopService.selectPurchasePaging(pagination);		//아이템 구매 리스트 페이징 처리
			
	        //글 시퀀스 번호
	        int c = listCnt - (curPage-1)*25;
	        for(int i=0; i<item.size(); i++) {
	        	item.get(i).setIntNum(c--);	        
	        }
        
	        mav.addObject("item", item);
			mav.addObject("listCnt", listCnt);
			mav.addObject("pagination", pagination);
			
		}
		else {	//날짜 검색
			
			ItemShopInfo info = new ItemShopInfo();
			info.setIntUserNo(userNo);
			info.setSearchStartDate(searchStartDate);
			info.setSearchEndDate(searchEndDate);
			
			List<ItemShopInfo> itemList = itemShopService.searchAllPurchaseList(info);	//아이템 구매 리스트(날짜검색)
			
			int listCnt = itemList.size();		
			PaginationCash pagination = new PaginationCash(listCnt, curPage);		
			pagination.setIntUserNo(userNo);
			pagination.setPageSize(25);
			pagination.setRangeSize(25);
			pagination.setSearchStartDate(searchStartDate);
			pagination.setSearchEndDate(searchEndDate);
			
			/* List */
	        List<ItemShopInfo> item = itemShopService.searchAllPurchasePaging(pagination);		//아이템 구매 리스트 페이징 처리(날짜검색)
			
	        //글 시퀀스 번호
	        int c = listCnt - (curPage-1)*25;
	        for(int i=0; i<item.size(); i++) {
	        	item.get(i).setIntNum(c--);	        
	        }
        
	        mav.addObject("item", item);
			mav.addObject("listCnt", listCnt);
			mav.addObject("pagination", pagination);
			mav.addObject("searchStartDate", searchStartDate);
			mav.addObject("searchEndDate", searchEndDate);
			
		}
		mav.setViewName("/user/itemShop/ItemPurchaseList");
		return mav;
	}	
	
	//아이템 구매 취소 페이지로 이동
	@RequestMapping(value="ItemPurchaseCancelForm")
	public ModelAndView itemPurchaseCancelForm(BigInteger PurchaseNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		ItemShopInfo item = itemShopService.selectPurchaseItem(PurchaseNo);		//구매한 아이템 정보 가져오기
		ItemShopInfo itemInfo = itemShopService.selectItemInfo(item.getIntItemNo());
		ItemShopInfo deliver = itemShopService.selectDeliveryInfo(PurchaseNo);		//배송정보 가져오기
		
		mav.addObject("PurchaseNo", PurchaseNo);
		mav.addObject("item", item);
		mav.addObject("itemInfo", itemInfo);
		mav.addObject("deliver", deliver);
		mav.setViewName("/user/itemShop/ItemPurchaseCancel");
		return mav;
	}
	
	//아이템 구매 취소
	@RequestMapping(value="ItemPurchaseCancel",method = RequestMethod.POST)
	public ModelAndView itemPurchaseCancel(ItemShopInfo item, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
	
		int userNo = (int) session.getAttribute("no");
		item.setIntUserNo(userNo);		
		
		itemShopService.selectPurchaseCancelMap(item);	//매핑테이블 아이템 구매 취소
		
		itemShopService.updateItemPurchaseCancel(item.getIntNumber());		//아이템 구매 테이블 구매 취소 update
		
		itemShopService.deleteDeliver(item.getIntNumber());		//배송 테이블 삭제
		
		itemShopService.updateUserCashInOutMst(item);		//사용자 계좌 캐시 update
		
		int totalCash = itemShopService.selectTotalCash(item.getIntUserNo());	//현재 보유 캐시 정보 가져오기
		session.setAttribute("cash", totalCash);
		
		mav.setViewName("/user/itemShop/ItemPurchaseCancelResult");
		return mav;
	}
}
