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
	
	@Autowired
	private homeDAO hDao;

	@GetMapping("/myreview")
	public String myReview(HttpServletRequest req, Model model) {
		HttpSession s = req.getSession();
		String id = (String) s.getAttribute("id");
		
		ArrayList<reviewDTO> getReview = hDao.getReviewListToMyPage(id);
		
		model.addAttribute("review", getReview);
		
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

	@GetMapping("/edit")
	public String edit() {
		return "edit";
	}
	
	@GetMapping("/secession")
	public String secession(HttpServletRequest req) {
		HttpSession s = req.getSession();
		String id = (String) s.getAttribute("id");
		
		hDao.secession(id);
		s.invalidate();
		
		return "redirect:/";
		
	}
}	
