package com.interntraining.admin.product.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.interntraining.admin.product.dao.ProductDAO;
import com.interntraining.admin.product.domain.ProductInfo;

@Service()
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
	
}
