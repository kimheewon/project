package com.interntraining.admin.product.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.product.dao.ProductDAO;
import com.interntraining.admin.product.domain.ProductInfo;

@Service
public class ProductServiceImpl implements ProductService{

	@Resource(name = "ProductDAO")
	private ProductDAO productDAO;
	
	@Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;

	//상품 DB에 저장
	@Override
	public void insertProduct(ProductInfo productInfo) {
		productDAO.insertProduct(productInfo);		
	}

	//DB에서 모든 상품 리스트 가져오기
	@Override
	public List<ProductInfo> seletAllList() {
		return productDAO.seletAllList();
	}

	//수정한 관리자 이름 가져오기
	@Override
	public String selectAdminName(int updateNo) {
		return productDAO.selectAdminName(updateNo);
	}

	//상품 삭제
	@Override
	public void deleteProduct(int itemNo) {
		productDAO.deleteProduct(itemNo);
	}
	
}
