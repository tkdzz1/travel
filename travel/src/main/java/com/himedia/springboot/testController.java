package com.himedia.springboot;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class testController {
	@Autowired
	private BoardDAO bdao;

	@GetMapping("/weather")
	public String test() {
		return "weather/weather";
	}
	
	@GetMapping("/weather2")
	public String test2() {
		return "weather/weather2";
	}
	
	@GetMapping("/weather3")
	public String test3() {
		return "weather/weather3";
	}
//	@GetMapping("/mypage")
//	public String myPage() {
//		return "member/mypage";
//	}
	@GetMapping("/myreview")
	public String myReview() {
		return "member/my_review";
	}
	@GetMapping("/mylike")
	public String myLike() {
		return "member/my_like";
	}
	@GetMapping("/mybbs")
	public String myBbs(HttpServletRequest req, Model model) {
		HttpSession s= req.getSession();
		String id = (String)s.getAttribute("id");

		ArrayList<BoardDTO> alBoard = bdao.getprof();
		model.addAttribute("blist",alBoard);
		model.addAttribute("imp",id);

		
		
		return "member/my_bbs";
	}
	@GetMapping("/header2")
	public String header2() {
		return "member/header2";
	
	}
}	
