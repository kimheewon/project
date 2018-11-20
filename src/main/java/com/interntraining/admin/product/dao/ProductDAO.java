package com.interntraining.admin.product.dao;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.member.itemShop.domain.ItemShopInfo;

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

	//상품 불러오기
	public ProductInfo selectProduct(int itemNo) {
		return sqlSession.selectOne("productSql.selectProduct", itemNo);
	}

	//상품 DB에 저장(이미지변경)
	public void updateProductImg(ProductInfo product) {
		sqlSession.update("productSql.updateProductImg", product);
	}

	//상품 DB에 업데이트
	public void updateProduct(ProductInfo product) {
		sqlSession.update("productSql.updateProduct", product);
	}

	//상품 구매 리스트 불러오기
	public List<ItemShopInfo> selectProductList() {
		return sqlSession.selectList("productSql.selectProductList");
	}

	//구매한 아이템 정보 가져오기
	public ItemShopInfo selectPurchaseItem(BigInteger purchaseNo) {
		return sqlSession.selectOne("itemSql.selectPurchaseItem", purchaseNo);
	}

	//아이템 번호로 아이템 정보 가져오기	
	public ItemShopInfo selectItemInfo(int itemNo) {
		return sqlSession.selectOne("productSql.selectItemInfo", itemNo);
	}

	//배송정보 가져오기
	public ItemShopInfo selectDeliveryInfo(BigInteger purchaseNo) {
		return sqlSession.selectOne("itemSql.selectDeliveryInfo", purchaseNo);
	}

	//회수 사유 찾기
	public String selectReason(BigInteger no) {
		return sqlSession.selectOne("productSql.selectReason", no);
	}

	//회원 이름 찾기
	public String selectUserName(int userNo) {
		return sqlSession.selectOne("userSql.selectUserName", userNo);
	}

	//택배회사 정보 가져오기
	public List<ItemShopInfo> selectCompany() {
		return sqlSession.selectList("itemSql.selectCompany");
	}

	//송장번호 insert
	public void insertDeliveryInvoice(ItemShopInfo item) {
		sqlSession.update("productSql.insertDeliveryInvoice", item);
	}

	//배송상태 update
	public void updateProductFlag(ItemShopInfo item) {
		sqlSession.update("productSql.updateProductFlag", item);
	}

	//택배회사 url 찾기
	public String selectCompanyUrl(int code) {
		return sqlSession.selectOne("productSql.selectCompanyUrl", code);
	}

	//invoice와 code 찾기
	public ItemShopInfo selectInvoice(BigInteger purchaseNo) {
		return sqlSession.selectOne("productSql.selectInvoice", purchaseNo);
	}
}
