package com.interntraining.member.itemShop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.product.domain.ProductInfo;

@Repository("itemShopDAO")
public class ItemShopDAO {

	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;

	//아이템 전체 목록
	public List<ProductInfo> selectAllItemList() {
		return sqlSession.selectList("productSql.selectAllItemList");
	}
}

