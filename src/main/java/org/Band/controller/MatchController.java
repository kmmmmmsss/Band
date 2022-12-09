package org.Band.controller;


import org.Band.model.BandVO;
import org.Band.model.CriteriaVO;
import org.Band.model.PagingVO;
import org.Band.service.MatchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("match")
public class MatchController {
	@Autowired
	MatchService ms;
	
	@GetMapping("/search")
	public void bandlist(Model model, BandVO band, CriteriaVO cri) {
		model.addAttribute("match", ms.matchList(cri));
		int total = ms.mtotal(cri);
		model.addAttribute("page", new PagingVO(cri, total));
	}
	@GetMapping("/regist")
	public void regist() {}
	@PostMapping(value="/regist", produces="text/plain; charset=UTF-8")
	public String regist(BandVO band, RedirectAttributes rttr) {
		System.out.println("regist:"+band);
		ms.regist(band);
		return "redirect:/match/search";
	}
	@Transactional
	@GetMapping("/mview")
	public void mview(int m_no, Model model, CriteriaVO cri) {
		System.out.println("/mview"+m_no);
		model.addAttribute("mview", ms.mview(m_no));
		model.addAttribute("cri", cri);
	}
	@GetMapping("/update")
	public void modi(int m_no, Model model, CriteriaVO cri) {
		System.out.println("/mmmmmm"+m_no);
		model.addAttribute("mview", ms.mview(m_no));
		model.addAttribute("cri", cri);
	}
	@PostMapping("/update")
	public String mupdate(BandVO band, RedirectAttributes rttr) {
		ms.update(band);
		rttr.addFlashAttribute("result", "modify success");
		System.out.println("/mupdate"+band.getM_no());
		return "redirect:/match/mview?m_no="+band.getM_no();
	}
	@PostMapping("/delee")
	public String delee(int m_no, RedirectAttributes rttr) {
		ms.delee(m_no);
		rttr.addFlashAttribute("result", "delete success");
		return "redirect:/match/search";
	}
}
