package com.interntraining.member.itemShop.service;

import java.util.List;

import com.interntraining.admin.product.domain.ProductInfo;

public interface ItemShopService {

	//아이템 전체 목록
	public List<ProductInfo> selectAllItemList();


}
