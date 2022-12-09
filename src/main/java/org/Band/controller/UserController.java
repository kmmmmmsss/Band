package org.Band.controller;


import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.Band.model.ProfileVO;
import org.Band.model.UserVO;
import org.Band.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	UserService us;
	@Autowired
	JavaMailSenderImpl mailSender;
	
	//로그인 페이지
	@GetMapping("/login")
	public void login() {}
	//로그인
	@PostMapping("/loginCheck")
	public String loginCheck(UserVO user, HttpSession session, RedirectAttributes rttr) {
		boolean result = us.loginCheck(user, session);
		if(result) {
			rttr.addFlashAttribute("message", "success");
			return "redirect:/";
		}else{
			rttr.addFlashAttribute("message","fail");
			return "redirect:/user/login";
		}
	}
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		session.invalidate();
		return "redirect:/";
	}
	//회원가입 페이지
	@GetMapping("/signup")
	public void signup() {}
	//회원가입
	@PostMapping("/signupCheck")
	public String signupCheck(UserVO user, RedirectAttributes rttr) {
		us.signup(user);
		return "redirect:/user/login";
	}
	// 공용 프로필
	@GetMapping("/profile")
	public String profile(UserVO user, Model model, HttpSession session, String ID) {
		List<ProfileVO> pvo = us.getInfo(ID);
		List<ProfileVO> lif = us.likeInfo(ID);
		List<ProfileVO> bif = us.bandInfo(ID);
		model.addAttribute("profile", us.profile(user));
		model.addAttribute("getInfo", pvo);
		model.addAttribute("likeInfo", lif);
		model.addAttribute("bandInfo", bif);
		return "/user/profile";
	}
	// 내 정보 편집
	@GetMapping("/proview")
	public void proview(UserVO user, Model model) {
		System.out.println("회원 편집 : "+user);
		model.addAttribute("profile", us.profile(user));
	}
	// 아이디 중복 확인
	@PostMapping("/userIdChk")
	@ResponseBody
	public String userIdChkPost(String ID) {
		int result = us.idCheck(ID);
		System.out.println("ID결괏값 "+result);
		if(result!=0) {
			return "fail"; // 중복된 아이디 값
		}else {
			return "success"; // 중복되지 않은 아이디 값
		}
	}
	// 이메일 중복 확인
	@PostMapping("/userEmChk")
	@ResponseBody
	public String userEmChkPost(String EMAIL) {
		int result = us.emCheck(EMAIL);
		System.out.println("EM결괏값"+result);
		if(result!=0) {
			return "fail";
		}else {
			return "success";
		}
	}
	// 회원정보 수정
	@PostMapping("/userUpdate")
	public String userUpdate(UserVO user) {
		us.userUpdate(user);
		return "redirect:/user/profile?ID="+user.getID();
	}
	// ID찾기 페이지
	@GetMapping("/findID")
	public void findId() {}
	@PostMapping("/findIdCheck")
	@ResponseBody
	public String findIdCheck(@RequestParam("EMAIL") String EMAIL, @RequestParam("NAME") String NAME, UserVO user) {
		System.out.println("이름 = "+NAME);
		System.out.println("메일주소 = "+EMAIL);
		if(us.findId(user) != null) {
			return us.findId(user).getID();
		}else {
			return null;
		}
	}
	// PASSWORD찾기 페이지
	@GetMapping("/findPW")
	public void findPw() {}
	@PostMapping("/findPwCheck")
	@ResponseBody
	public String findPwCheck(@RequestParam("EMAIL") String EMAIL, @RequestParam("ID") String ID, UserVO user) {
		System.out.println("아이디 = "+ID);
		System.out.println("메일주소 = "+EMAIL);
		if(us.findPw(user) != null) {
			return "success";
		}else {
			return null;
		}
	}
	@GetMapping("/draw")
	public void userdrawview() {}
	@PostMapping("/userdraw")
	public String userdraw(UserVO user, RedirectAttributes rttr, HttpSession session) {
		UserVO uservo =  (UserVO) session.getAttribute("login");
		String sePASSWORD = uservo.getPASSWORD();
		String PASSWORD = user.getPASSWORD();
		System.out.println("세션비번"+sePASSWORD);
		System.out.println("비번"+PASSWORD);
		if(!(sePASSWORD.equals(PASSWORD))) {
			rttr.addFlashAttribute("msg", false);
			return "redirect:/user/draw";
		}
		us.userdraw(user);
		session.invalidate();
		return "redirect:/";
	}
	// 비밀번호 발급 이메일 전송
	@Transactional
	@PostMapping("/sendMail")
	public String sendMail(@RequestParam("EMAIL") String EMAIL, @RequestParam("ID") String ID) {
		System.out.println("임시 비밀번호 발급");
		System.out.println("인증 이메일 : "+EMAIL);
		
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
	                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
		String str = "";
		int idx = 0;
		for(int i=0;i<10;i++) {
			idx=(int)(charSet.length*Math.random());
			str+=charSet[idx];
		}
		System.out.println("임시 비밀번호 : "+str);
		String PASSWORD = str;
		
		String setFrom = "bts_kong@naver.com";
		String toMail = EMAIL;
		String title = "BANDo 임시 비밀번호 발급 이메일 입니다.";
		String content = "임시 비밀번호 발급 안내 이메일 입니다.<br><br>"+
						"회원 님의 임시 비밀번호는"+str+" 입니다.<br>"+
						"로그인 후에 비밀번호를 변경해 주세요.";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}
		us.pwUpdate(PASSWORD, EMAIL,ID);
		
		return "redirect:/user/login";
	}
	// 이메일 확인 메일 전송
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheckGET(String EMAIL) {
		System.out.println("이메일 데이터 전송 확인");
		System.out.println("인증 이메일 : "+EMAIL);
		
		Random r = new Random();
		int checknum = r.nextInt(888888)+111111;
		System.out.println("인증번호 : "+checknum);
		
		String setFrom = "bts_kong@naver.com";
		String toMail = EMAIL;
		String title = "BANDo 회원가입 인증 이메일 입니다.";
		String content =
				"BANDo에 방문해 주셔서 감사합니다."+"<br><br>"+
				"인증번호는 "+checknum+" 입니다."+"<br>"+
				"해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}
		String num = Integer.toString(checknum);
		
		return num;
	}
}
