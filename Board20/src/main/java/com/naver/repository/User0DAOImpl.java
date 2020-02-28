package com.naver.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class User0DAOImpl implements User0DAO{

	@Autowired
	private SqlSession session;
	
	private final String NS = "com.naver.msg";
	
	@Override
	public void updatePoint(String sender) {
		session.update(NS+".updatePoint", sender);
		
	}

	
	
}
