package org.Band.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import org.Band.model.CommentVO;
import org.Band.model.CriteriaVO;
import org.Band.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("comment")
public class CommentController {
	@Autowired
	CommentService cs;
	
	//댓글 작성
	@PostMapping("/new")
	public ResponseEntity<String> cmtInsert(@RequestBody CommentVO cmt) {
		int result = cs.cmtInsert(cmt);
		System.out.println(cmt);
		return result==1?new ResponseEntity<>("success", HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@GetMapping("/{bno}")
	public ResponseEntity<List<CommentVO>> cmtList(@PathVariable int bno){
		return new ResponseEntity<>(cs.cmtList(bno), HttpStatus.OK);
	}
	//댓글 수정 페이지
	@GetMapping("/cmtupdate")
	public void cmtSelect(@RequestParam("bno")int bno, @RequestParam("rno")int rno, Model model, CriteriaVO cri) {
		CommentVO cmt = new CommentVO();
		cmt.setBno(bno);
		cmt.setRno(rno);
		
		CommentVO comment = cs.cmtSelect(cmt);
		model.addAttribute("comment", comment);
		model.addAttribute("cri", cri);
	}
	
	@PostMapping("/cmtupdate")
	public String cmtmodify(CommentVO cmt, CriteriaVO cri) throws UnsupportedEncodingException {
		cs.cmtUpdate(cmt);
		if(cri.getKeyword() == null || cri.getType() == null) {
			return "redirect:/board/view?bno="+cmt.getBno()+"&keyword="+"&type="
			+"&bgno="+cri.getBgno()+"&pageNum="+cri.getPageNum()+"&amount="+cri.getAmount();
		}else {
			String encodekw = URLEncoder.encode(cri.getKeyword(), "UTF-8");
			return "redirect:/board/view?bno="+cmt.getBno()+"&keyword="+encodekw
			+"&type="+cri.getType()+"&bgno="+cri.getBgno()+"&pageNum="+cri.getPageNum()
			+"&amount="+cri.getAmount();
		}
	}
	
	@PostMapping("/remove/{rno}")
	public String cmtdelete(@PathVariable int rno, CriteriaVO cri, CommentVO cmt) throws UnsupportedEncodingException {
		System.out.println(rno+"번 삭제");
		cs.cmtDelete(rno);
		if(cri.getKeyword() == null || cri.getType() == null) {
			return "redirect:/board/view?bno="+cmt.getBno()+"&keyword="+"&type="
			+"&bgno="+cri.getBgno()+"&pageNum="+cri.getPageNum()+"&amount="+cri.getAmount();
		}else {
			String encodekw = URLEncoder.encode(cri.getKeyword(), "UTF-8");
			return "redirect:/board/view?bno="+cmt.getBno()+"&keyword="+encodekw
			+"&type="+cri.getType()+"&bgno="+cri.getBgno()+"&pageNum="+cri.getPageNum()
			+"&amount="+cri.getAmount();
		}
	}
	
	
	@PostMapping("/newest")
	public ResponseEntity<String> minsert(@RequestBody CommentVO cmt) {
		int result = cs.minsert(cmt);
		System.out.println(cmt);
		return result==1?new ResponseEntity<>("success", HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@GetMapping("/list/{m_no}")
	public ResponseEntity<List<CommentVO>> mlist(@PathVariable int m_no){
		System.out.println(m_no);
		return new ResponseEntity<>(cs.mlist(m_no), HttpStatus.OK);
	}
	//댓글 수정 페이지
	@GetMapping("/mupdate")
	public void mSelect(@RequestParam("m_no")int m_no, @RequestParam("rno")int rno, Model model, CriteriaVO cri) {
		CommentVO cmt = new CommentVO();
		cmt.setM_no(m_no);
		cmt.setRno(rno);
		
		CommentVO comment = cs.mSelect(cmt);
		model.addAttribute("comment", comment);
		model.addAttribute("cri", cri);
	}
	@PostMapping("/mupdate")
	public String mmodify(CommentVO cmt, CriteriaVO cri) throws UnsupportedEncodingException {
		cs.cmtUpdate(cmt);
		if(cri.getKeyword() == null || cri.getType() == null) {
			return "redirect:/match/mview?m_no="+cmt.getM_no()+"&keyword="+"&type="
			+"&pageNum="+cri.getPageNum()+"&amount="+cri.getAmount();
		}else {
			String encodekw = URLEncoder.encode(cri.getKeyword(), "UTF-8");
			return "redirect:/match/mview?m_no="+cmt.getM_no()+"&keyword="+encodekw
			+"&type="+cri.getType()+"&pageNum="+cri.getPageNum()+"&amount="+cri.getAmount();
		}
	}
	@PostMapping("/delete/{rno}")
	public String mdelete(@PathVariable int rno, CriteriaVO cri, CommentVO cmt) throws UnsupportedEncodingException {
		System.out.println(rno+"번 삭제");
		cs.cmtDelete(rno);
		if(cri.getKeyword() == null || cri.getType() == null) {
			return "redirect:/match/mview?m_no="+cmt.getM_no()+"&keyword="+"&type="
			+"&pageNum="+cri.getPageNum()+"&amount="+cri.getAmount();
		}else {
			String encodekw = URLEncoder.encode(cri.getKeyword(), "UTF-8");
			return "redirect:/match/mview?m_no="+cmt.getM_no()+"&keyword="+encodekw
			+"&type="+cri.getType()+"&pageNum="+cri.getPageNum()+"&amount="+cri.getAmount();
		}
	}
}
