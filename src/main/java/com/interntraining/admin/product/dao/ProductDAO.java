package com.interntraining.admin.product.dao;

import java.util.List;

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

	//DB에서 모든 상품 리스트 가져오기
	public List<ProductInfo> seletAllList() {
		return sqlSession.selectList("productSql.seletAllList");
	}

	//수정한 관리자 이름 가져오기
	public String selectAdminName(int updateNo) {
		return sqlSession.selectOne("productSql.selectAdminName",updateNo);
	}

	//상품 삭제
	public void deleteProduct(int itemNo) {
		sqlSession.update("productSql.deleteProduct", itemNo);
	}
}
