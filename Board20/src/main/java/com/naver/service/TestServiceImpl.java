package com.naver.service;

import org.springframework.stereotype.Service;

import com.naver.dto.MemberDTO;

@Service
public class TestServiceImpl implements TestService{

	@Override
	public void start() {
		
		System.out.println("�̹��� ���� �����մϴ�.");
		
	}

	@Override
	public void end(MemberDTO dto) {
		System.out.println("ȸ���� ����մϴ�.");
		
		
	}

	
}
