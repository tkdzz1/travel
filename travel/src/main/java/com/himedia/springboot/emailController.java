package com.himedia.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class emailController {
    @Autowired
    private EmailService emailService;
    
    @Autowired
    private memberDAO mDao;
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@PostMapping("/emailConfirm")
	@ResponseBody
	public String emailConfirm(@RequestParam String email) throws Exception {
	  int check = mDao.memberCheck(email);
	  if( check == 1 ) {
		  return String.valueOf(check);
	  }
		
	  String confirm = emailService.sendSimpleMessage(email);

	  return confirm;
	}
	
	@PostMapping("/signUp")
	@ResponseBody
	public String signup(@RequestParam String email, @RequestParam String password,
		HttpServletRequest req) {
		
		mDao.signup(email, password);
		HttpSession s = req.getSession();
		s.setAttribute("id", email);
		
		return email;
	}
	
	@PostMapping("/login")
	@ResponseBody
	public String login(@RequestParam String email, @RequestParam String pw,
			HttpServletRequest req) {
		int check = mDao.login(email, pw);
		HttpSession s = req.getSession();
		s.setAttribute("id", email);
		
		return String.valueOf(check);
	}
}
