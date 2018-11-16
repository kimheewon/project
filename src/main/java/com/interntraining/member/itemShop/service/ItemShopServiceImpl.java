package com.interntraining.member.itemShop.service;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.cash.domain.CashInfo;
import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.board.domain.Pagination;
import com.interntraining.member.cash.domain.PaginationCash;
import com.interntraining.member.itemShop.dao.ItemShopDAO;
import com.interntraining.member.itemShop.domain.ItemShopInfo;
import com.interntraining.member.itemShop.domain.PaginationItem;
import com.interntraining.member.login.domain.User;

@Service()
public class ItemShopServiceImpl implements ItemShopService{

	@Resource(name = "itemShopDAO")
	private ItemShopDAO itemShopDAO;
	
	@Autowired
	@Qualifier("mainDBTransactionManager")
	private DataSourceTransactionManager transactionManager;

	//아이템 전체 목록
	@Override
	public List<ProductInfo> selectAllItemList() {
		return itemShopDAO.selectAllItemList();
	}

	// 페이징 리스트
	@Override
	public List<ProductInfo> selectAllItem(PaginationItem pagination) {
		return itemShopDAO.selectAllItem(pagination);
	}

	//검색시 아이템 개수
	@Override
	public List<ProductInfo> countItemList(ProductInfo info) {
		return itemShopDAO.countItemList(info);
	}

	//검색시 아이템 전체 목록 개수
	@Override
	public List<ProductInfo> selectAllItemSearch(Pagination pagination) {
		return itemShopDAO.selectAllItemSearch(pagination);
	}

	//아이템 번호로 아이템 정보 가져오기
	@Override
	public ItemShopInfo selectItemInfo(int itemNo) {
		ItemShopInfo item = itemShopDAO.selectItemInfo(itemNo);
		
		if(item.getIntItemPrice() > 50000) {
			item.setIntDeliveryPrice(0);
		}
		else {
			item.setIntDeliveryPrice(3000);
		}
		
		return item;
		
	}

	//회원 정보 불러오기
	@Override
	public User selectMemberInfo(int userNo) {
		return itemShopDAO.selectMemberInfo(userNo);
	}

	//아이템 구매 번호 생성
	@Override
	public BigInteger selectOrderNo() {
		BigInteger lastOrderNo = itemShopDAO.selectOrderNo();	//마지막 번호
		String lastDate = String.valueOf(lastOrderNo).substring(0,8);	//년월일
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyyMMdd", Locale.KOREA);
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format (currentTime);	//오늘일
		
		BigInteger intOrderNo;
		//String orderNo;
		if(mTime.equals(lastDate)) {	//마지막번호 == 오늘(최초 등록)
			
			intOrderNo = lastOrderNo.add(BigInteger.valueOf(1));	//1더하기
			itemShopDAO.insertOrderNo(intOrderNo);	//pk 저장
		}
		else {	//마지막번호 != 오늘
			String lastNum = mTime + "00001";
			intOrderNo = new BigInteger(lastNum);
			itemShopDAO.insertOrderNo(intOrderNo);	//pk 저장
		}
		
		return intOrderNo;
	}

	//아이템구매(아이템 구매 테이블에 insert)
	@Override
	public void insertItemPurchase(ItemShopInfo item) {		
		itemShopDAO.insertItemPurchase(item);
	}

	//구매 매핑테이블에 insert
	@Override
	public void insertItemPurchaseMapping(ItemShopInfo item) {
		List<CashInfo> list = itemShopDAO.selectCashAllList(item.getIntUserNo());	//remaincash가 있는 리스트 가져오기
		
		CashInfo map = new CashInfo();
		int cash = item.getIntItemTotalPrice();	//차감할 캐시
		int sum = 0;
		int remain = 0;

		
		for(int i=0; i<list.size(); i++) {
			sum = sum + list.get(i).getIntRemainCash();	
			map.setIntUserNo(item.getIntUserNo());
			map.setIntPurchaseNo(item.getIntNumber());			
			if(sum < cash) {
				BigInteger cashNo = list.get(i).getIntCashNo();
				map.setIntCashNo(cashNo);				
				remain=0;
				map.setIntRemainCash(remain);
				itemShopDAO.insertEachItemPurchaseMapping(map);
				itemShopDAO.updateCashRemain(map);		//남은돈 update
				//mapping.add(info);
			}
			else if(sum == cash){
				BigInteger cashNo = list.get(i).getIntCashNo();
				map.setIntCashNo(cashNo);	
				remain=0;
				map.setIntRemainCash(remain);
				itemShopDAO.insertEachItemPurchaseMapping(map);
				itemShopDAO.updateCashRemain(map);		//남은돈 update
				//mapping.add(info);
				//param.put("mapping", info);
				break;
			}else {
				BigInteger cashNo = list.get(i).getIntCashNo();
				map.setIntCashNo(cashNo);	
				remain = sum - cash;
				map.setIntRemainCash(remain);
				itemShopDAO.insertEachItemPurchaseMapping(map);
				itemShopDAO.updateCashRemain(map);		//남은돈 update
				break;
			}
		}
		
	}

	//회원 계좌 정보 update
	@Override
	public void updateUserCashOutMst(ItemShopInfo item) {
		User user = new User();
		user = itemShopDAO.selectUserCashInfo(item.getIntUserNo());	//유저의 기존 보유 캐시 정보 가져오기
	
		int cash = item.getIntItemTotalPrice();	//차감 코인
		int totalOutCash = user.getIntTotalOutCashAmt() + cash;
		int totalCash = user.getIntTotalCashAmt() - cash;
		
		User userNew = new User();
		userNew.setIntUserNo(item.getIntUserNo());//no
		userNew.setIntTotalOutCashAmt(totalOutCash);//out
		userNew.setIntTotalCashAmt(totalCash);//total
				
		itemShopDAO.updateUserCashOutMst(userNew);		//cash 회수(회원번호, 충전액)
	}

	//현재 보유 캐시 정보 가져오기
	@Override
	public int selectTotalCash(int intUserNo) {
		return itemShopDAO.selectUserCashAmt(intUserNo);
	}

	//가격들 int로 변환
	@Override
	public ItemShopInfo replace(ItemShopInfo item) {
		//아이템 가격
		String oriPrice = item.getItemPrice();
		String price = oriPrice.replaceAll(",", "");
		int intPrice = Integer.parseInt(price);
		item.setIntItemPrice(intPrice);
				
		//배송료
		String oriDeliver = item.getDeliveryPrice();
		String deliver = oriDeliver.replaceAll(",", "");
		int intDeliver = Integer.parseInt(deliver);
		item.setIntDeliveryPrice(intDeliver);
				
		//총합
		int total = intPrice * item.getItemCount() + intDeliver;
		item.setIntItemTotalPrice(total);
		return item;
	}

	//배송정보 insert
	@Override
	public void insertDeliveryInfo(ItemShopInfo item) {
		String phone = item.getStrTel();
		String tel = phone.replace(" - ", "");
		item.setStrTel(tel);
		itemShopDAO.insertDeliveryInfo(item);
		
	}

	//구매한 아이템 정보 가져오기
	@Override
	public ItemShopInfo selectPurchaseItem(BigInteger purchaseNo) {
		ItemShopInfo item = itemShopDAO.selectPurchaseItem(purchaseNo);
		int itemPrice = item.getIntItemPrice();
		int count = item.getItemCount();
		
		int itemTotal = itemPrice * count;
		item.setIntMiddlePrice(itemTotal);
		
		return item;
	}

	//배송정보 가져오기
	@Override
	public ItemShopInfo selectDeliveryInfo(BigInteger purchaseNo) {
		
		return itemShopDAO.selectDeliveryInfo(purchaseNo);
	}

	//아이템 구매 리스트
	@Override
	public List<ItemShopInfo> selectAllPurchaseList(int userNo) {
		return itemShopDAO.selectAllPurchaseList(userNo);
	}

	//아이템 구매 리스트 페이징 처리
	@Override
	public List<ItemShopInfo> selectPurchasePaging(PaginationCash pagination) {
		List<ItemShopInfo> item = itemShopDAO.selectPurchasePaging(pagination);
		
		for(int i=0; i<item.size();i++) {
			int no = item.get(i).getIntItemNo();
			String name = itemShopDAO.selectItemName(no);	//아이템 명 찾기
			item.get(i).setStrItemName(name);
		}
		return item;
	}

	//매핑테이블 아이템 구매 취소
	@Override
	public void selectPurchaseCancelMap(ItemShopInfo item) {
		
		int sum = 0;
		int price = item.getIntItemTotalPrice();
		int oriCash = 0;
		int usedCash = 0;
		
		BigInteger cashNo;
		BigInteger purchaseNo = item.getIntNumber();
		
		ItemShopInfo update = new ItemShopInfo();
		
		List<ItemShopInfo> mapping = itemShopDAO.selectPurchaseCancelMap(purchaseNo);
		
		for(int i=0; i<mapping.size(); i++) {
			oriCash = mapping.get(i).getIntCash();	//처음 충전한 캐시
			usedCash = oriCash - mapping.get(i).getIntRemainCash();	//사용된 캐시
			sum = sum + usedCash;
			cashNo = mapping.get(i).getIntNumber();
			
			if(sum > price) {
				update.setIntRemainCash(sum-price);
				update.setIntNumber(cashNo);
				itemShopDAO.updateRemainCash(update);	//remainCash 업데이트
				break;
			}
			else if(sum == price) {
				update.setIntRemainCash(usedCash);
				update.setIntNumber(cashNo);
				itemShopDAO.updateRemainCash(update);	//remainCash 업데이트
				break;
			}
			else {
				update.setIntRemainCash(usedCash);
				update.setIntNumber(cashNo);
				itemShopDAO.updateRemainCash(update);	//remainCash 업데이트
			}
		}
		
		itemShopDAO.deleteMapping(purchaseNo);	//매핑테이블 삭제		
	}

	//아이템 구매 테이블 구매 취소 update
	@Override
	public void updateItemPurchaseCancel(BigInteger bigInteger) {
		itemShopDAO.updateItemPurchaseCancel(bigInteger);
		
	}

	//배송 테이블 삭제
	@Override
	public void deleteDeliver(BigInteger intNumber) {
		itemShopDAO.deleteDeliver(intNumber);
	}

	//사용자 계좌 캐시 update
	@Override
	public void updateUserCashInOutMst(ItemShopInfo item) {
				
		User user = new User();
		user = itemShopDAO.selectUserCashInfo(item.getIntUserNo());	//유저의 기존 보유 캐시 정보 가져오기
	
		int cash = item.getIntItemTotalPrice();	//차감 코인
	
		int totalOutCash = user.getIntTotalOutCashAmt() - cash;
		int totalCash = user.getIntTotalCashAmt() + cash;
		
		User userNew = new User();
		userNew.setIntUserNo(item.getIntUserNo());//no
		userNew.setIntTotalOutCashAmt(totalOutCash);//out
		userNew.setIntTotalCashAmt(totalCash);//total
				
		itemShopDAO.updateUserCashOutMst(userNew);		//아이템 구매 취소
	}

	
}

