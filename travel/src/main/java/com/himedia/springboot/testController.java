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
}
