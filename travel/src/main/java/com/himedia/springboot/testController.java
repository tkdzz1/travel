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
	
	@GetMapping("/mypage")
	public String myPage(HttpServletRequest req, Model model) {
		HttpSession s = req.getSession();
		
		String id = (String)s.getAttribute("id");
		
		ArrayList<homeDTO> pList = hDao.getPlanList(id);
		model.addAttribute("pList", pList);
		
		cnt(id, model);
		
		return "member/mypage";
	}

	@GetMapping("/myreview")
	public String myReview(HttpServletRequest req, Model model) {
		HttpSession s = req.getSession();
		String id = (String) s.getAttribute("id");
		
		ArrayList<reviewDTO> getReview = hDao.getReviewListToMyPage(id);
		
		model.addAttribute("review", getReview);
		
		cnt(id, model);
		
		return "member/my_review";
	}
	@GetMapping("/mylike")
	public String myLike(HttpServletRequest req, Model model) {
		HttpSession s = req.getSession();
		
		String id = (String)s.getAttribute("id");
		
		ArrayList<travel_attDTO> cart = hDao.getCList(id);
		
		model.addAttribute("cart", cart);
		
		cnt(id, model);
		
		return "member/my_like";
	}
	@GetMapping("/mybbs")
	public String myBbs(HttpServletRequest req, Model model) {
		HttpSession s= req.getSession();
		String id = (String) s.getAttribute("id");

		ArrayList<BoardDTO> alBoard = bdao.getprof(id);
		model.addAttribute("blist",alBoard);
		model.addAttribute("imp",id);
		
		cnt(id, model);
		
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
	
	public void cnt(String id, Model model) {
		int countPlan = hDao.cntPlanList(id);
		int countBbs = hDao.cntBbs(id);
		int countReview = hDao.cntReview(id);
		int countCart = hDao.cntCart(id);
		
		model.addAttribute("cnt1", countPlan);
		model.addAttribute("cnt2", countBbs);
		model.addAttribute("cnt3", countReview);
		model.addAttribute("cnt4", countCart);
	}
}	
