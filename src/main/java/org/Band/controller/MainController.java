package org.Band.controller;


import javax.servlet.http.HttpSession;

import org.Band.controller.MainController;
import org.Band.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
	@Autowired
	UserService us;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	// 접근제어자 반환타입 메서드명(매개변수, 매개변수)
	public String home(Model model, HttpSession session) {
		String ID="";
		/*UserVO user = (UserVO) session.getAttribute("login");
		String ID = user.getID();*/
		model.addAttribute("bestlist", us.bests(ID));
		return "main";
	}
}
