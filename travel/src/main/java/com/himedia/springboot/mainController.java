package com.himedia.springboot;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class mainController {
	@Autowired
	private travel_attDAO tdao;
	@Autowired
	private foodstoreDAO fdao;
	@Autowired
	private BoardDAO bdao;
	
	
	@GetMapping("/")
	public String home(Model model) {
		ArrayList<travel_attDTO> alemp = tdao.locationName();
		ArrayList<foodstoreDTO> alemp2 = fdao.fsTest();
		
		model.addAttribute("location",alemp);
		model.addAttribute("restaurant",alemp2);
		
		return "home";
	}

	
	
	@GetMapping("/q&a")
public String showqanda(HttpServletRequest req, Model model) {
		
		
		HttpSession session = req.getSession();
		String userid=(String) session.getAttribute("userid");
		if(userid==null || userid.equals("")) {
			
			model.addAttribute("name","");
			
		}else {
			
			model.addAttribute("name",(String) session.getAttribute("username"));
		}
		
		
			
		
		int start,psize,pno;
		String page = req.getParameter("pageno");
		if(page==null||page.equals("")) {
			pno=1;
		} else {
			pno = Integer.parseInt(page);
		}
		
		start = (pno-1)*10;
		psize=10;
		ArrayList<BoardDTO> alBoard = bdao.getList(start, psize);
		
		
		int cnt=bdao.getTotal();
		int pagecount = (int)Math.ceil(cnt/10.0); // pagecount = 3 
		System.out.println("pagecount="+pagecount);
		
	
		String pagestr="";
		for(int i=1; i<=pagecount; i++) { 
			if(pno==i) {
				pagestr +=i+"&nbsp";
			} else {
			pagestr+="<a href='/?pageno="+i+"'>"+i+"</a>&nbsp";
			}
		}
		model.addAttribute("pagestr",pagestr);
		
		

		model.addAttribute("blist",alBoard);
		return "q&a";
	}
	
	
	@GetMapping("/view")
	public String view(HttpServletRequest req, Model model) {
		int seqno = Integer.parseInt(req.getParameter("seqno"));
		BoardDTO bdto = bdao.view(seqno);
		bdao.hitup(seqno);
		model.addAttribute("bpost", bdto);
		return "/view";
	}
	
	
	
	
}