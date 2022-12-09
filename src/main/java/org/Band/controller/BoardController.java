package org.Band.controller;



import org.Band.model.BoardVO;
import org.Band.model.CriteriaVO;
import org.Band.model.PagingVO;
import org.Band.service.BoardService;
import org.Band.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	BoardService bs;
	@Autowired
	CommentService cs;
	
	// 湲� 紐⑸줉
	@GetMapping("/list")
	public void ListPage(Model model, CriteriaVO cri) {
		//System.out.println("荑좊씪�씠..."+cri);
		model.addAttribute("list", bs.ListPage(cri));
		int total = bs.getTotal(cri);
		model.addAttribute("bgno", cri.getBgno());
		model.addAttribute("pagemake", new PagingVO(cri, total));
	}
	// 湲� �옉�꽦(�럹�씠吏� �씠�룞)
	@GetMapping("/write")
	public void writepage(@ModelAttribute("cri") CriteriaVO cri) {}
	@PostMapping("/write")
	public String write(BoardVO board, RedirectAttributes rttr, @ModelAttribute("cri") CriteriaVO cri) {
		System.out.println("write : "+board);
		bs.write(board);
		//rttr.addFlashAttribute("result", board.getBno());
		rttr.addAttribute("bgno", cri.getBgno());
		return "redirect:/board/list?bgno="+cri.getBgno();
	}
	// 湲� 議고쉶
	@Transactional
	@GetMapping("/view")
	public void view(int bno, Model model, CriteriaVO cri, String ID) {
		
		System.out.println("/view"+bno);
		model.addAttribute("viewing", bs.view(bno));
		model.addAttribute("cri", cri);
		
		bs.boardhit(bno);
		bs.cmthit(bno);
	}
	
	// 寃뚯떆湲� 異붿쿇
	@PostMapping("/updateLike")
	@ResponseBody
	public int updateLike(int bno, String ID, String NICK_NAME) {
		int likeCheck = bs.likeCheck(bno, ID);
		
		if(likeCheck == 0) {
			//醫뗭븘�슂
			bs.insertLike(bno, ID);
			bs.updateLike(bno);
			bs.updateLikeCheck(bno, ID);
		}else if(likeCheck == 1) {
			bs.updateLikeCheckCancel(bno, ID);
			bs.updateLikeCancel(bno);
			bs.deleteLike(bno, ID);
		}
		
		return likeCheck;
	}
	// 湲� �닔�젙(�럹�씠吏� �씠�룞) 
	@GetMapping("/modify")
	public void modifypage(int bno, Model model, CriteriaVO cri) {
		model.addAttribute("viewing", bs.view(bno));
		model.addAttribute("cri", cri);
	}
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		bs.modify(board);
		rttr.addFlashAttribute("result", "modify success");
		return "redirect:/board/view?bno="+board.getBno();
	}
	// 湲� �궘�젣
	@PostMapping("/delete")
	public String delete(int bno, RedirectAttributes rttr) {
		bs.delete(bno);
		rttr.addFlashAttribute("result", "delete success");
		return "redirect:/board/list";
	}
	
}
