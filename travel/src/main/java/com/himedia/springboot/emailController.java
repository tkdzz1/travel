package com.himedia.springboot;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    
	@Autowired
	private travel_attDAO tDao;
    
	@Autowired
	private homeDAO hDao;
	
	@Value("${cos.key}")
	private String cosKey;
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest req) {
		HttpSession s = req.getSession();
		String id = (String) s.getAttribute("id");
		String pw = mDao.socialCheck(id);
		if ( pw.equals(cosKey) ) {
			s.invalidate();
			return "redirect:https://kauth.kakao.com/oauth/logout?client_id=7fb612febcabd2e33c624c45cf59cfd5&logout_redirect_uri=http://localhost:8080/";
		}
		s.invalidate();
		
		return "redirect:/";
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
		
		return email;
	}
	
	@PostMapping("/login")
	@ResponseBody
	public String login(@RequestParam String email, @RequestParam String pw,
			HttpServletRequest req) {
		int check = mDao.login(email, pw);
		
		if ( check == 1 ) {
			HttpSession s = req.getSession();
			s.setAttribute("id", email);
		}
		
		return String.valueOf(check);
	}
	
	@GetMapping("/my_jeju_travel")
	public String myJejuTravel(HttpServletRequest req, Model model) {
		HttpSession s = req.getSession();
		String id = (String) s.getAttribute("id");
		
		ArrayList<travel_attDTO> tList = hDao.getLikeList(id);
		
		if ( tList.size() == 0 ) {
			model.addAttribute("tList", "empty");
			return "my_jeju_travel/my_jeju_travel";
		}
		
		model.addAttribute("tList", tList);
		
		return "my_jeju_travel/my_jeju_travel";
	}
	
	@GetMapping("/food_store")
	public String flist(HttpServletRequest req,Model model) {
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=tDao.cntTravelList("음식");
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/food_store?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		ArrayList<travel_attDTO> getlist = tDao.getList(start,psize,"음식");
		model.addAttribute("list", getlist);	
		return "travel_attraction/travel_list";
	}
	
	@GetMapping("/stay")
	public String slist(HttpServletRequest req,Model model) {
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=tDao.cntTravelList("숙박");
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/stay?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		ArrayList<travel_attDTO> getlist = tDao.getList(start,psize,"숙박");
		model.addAttribute("list", getlist);	
		return "travel_attraction/travel_list";
	}
	
	@GetMapping("/shopping")
	public String shoplist(HttpServletRequest req,Model model) {
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=tDao.cntTravelList("쇼핑");
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/shopping?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		ArrayList<travel_attDTO> getlist = tDao.getList(start,psize,"쇼핑");
		model.addAttribute("list", getlist);	
		return "travel_attraction/travel_list";
	}
}
