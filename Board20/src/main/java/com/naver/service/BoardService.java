package com.naver.service;

import java.util.List;

import com.naver.dto.BoardVO;
import com.naver.dto.PageTo;

public interface BoardService {

	public abstract List<BoardVO> list();

	public abstract void insert(BoardVO vo);

	public abstract BoardVO read(int bno);

	public abstract BoardVO updateui(int bno);

	public abstract void update(BoardVO vo);

	public abstract void delete(int bno);

	public abstract PageTo listpage(PageTo to);

	public abstract void deleteFile(int bno, String filename);

}
