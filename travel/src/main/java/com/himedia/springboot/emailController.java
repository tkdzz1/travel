package com.himedia.springboot;

import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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
	
	int st;
	int ps = 5;
	
	@GetMapping("/my_jeju_travel")
	public String myJejuTravel(HttpServletRequest req, Model model) {
		HttpSession s = req.getSession();
		String id = (String) s.getAttribute("id");
		
		String page = req.getParameter("pageno");
		if(page == null || page.equals("")) {
			page = "1";
		}
		int pageNo = Integer.parseInt(page);
		st = (pageNo - 1) * ps;
		int cnt = hDao.cntCartList(id);
		int pageCount = (int)Math.ceil(cnt / 5.0);
		page = "";
		for(int i=1; i<=pageCount; i++) {
			if(pageNo == i) {
				page += "<a class=strong id=" + i  + ">" + i +"</a>&nbsp;";
			} else {
				page += "<a class=a id=" + i + ">" + i + "</a>&nbsp;";
			}
		}
		model.addAttribute("page",page);
		
		ArrayList<travel_attDTO> tList = hDao.getCartList(st, ps, id);
		
		if ( tList.size() == 0 ) {
			model.addAttribute("tList", "empty");
			return "my_jeju_travel/my_jeju_travel";
		}
		
		model.addAttribute("tList", tList);
		
		return "my_jeju_travel/my_jeju_travel";
	}
	
	@PostMapping("/pageMove")
	@ResponseBody
	public String pageMove(HttpServletRequest req) {
		HttpSession s = req.getSession();
		String id = (String) s.getAttribute("id");
		
		int pageNo = Integer.parseInt(req.getParameter("page"));
		
		st = ( pageNo - 1 ) * ps;
		
		ArrayList<travel_attDTO> tList = hDao.getCartList(st, ps, id);
		
		JSONArray ja = new JSONArray();
		
		for (int i = 0; i < tList.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("ta_num", tList.get(i).getTa_num());
			jo.put("ta_name", tList.get(i).getTa_name());
			jo.put("ta_local", tList.get(i).getTa_local());
			jo.put("ta_img", tList.get(i).getTa_img());
			jo.put("ta_address", tList.get(i).getTa_address());
			jo.put("ta_category", tList.get(i).getTa_category());
			jo.put("ta_latitude", tList.get(i).getTa_latitude());
			jo.put("ta_longitude", tList.get(i).getTa_longitude());
			ja.add(jo);
		}
		return ja.toJSONString();
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
	
	@PostMapping("/getChoice")
	@ResponseBody
	public String getChoice(HttpServletRequest req) {
		int choiceNum = Integer.parseInt(req.getParameter("choice"));
		
		travel_attDTO choice = hDao.getChoice(choiceNum);
		
		JSONArray ja = new JSONArray();
		
		JSONObject jo = new JSONObject();
		jo.put("ta_num", choice.getTa_num());
		jo.put("ta_name", choice.getTa_name());
		jo.put("ta_local", choice.getTa_local());
		jo.put("ta_img", choice.getTa_img());
		jo.put("ta_address", choice.getTa_address());
		jo.put("ta_category", choice.getTa_category());
		jo.put("ta_latitude", choice.getTa_latitude());
		jo.put("ta_longitude", choice.getTa_longitude());
		ja.add(jo);
		
		return ja.toJSONString();
	}
	
	@PostMapping("/getPlanData")
	@ResponseBody
	public String getPlanData(HttpServletRequest req) {
		int num = Integer.parseInt(req.getParameter("ta_num"));
		
		travel_attDTO getMarker = hDao.getMarker(num);
		
		JSONArray ja = new JSONArray();
		
		JSONObject jo = new JSONObject();
		jo.put("ta_name", getMarker.getTa_name());
		jo.put("ta_latitude", getMarker.getTa_latitude());
		jo.put("ta_longitude", getMarker.getTa_longitude());
		ja.add(jo);
			
		return ja.toJSONString();
	}
	
	@PostMapping("/likeFilter")
	@ResponseBody
	public String likeFilter(HttpServletRequest req) {
		HttpSession s = req.getSession();
		
		String id = (String) s.getAttribute("id");
		String filter = req.getParameter("filter");
		
		ArrayList<travel_attDTO> filterList = hDao.getFilterList(id, filter);
		
		JSONArray ja = new JSONArray();
		
		for(int i=0; i<filterList.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("ta_num", filterList.get(i).getTa_num());
			jo.put("ta_name", filterList.get(i).getTa_name());
			jo.put("ta_local", filterList.get(i).getTa_local());
			jo.put("ta_img", filterList.get(i).getTa_img());
			jo.put("ta_address", filterList.get(i).getTa_address());
			jo.put("ta_category", filterList.get(i).getTa_category());
			jo.put("ta_latitude", filterList.get(i).getTa_latitude());
			jo.put("ta_longitude", filterList.get(i).getTa_longitude());
			ja.add(jo);
		}
		
		return ja.toJSONString();
	}
	
}
