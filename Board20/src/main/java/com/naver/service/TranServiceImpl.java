package com.naver.service;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.dto.MsgDTO;
import com.naver.repository.MsgDAO;
import com.naver.repository.User0DAO;

@Service
@Transactional
public class TranServiceImpl implements TranService{
	@Inject
	private User0DAO udao;	
	
	@Autowired
	private MsgDAO mdao;
	
	@Override
	public void insert() {
		MsgDTO mdto = new MsgDTO(4, "m1", "m2");
		mdao.insert(mdto);
		System.out.println(4/0);
		udao.updatePoint(mdto.getSender());
		
	}
	
}
