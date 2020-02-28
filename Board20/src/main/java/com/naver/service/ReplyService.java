package com.naver.service;

import java.util.List;

import com.naver.dto.ReplyVO;

public interface ReplyService {
	
	public abstract void insert(ReplyVO vo);

	public abstract List<ReplyVO> list(Integer bno);

	public abstract void delete(int rno);

	public abstract void update(ReplyVO vo);

	
}
