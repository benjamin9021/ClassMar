package com.naver.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.naver.dto.ReplyVO;
import com.naver.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {

	@Inject 
	private ReplyService rservice;
	
	@RequestMapping( method = RequestMethod.PUT)
	public String update(@RequestBody ReplyVO vo) {
		rservice.update(vo);
		return "update success";
		
	}
	
	@RequestMapping(value = "{rno}",method = RequestMethod.DELETE)
	public String delete(@PathVariable int rno) {
		rservice.delete(rno);
		return "success delete";
		
	}
	
	@RequestMapping(value = "" , method = RequestMethod.POST)
	public void insert(@RequestBody ReplyVO vo) {
		
		rservice.insert(vo);
		System.out.println(vo);
	}
	
	@RequestMapping(value = "{bno}", method = RequestMethod.GET)
	public List<ReplyVO> list(@PathVariable Integer bno) {
		
		List<ReplyVO> list = rservice.list(bno);
//		List<ReplyVO> list = new ArrayList<ReplyVO>();
//		list.add(new ReplyVO(1, 12,"rt1","rr1","2020-02-21","2020-02-21"));
//		list.add(new ReplyVO(2, 12,"rt2","rr2","2020-02-21","2020-02-21"));
//		list.add(new ReplyVO(3, 12,"rt3","rr3","2020-02-21","2020-02-21"));
//		
		return list;
	}

}

