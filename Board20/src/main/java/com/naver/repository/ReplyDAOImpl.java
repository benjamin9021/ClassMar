package com.naver.repository;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.naver.dto.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{

	@Inject
	private SqlSession session;
	private final String NS = "com.naver.reply";
	
	
	@Override
	public void insert(ReplyVO vo) {
		session.insert(NS+".insert",vo); 
	}


	@Override
	public List<ReplyVO> list(Integer bno) {
		// TODO Auto-generated method stub
		return session.selectList(NS+".list",bno);
	}


	@Override
	public void delete(int rno) {
		session.delete(NS+".delete",rno);
	}


	@Override
	public void update(ReplyVO vo) {
		session.update(NS+".update", vo);
		
	}


	@Override
	public void deleteByBno(int bno) {
		session.delete(NS+".deleteByBno", bno);
	}
	
	
	
}
