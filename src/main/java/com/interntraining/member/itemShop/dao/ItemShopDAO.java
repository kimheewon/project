package com.interntraining.member.itemShop.dao;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.cash.domain.CashInfo;
import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.board.domain.Pagination;
import com.interntraining.member.cash.domain.PaginationCash;
import com.interntraining.member.itemShop.domain.ItemShopInfo;
import com.interntraining.member.itemShop.domain.PaginationItem;
import com.interntraining.member.login.domain.User;

@Repository("itemShopDAO")
public class ItemShopDAO {

	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;

	//아이템 전체 목록
	public List<ProductInfo> selectAllItemList() {
		return sqlSession.selectList("productSql.selectAllItemList");
	}

	//페이징 리스트
	public List<ProductInfo> selectAllItem(PaginationItem pagination) {
		return sqlSession.selectList("productSql.selectAllItem",pagination);
	}
	
	//검색시 아이템 개수
	public List<ProductInfo> countItemList(ProductInfo info) {
		return sqlSession.selectList("productSql.countItemList",info);
	}

	//검색시 아이템 전체 목록 개수
	public List<ProductInfo> selectAllItemSearch(Pagination pagination) {
		return sqlSession.selectList("productSql.selectAllItemSearch", pagination);
	}

	//아이템 번호로 아이템 정보 가져오기
	public ItemShopInfo selectItemInfo(int itemNo) {
		return sqlSession.selectOne("productSql.selectItemInfo", itemNo);
	}

	//회원 정보 불러오기
	public User selectMemberInfo(int userNo) {
		return sqlSession.selectOne("productSql.selectMemberInfo", userNo);
	}

	//마지막 번호
	public BigInteger selectOrderNo() {
		return sqlSession.selectOne("cashSql.selectOrderNo");
	}

	//pk 저장
	public void insertOrderNo(BigInteger intOrderNo) {
		sqlSession.insert("cashSql.insertOrderNo", intOrderNo);
	}

	//아이템구매(아이템 구매 테이블에 insert)
	public void insertItemPurchase(ItemShopInfo item) {
		sqlSession.insert("itemSql.insertItemPurchase", item);
	}

	//remaincash가 있는 리스트 가져오기
	public List<CashInfo> selectCashAllList(int userNo) {
		return sqlSession.selectList("itemSql.selectCashAllList",userNo);
	}

	public void insertEachItemPurchaseMapping(CashInfo map) {
		sqlSession.insert("itemSql.insertRecallMapping", map);				
	}
	
	//남은돈 update
	public void updateCashRemain(CashInfo map) {
		sqlSession.update("itemSql.updateCashRemain", map);		
	}

	//유저의 기존 보유 캐시 정보 가져오기
	public User selectUserCashInfo(int userNo) {
		return sqlSession.selectOne("cashSql.selectUserCashInfo",userNo);
	}

	//cash 회수(회원번호, 충전액)
	public void updateUserCashOutMst(User userNew) {
		sqlSession.update("cashSql.updateUserCashOutMst", userNew);		
	}

	//현재 보유 캐시 정보 가져오기
	public int selectUserCashAmt(int userNo) {
		return sqlSession.selectOne("cashSql.selectUserCashAmt",userNo);
	}

	//배송정보 insert
	public void insertDeliveryInfo(ItemShopInfo item) {
		sqlSession.insert("itemSql.insertDeliveryInfo",item);
	}

	//구매한 아이템 정보 가져오기
	public ItemShopInfo selectPurchaseItem(BigInteger purchaseNo) {
		return sqlSession.selectOne("itemSql.selectPurchaseItem", purchaseNo);
	}

	//배송정보 가져오기
	public ItemShopInfo selectDeliveryInfo(BigInteger purchaseNo) {
		return sqlSession.selectOne("itemSql.selectDeliveryInfo", purchaseNo);
	}

	//아이템 구매 리스트
	public List<ItemShopInfo> selectAllPurchaseList(int userNo) {
		return sqlSession.selectList("itemSql.selectAllPurchaseList", userNo);
	}

	//아이템 구매 리스트 페이징 처리
	public List<ItemShopInfo> selectPurchasePaging(PaginationCash pagination) {
		return sqlSession.selectList("itemSql.selectPurchasePaging",pagination);
	}

	//아이템 명 찾기
	public String selectItemName(int no) {
		return sqlSession.selectOne("itemSql.selectItemName", no);
	}

	//매핑테이블에서 취소할 항목 가져오기
	public List<ItemShopInfo> selectPurchaseCancelMap(BigInteger purchaseNo) {
		return sqlSession.selectList("itemSql.selectPurchaseCancelMap", purchaseNo);
	}

	//remainCash 업데이트
	public void updateRemainCash(ItemShopInfo update) {
		sqlSession.update("itemSql.updateRemainCash", update);
	}

	//매핑테이블 삭제
	public void deleteMapping(BigInteger purchaseNo) {
		sqlSession.delete("itemSql.deleteMapping",purchaseNo);
	}

	//아이템 구매 테이블 구매 취소 update
	public void updateItemPurchaseCancel(BigInteger purchaseNo) {
		sqlSession.update("itemSql.updateItemPurchaseCancel",purchaseNo);
	}

	//배송 테이블 삭제
	public void deleteDeliver(BigInteger purchaseNo) {
		sqlSession.delete("itemSql.deleteDeliver",purchaseNo);
	}


}

