package com.naver.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naver.service.TranService;

@Controller
public class TestTranContoller {

	@Autowired
	private TranService tservice;
	
	
	@RequestMapping("tran/insert")
	public void insert() {
		
		tservice.insert();
		
	}
	
	
	
	
}
