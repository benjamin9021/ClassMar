package com.naver.repository;

import java.util.List;

import com.naver.dto.BoardVO;
import com.naver.dto.PageTo;

public interface BoardDAO {

	public abstract List<BoardVO> list();

	public abstract void insert(BoardVO vo);

	public abstract BoardVO read(int bno);

	public abstract void updateReadcnt(int bno);

	public abstract BoardVO updateui(int bno);

	public abstract void update(BoardVO vo);

	public abstract void delete(int bno);

	public abstract int getamount();

	public abstract List<BoardVO> getlistpage(PageTo to);

	public abstract void addAttach(String filename, int bno);
	
	public abstract List<String> getAttach(int bno);

	public abstract void deleteFile(int bno, String filename);

	public abstract void deleteAllFile(int bno);
	
	
	
}
