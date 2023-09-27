package com.himedia.springboot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class testController {

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
	@GetMapping("/mypage")
	public String myPage() {
		return "member/mypage";
	}
	@GetMapping("/myreview")
	public String myReview() {
		return "member/my_review";
	}
	@GetMapping("/mylike")
	public String myLike() {
		return "member/my_like";
	}
	@GetMapping("/mybbs")
	public String myBbs() {
		return "member/my_bbs";
	}
	@GetMapping("/header2")
	public String header2() {
		return "member/header2";
	
	}
}	
