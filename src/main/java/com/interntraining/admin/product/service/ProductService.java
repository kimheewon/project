package com.interntraining.admin.product.service;

import java.math.BigInteger;
import java.util.List;

import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.itemShop.domain.ItemShopInfo;

public interface ProductService {

	//상품 DB에 저장
	public void insertProduct(ProductInfo productInfo);

	//DB에서 모든 상품 리스트 가져오기
	public List<ProductInfo> seletAllList();

	//수정한 관리자 이름 가져오기
	public String selectAdminName(int updateNo);

	//상품 삭제
	public void deleteProduct(int itemNo);

	//상품 불러오기
	public ProductInfo selectProduct(int itemNo);

	//상품 DB에 업데이트(이미지변경)
	public void updateProductImg(ProductInfo product);

	//상품 DB에 업데이트
	public void updateProduct(ProductInfo product);

	//상품 구매 리스트 불러오기
	public List<ItemShopInfo> selectProductList();

	//구매한 아이템 정보 가져오기
	public ItemShopInfo selectPurchaseItem(BigInteger purchaseNo);

	public ItemShopInfo selectItemInfo(int intItemNo);

	//배송정보 가져오기
	public ItemShopInfo selectDeliveryInfo(BigInteger purchaseNo);

}
