package com.contoso.payroll;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping(value = "/")
	public String index() {
		return "index";
	}


	@RequestMapping(value = "/metric")
	public String prometheus() {
		return "test";
	}

}