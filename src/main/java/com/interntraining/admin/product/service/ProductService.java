package com.interntraining.admin.product.service;

import java.util.List;

import com.interntraining.admin.product.domain.ProductInfo;

public interface ProductService {

	//상품 DB에 저장
	public void insertProduct(ProductInfo productInfo);

	//DB에서 모든 상품 리스트 가져오기
	public List<ProductInfo> seletAllList();

	//수정한 관리자 이름 가져오기
	public String selectAdminName(int updateNo);

	//상품 삭제
	public void deleteProduct(int itemNo);

}
