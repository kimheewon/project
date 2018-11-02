package com.interntraining.admin.product.service;

import com.interntraining.admin.product.domain.ProductInfo;

public interface ProductService {

	//상품 DB에 저장
	public void insertProduct(ProductInfo productInfo);

}
