package com.interntraining.member.itemShop.service;

import java.util.List;

import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.board.domain.Pagination;
import com.interntraining.member.itemShop.domain.PaginationItem;

public interface ItemShopService {

	//아이템 전체 목록
	public List<ProductInfo> selectAllItemList();

	// 페이징 리스트
	public List<ProductInfo> selectAllItem(PaginationItem pagination);


}
