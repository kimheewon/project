package com.interntraining.member.user.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.member.user.domain.Member;
import com.interntraining.member.user.service.UserService;


/*
 * 회원 정보 관리
 * 	- 회원 가입
 * 	- 회원 정보 수정
 * 
 */
@Controller
@RequestMapping(value= "/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	
	//회원가입
	@RequestMapping(value = "/joinForm")
    public String joinForm(){		
        return "/login/join";
    }
	
	//아이디 중복 체크
	@RequestMapping(value = "/joinCheck", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public int idCheck(String id) throws Exception {			
		//DB에서 id 체크
		Member userid = userService.selectId(id);
		int check = 0;
		if(userid != null) {
			check = 1;	//DB에 id 있음
		}	
		
		return check;	
    }

	//회원정보 저장
	@RequestMapping(value = "/joinSave", method=RequestMethod.POST)
	public ModelAndView joinSave( HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
	
	
		String id = request.getParameter("userId");
		String password = request.getParameter("pw1");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String sex = request.getParameter("sex");
		String birth = request.getParameter("birth");
		String postcode = request.getParameter("postcode");
		String address = request.getParameter("address");
		String address2 = request.getParameter("address2");
		
		Member member = new Member();
		member.setStrUserId(id);
		member.setStrUserPw(password);
		member.setStrUserName(name);
		member.setStrUserPhone(phone);
		member.setStrUserEmail(email);
		member.setStrUserSex(sex);
		member.setStrUserBirth(birth);
		member.setStrPostCode(postcode);
		member.setStrAdress(address);
		member.setStrAdress2(address2);
		
		userService.insertMember(member);
		
		
		mav.setViewName("/login/loginForm");
		
		
		return mav;		
	}
	
	
	
		
}
