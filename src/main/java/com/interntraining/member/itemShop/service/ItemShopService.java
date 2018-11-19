package com.interntraining.member.itemShop.service;

import java.math.BigInteger;
import java.util.List;

import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.board.domain.Pagination;
import com.interntraining.member.cash.domain.PaginationCash;
import com.interntraining.member.itemShop.domain.ItemShopInfo;
import com.interntraining.member.itemShop.domain.PaginationItem;
import com.interntraining.member.login.domain.User;

public interface ItemShopService {

	//아이템 전체 목록
	public List<ProductInfo> selectAllItemList();

	// 페이징 리스트
	public List<ProductInfo> selectAllItem(PaginationItem pagination);

	//검색시 아이템 개수
	public List<ProductInfo> countItemList(ProductInfo info);

	//검색시 아이템 전체 목록 개수
	public List<ProductInfo> selectAllItemSearch(Pagination pagination);

	//아이템 번호로 아이템 정보 가져오기
	public ItemShopInfo selectItemInfo(int itemNo);

	//회원 정보 불러오기
	public User selectMemberInfo(int userNo);

	//아이템 구매 번호 생성
	public BigInteger selectOrderNo();

	//아이템구매(아이템 구매 테이블에 insert)
	public void insertItemPurchase(ItemShopInfo item);

	//구매 매핑테이블에 insert
	public void insertItemPurchaseMapping(ItemShopInfo item);

	//회원 계좌 정보 update
	public void updateUserCashOutMst(ItemShopInfo item);

	//현재 보유 캐시 정보 가져오기
	public int selectTotalCash(int intUserNo);

	//가격들 int로 변환
	public ItemShopInfo replace(ItemShopInfo item);

	//배송정보 insert
	public void insertDeliveryInfo(ItemShopInfo item);

	//구매한 아이템 정보 가져오기
	public ItemShopInfo selectPurchaseItem(BigInteger purchaseNo);

	//베송정보 가져오기
	public ItemShopInfo selectDeliveryInfo(BigInteger purchaseNo);

	//아이템 구매 리스트
	public List<ItemShopInfo> selectAllPurchaseList(int userNo);

	//아이템 구매 리스트 페이징 처리
	public List<ItemShopInfo> selectPurchasePaging(PaginationCash pagination);

	//매핑테이블 아이템 구매 취소
	public void selectPurchaseCancelMap(ItemShopInfo item);

	//아이템 구매 테이블 구매 취소 update
	public void updateItemPurchaseCancel(BigInteger bigInteger);

	//배송 테이블 삭제
	public void deleteDeliver(BigInteger intNumber);

	//사용자 계좌 캐시 update
	public void updateUserCashInOutMst(ItemShopInfo item);

	//아이템 구매 리스트(날짜검색)
	public List<ItemShopInfo> searchAllPurchaseList(ItemShopInfo info);

	//아이템 구매 리스트 페이징 처리(날짜검색)
	public List<ItemShopInfo> searchAllPurchasePaging(PaginationCash pagination);


}
