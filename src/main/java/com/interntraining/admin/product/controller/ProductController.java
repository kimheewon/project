package com.interntraining.admin.product.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
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

@Controller
@RequestMapping(value= "/Product")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	//상품 목록 페이지로 이동
	@RequestMapping(value="/ProductList")
	public ModelAndView ProductList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
		
		List<ProductInfo> product = productService.seletAllList();	//DB에서 모든 상품 리스트 가져오기
		
		for(int i=0; i<product.size(); i++) {
			if(product.get(i).getIntUpdateAdminNo() != 0) {
				int updateNo = product.get(i).getIntUpdateAdminNo();	//수정한 관리자 id
				String updateName = productService.selectAdminName(updateNo);	//수정한 관리자 이름 가져오기
				product.get(i).setStrUpdateAdminName(updateName);
			}
			
			
		}
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
		String fileUrl ="/uploadFiles";	
		
		@SuppressWarnings("deprecation")
		String path = request.getRealPath(fileUrl);		//저장될 위치	
		//String path="/images";
		String fileName = file.getOriginalFilename();	//업로드 파일 이름
		File uploadFile = new File(path+"/"+fileName);	//복사될 위치
		
		file.transferTo(uploadFile);	//업로드
		
		String aa = path+"/"+fileName;
		productInfo.setStrfileName(fileName);
		productInfo.setStrfileUrl(aa);
	       		
        productService.insertProduct(productInfo);		//상품 DB에 저장
		mav.setViewName("/admin/product/ProductEnroll");
		
		
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
	
	//상품 수정
}