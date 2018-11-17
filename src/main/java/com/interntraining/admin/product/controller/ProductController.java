package com.interntraining.admin.product.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.product.domain.ProductInfo;
import com.interntraining.admin.product.service.ProductService;
import com.interntraining.member.itemShop.domain.ItemShopInfo;

@Controller
@RequestMapping(value= "/Product")
public class ProductController {

	@Value("${img.upload.path}")
	String strfileOriName;
	
	@Value("${img.upload.virtualpath}")
	String strVirtalfileUrl;
	
	@Autowired
	private ProductService productService;
	
	//상품 목록 페이지로 이동
	@RequestMapping(value="/ProductList")
	public ModelAndView ProductList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<ProductInfo> product = productService.seletAllList();	//DB에서 모든 상품 리스트 가져오기
				
		mav.addObject("product", product);
		mav.setViewName("/admin/product/ProductList");
		
		
		return mav;
	}
	
	//상품등록 페이지로 이동
	@RequestMapping(value="/ProductEnrollForm")
	public ModelAndView productEnrollForm(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		mav.setViewName("/admin/product/ProductEnroll");
		return mav;
	}
	
	//상품등록
	@RequestMapping(value="/ProductEnroll")	
	public ModelAndView productEnroll(ProductInfo productInfo,MultipartHttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		int adminNo = (int) session.getAttribute("AdminNo");
		productInfo.setIntAdminNo(adminNo);
		
		MultipartFile file = request.getFile("file");	//업로드 파라미터
		
		String fileName = file.getOriginalFilename();	//업로드 파일 이름
		
		String strOrifileUrl = strfileOriName+"/"+fileName;
		String strVirfileUrl = strVirtalfileUrl+"/"+fileName;
		File uploadFile = new File(strOrifileUrl);	//복사될 위치
		
		file.transferTo(uploadFile);	//업로드
		
		productInfo.setStrfileName(fileName);
		productInfo.setStrfileOriName(strOrifileUrl);
	    productInfo.setStrfileUrl(strVirfileUrl); 		
        productService.insertProduct(productInfo);		//상품 DB에 저장
		mav.setViewName("redirect:/Product/ProductList");
		
		return mav;
	}
	
	
	//상품 삭제
	@RequestMapping(value="/ProductDelete")
	public ModelAndView productDelete(int itemNo,HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		productService.deleteProduct(itemNo);	//상품 삭제
		mav.setViewName("redirect:/Product/ProductList");				
		return mav;
	}
	
	//상품 수정 페이지로 이동
	@RequestMapping(value="ProductUpdateForm")
	public ModelAndView productUpdateForm(int itemNo,HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		ProductInfo product = productService.selectProduct(itemNo);	//상품 불러오기
				
		mav.addObject("product", product);
		mav.setViewName("/admin/product/ProductUpdate");
		return mav;
	}
	
	//상품 수정
	@RequestMapping(value="ProductUpdate")
	public ModelAndView productUpdate(ProductInfo product,MultipartHttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		int adminNo = (int) session.getAttribute("AdminNo");
		product.setIntAdminNo(adminNo);
		
		//MultipartFile file = request.getFile("file");	//업로드 파라미터	
		if(!product.getFile().isEmpty()) {	//이미지 수정
			MultipartFile file = product.getFile();
			
			String fileName = file.getOriginalFilename();	//업로드 파일 이름				
			String strOrifileUrl = strfileOriName+"/"+fileName;
			String strVirfileUrl = strVirtalfileUrl+"/"+fileName;			
			
			File uploadFile = new File(strOrifileUrl);	//복사될 위치
			
			file.transferTo(uploadFile);	//업로드
			
			product.setStrfileName(fileName);
			product.setStrfileOriName(strOrifileUrl);
			product.setStrfileUrl(strVirfileUrl); 
			
			productService.updateProductImg(product);		//상품 DB에 업데이트(이미지변경)
		}
		else {	//이미지 변경 안함
			productService.updateProduct(product);		//상품 DB에 업데이트
		}
		
		mav.setViewName("redirect:/Product/ProductList");
		return mav;
	}
	
	//상품 구매 리스트
	@RequestMapping(value="PurchaseList")
	public ModelAndView purchaseList() {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<ItemShopInfo> product = productService.selectProductList();			//상품 구매 리스트 불러오기
		
		mav.addObject("product", product);
		mav.setViewName("/admin/product/ProductPurchaseList");
		return mav;
	}
	
	//상품 구매내역 상세보기
	@RequestMapping(value="PurchaseView")
	public ModelAndView purchaseView(BigInteger PurchaseNo) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		ItemShopInfo item = productService.selectPurchaseItem(PurchaseNo);		//구매한 아이템 정보 가져오기
		ItemShopInfo itemInfo = productService.selectItemInfo(item.getIntItemNo());
		ItemShopInfo deliver = productService.selectDeliveryInfo(PurchaseNo);		//배송정보 가져오기
		
		mav.addObject("PurchaseNo", PurchaseNo);
		mav.addObject("item", item);
		mav.addObject("itemInfo", itemInfo);
		mav.addObject("deliver", deliver);

		mav.setViewName("/admin/product/ProductPurchaseView");
		return mav;
	}
}
