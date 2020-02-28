package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.dto.BoardVO;
import com.naver.dto.PageTo;
import com.naver.repository.BoardDAO;
import com.naver.repository.ReplyDAO;

@Service
@Transactional
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDAO bdao;
	
	@Autowired
	private ReplyDAO rdao;
	
	@Override
	public List<BoardVO> list() {
		
		return bdao.list();
	}

	@Override
	public void insert(BoardVO vo) {
		
		System.out.println(vo.getBno());
		
		bdao.insert(vo);
		
		System.out.println(vo.getBno());
		
		String[] arr = vo.getFilename();
		
		if (arr != null) {
			for(String filename : arr) {
				bdao.addAttach(filename, vo.getBno());
			}
		}
		
	}

	@Override
	public BoardVO read(int bno) {
		
		bdao.updateReadcnt(bno);
		
		BoardVO vo = bdao.read(bno);
		
		List<String> list = bdao.getAttach(bno);
		
		String[] filename = list.toArray(new String[list.size()]);
		
		for (int i = 0; i < filename.length; i++) {
			System.out.println(filename[i]);
		}
		
		vo.setFilename(filename);
		
		return vo;
	}

	@Override
	public BoardVO updateui(int bno) {
		
		BoardVO vo= bdao.updateui(bno);
		
		List<String> list = bdao.getAttach(bno);
		
		String[] filename = list.toArray(new String[list.size()]);
		
		for (int i = 0; i < filename.length; i++) {
			System.out.println(filename[i]);
		}

		vo.setFilename(filename);
		
		return vo;
	}

	@Override
	public void update(BoardVO vo) {
		bdao.update(vo);
		
		bdao.deleteAllFile(vo.getBno());
		
		String[] arr = vo.getFilename();
		
		if (arr != null) {
			System.out.println(1111);
			System.out.println(1111);
			System.out.println(1111);
			for(String filename : arr) {
				bdao.addAttach(filename, vo.getBno());
			}
		}else {
			System.out.println(2222);
			System.out.println(2222);
		}
		
	}

	@Override
	public void delete(int bno) {
		rdao.deleteByBno(bno);
		bdao.delete(bno);
		
		
	}

	@Override
	public PageTo listpage(PageTo to) {
		
		int amount = bdao.getamount();
		
		to.setAmount(amount);
		
		List<BoardVO> list = bdao.getlistpage(to);
		
		to.setList(list);
		
		return to;
	}

	@Override
	public void deleteFile(int bno, String filename) {
		bdao.deleteFile(bno,filename);
		
		
	}



}
