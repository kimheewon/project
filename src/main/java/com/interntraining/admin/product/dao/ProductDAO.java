package com.interntraining.admin.product.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.product.domain.ProductInfo;

@Repository("ProductDAO")
public class ProductDAO {

	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;

	//상품 DB에 저장
	public void insertProduct(ProductInfo productInfo) {
		sqlSession.insert("productSql.insertProduct", productInfo);
	}
}
