package com.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

@Controller
public class TestController {

	// http://localhost:9090 => /
	@RequestMapping("/")
	public String home() {
		return "home";	// => WEB-INF/views/home.jsp
	}
	
	@RequestMapping("/test")
	@ResponseBody
	public String test() {
		return "<h2>Hello World~~!</h2>";
	}
}
