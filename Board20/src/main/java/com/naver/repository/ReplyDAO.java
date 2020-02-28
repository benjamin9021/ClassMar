package com.naver.repository;

import java.util.List;

import com.naver.dto.ReplyVO;

public interface ReplyDAO {
	
	public abstract void insert(ReplyVO vo);

	public abstract List<ReplyVO> list(Integer bno);

	public abstract void delete(int rno);

	public abstract void update(ReplyVO vo);

	public abstract void deleteByBno(int bno);
	
}
