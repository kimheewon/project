package com.interntraining.member.itemShop.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.board.domain.Pagination;
import com.interntraining.member.itemShop.dao.ItemShopDAO;
import com.interntraining.member.itemShop.domain.PaginationItem;

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
}

