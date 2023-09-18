package com.himedia.springboot;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class mainController {
	@Autowired
	private travel_attDAO tdao;
	
	@GetMapping("/")
	public String home() {
		return "home";
	}
}
