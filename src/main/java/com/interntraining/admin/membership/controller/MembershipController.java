package com.interntraining.admin.membership.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.interntraining.admin.membership.service.MembershipService;

/*
 * 회원 관리
 * 	- 등록
 * 	- 상세보기
 *  - 수정
 *  
 */

@Controller
@RequestMapping(value= "/Membership")
public class MembershipController {
	@Autowired
	private MembershipService membershipService;

}
