package com.naver.service;

import org.springframework.stereotype.Service;

import com.naver.dto.MemberDTO;

@Service
public class TestServiceImpl implements TestService{

	@Override
	public void start() {
		
		System.out.println("이미지 파일 복사합니다.");
		
	}

	@Override
	public void end(MemberDTO dto) {
		System.out.println("회원을 등록합니다.");
		
		
	}

	
}
