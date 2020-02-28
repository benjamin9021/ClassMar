package com.naver.controller;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.naver.dto.BoardVO;
import com.naver.dto.PageTo;
import com.naver.service.BoardService;
import com.naver.utils.MediaUtils;

@Controller
@RequestMapping("board")
public class BoardController {

	@Autowired
	private BoardService bservice;
	@Resource(name = "uploadPath")
	private String uploadPath;

	@RequestMapping("list")
	public String list(Model model) {

		List<BoardVO> list = bservice.list();

		model.addAttribute("list", list);

		return "board/list";
	}

	@RequestMapping(value = "deletefile/{bno}", method = RequestMethod.POST)
	@ResponseBody
	public String deletefile(@PathVariable("bno") int bno, String filename) {

		bservice.deleteFile(bno,filename);
		
		
		filename = filename.replace('/', File.separatorChar);
		
		String type = filename.substring(filename.lastIndexOf(".")+1);
		if (MediaUtils.getMediaType(type) != null) {
			String prefix =filename.substring(0,12);
			String suffix =filename.substring(14);
			File f0 = new File(uploadPath,prefix+suffix);
			if (f0.exists()) {
				f0.delete();
			}
		}
		return "삭제되었음";
		
	}
	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public String insertui() {

		return "board/insert";
	}

	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insert(Model model, BoardVO vo) {

		bservice.insert(vo);
		return "redirect:/board/listpage";
	}

	@RequestMapping(value = "read/{bno}", method = RequestMethod.GET)
	public String read(@PathVariable("bno") int bno, int curPage, Model model) {

		BoardVO vo = bservice.read(bno);

		model.addAttribute("vo", vo);

		model.addAttribute("curPage", curPage);

		return "board/read";
	}

	@RequestMapping(value = "delete/{bno}/{curPage}", method = RequestMethod.POST)
	public String delete(@PathVariable("bno") int bno, @PathVariable("curPage") int curPage) {

		bservice.delete(bno);

		System.out.println(bno);
		System.out.println(curPage);
		return "redirect:/board/listpage?curPage=" + curPage;
	}

	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateui(int bno, Model model, int curPage) {

		BoardVO vo = bservice.updateui(bno);
		System.out.println(bno);
		model.addAttribute("vo", vo);
		model.addAttribute("curPage", curPage);
		return "board/update";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(Model model, BoardVO vo, @RequestParam("curPage") int curPage) {

		bservice.update(vo);
		return "redirect:/board/listpage?curPage=" + curPage;
	}

	@RequestMapping(value = "listpage", method = RequestMethod.GET)
	public void listpage(Model model, PageTo to) {

		to = bservice.listpage(to);
		// 페이지에대한정보를 받아와서 다시 to 에 amount , total , start , begin , stop 값을 넣는다.

		model.addAttribute("to", to);
	}

}