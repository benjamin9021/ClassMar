package com.naver.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naver.dto.MemberDTO;
import com.naver.service.TestService;

@Controller
@RequestMapping("aop")
public class TestAOPController {

	@Autowired
	private TestService tservice;
	
	
	@RequestMapping("start")
	public void start() {
		tservice.start();
		
	}
	
	@RequestMapping("end")
	public void end() {
		MemberDTO dto = new MemberDTO("m001","kim",11);
		tservice.end(dto);
	}
	
	
	
}
