package com.interntraining.admin.product.service;

import java.math.BigInteger;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.util.SystemPropertyUtils;

import com.interntraining.admin.product.dao.ProductDAO;
import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.itemShop.domain.ItemShopInfo;

@Service
public class ProductServiceImpl implements ProductService{

	@Resource(name = "ProductDAO")
	private ProductDAO productDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;

	//상품 DB에 저장
	@Override
	public void insertProduct(ProductInfo productInfo) {
		String price = productInfo.getStrPrice();
		String strPrice = price.replaceAll(",", "");	
		int intPrice = Integer.parseInt(strPrice);
		productInfo.setIntItemPrice(intPrice);			
		productDAO.insertProduct(productInfo);		
	}

	//DB에서 모든 상품 리스트 가져오기
	@Override
	public List<ProductInfo> seletAllList() {
		return productDAO.seletAllList();
	}

	//수정한 관리자 이름 가져오기
	@Override
	public String selectAdminName(int updateNo) {
		return productDAO.selectAdminName(updateNo);
	}

	//상품 삭제
	@Override
	public void deleteProduct(int itemNo) {
		productDAO.deleteProduct(itemNo);
	}

	//상품 불러오기
	@Override
	public ProductInfo selectProduct(int itemNo) {
		return productDAO.selectProduct(itemNo);
	}

	//상품 DB에 업데이트(이미지변경)
	@Override
	public void updateProductImg(ProductInfo product) {
		String price = product.getStrPrice();
		String strPrice = price.replaceAll(",", "");	
		int intPrice = Integer.parseInt(strPrice);
		product.setIntItemPrice(intPrice);			
		productDAO.updateProductImg(product);		
	}

	//상품 DB에 업데이트
	@Override
	public void updateProduct(ProductInfo product) {
		String price = product.getStrPrice();
		String strPrice = price.replaceAll(",", "");	
		int intPrice = Integer.parseInt(strPrice);
		product.setIntItemPrice(intPrice);			
		productDAO.updateProduct(product);
	}

	//상품 구매 리스트 불러오기
	@Override
	public List<ItemShopInfo> selectProductList() {		
		List<ItemShopInfo> item = productDAO.selectProductList();
		for(int i=0; i<item.size();i++) {
			BigInteger no = item.get(i).getIntNumber();
			String reason = productDAO.selectReason(no);	//회수 사유 찾기
			item.get(i).setStrReason(reason);
			/*
			int userNo = item.get(i).getIntUserNo();		//회원 이름 찾기
			String name = productDAO.selectUserName(userNo);
			item.get(i).setStrUserName(name);*/
		}
		return item;
		
		
	}

	//구매한 아이템 정보 가져오기
	@Override
	public ItemShopInfo selectPurchaseItem(BigInteger purchaseNo) {
		ItemShopInfo item = productDAO.selectPurchaseItem(purchaseNo);
		int itemPrice = item.getIntItemPrice();
		int count = item.getItemCount();
		
		int itemTotal = itemPrice * count;
		item.setIntMiddlePrice(itemTotal);
		
		return item;
	}

	//아이템 번호로 아이템 정보 가져오기
	@Override
	public ItemShopInfo selectItemInfo(int intItemNo) {
		ItemShopInfo item = productDAO.selectItemInfo(intItemNo);
		
		if(item.getIntItemPrice() > 50000) {
			item.setIntDeliveryPrice(0);
		}
		else {
			item.setIntDeliveryPrice(3000);
		}
		
		return item;
	}

	//배송정보 가져오기
	@Override
	public ItemShopInfo selectDeliveryInfo(BigInteger purchaseNo) {
		return productDAO.selectDeliveryInfo(purchaseNo);
	}

	//택배회사 정보 가져오기
	@Override
	public List<ItemShopInfo> selectCompany() {
		return productDAO.selectCompany();
	}

	//송장번호 insert
	@Override
	public void insertDeliveryInvoice(ItemShopInfo item) {
		productDAO.insertDeliveryInvoice(item);	//송장번호 insert
		item.setIntFlag(2);
		productDAO.updateProductFlag(item);	//배송상태 update
	}

	//택배회사 url 찾기
	@Override
	public String selectCompanyUrl(int code) {
		return productDAO.selectCompanyUrl(code);
	}

	//invoice와 code 찾기
	@Override
	public ItemShopInfo selectInvoice(BigInteger purchaseNo) {
		return productDAO.selectInvoice(purchaseNo);
	}

	//회원의 상품 구매 리스트 불러오기
	@Override
	public List<ItemShopInfo> selectMemberProductList(int userNo) {		
		List<ItemShopInfo> item = productDAO.selectMemberProductList(userNo);
		for(int i=0; i<item.size();i++) {
			BigInteger no = item.get(i).getIntNumber();
			String reason = productDAO.selectReason(no);	//회수 사유 찾기
			item.get(i).setStrReason(reason);
			/*
			int userNo = item.get(i).getIntUserNo();		//회원 이름 찾기
			String name = productDAO.selectUserName(userNo);
			item.get(i).setStrUserName(name);*/
		}
		return item;
		
		
	}

	//아이디 찾기
	@Override
	public String selectUserId(int userNo) {
		return productDAO.selectUserId(userNo);
	}

	//상품번호 중복체크
	@Override
	public int selectCheckItemNo(int itemNo) {
		String name = productDAO.selectCheckItemNo(itemNo);
		
		int check;
		if(name != null) {
			check = 1; //중복
		}
		else {
			check = 0;
		}
		return check;
	}
	
}
