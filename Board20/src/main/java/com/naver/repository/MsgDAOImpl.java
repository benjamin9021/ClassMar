package com.naver.repository;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.naver.dto.MsgDTO;

@Repository
public class MsgDAOImpl implements MsgDAO{

	@Inject
	private SqlSession session;
	
	private final String NS = "com.naver.msg";
	
	@Override
	public void insert(MsgDTO mdto) {
		session.insert(NS+".insert", mdto);
	}

	
}
