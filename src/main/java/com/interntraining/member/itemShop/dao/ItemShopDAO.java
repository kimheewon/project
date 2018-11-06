package com.interntraining.member.itemShop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.board.domain.Pagination;
import com.interntraining.member.itemShop.domain.PaginationItem;

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
}

