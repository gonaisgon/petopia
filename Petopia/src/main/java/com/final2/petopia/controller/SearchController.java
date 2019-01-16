package com.final2.petopia.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SearchController {
	
	@RequestMapping(value="/search.pet", method= {RequestMethod.GET})
	public String search(HttpServletRequest req) {
		
		String searchWord = req.getParameter("searchWord");
		// System.out.println("searchWord : "+searchWord);
		
		req.setAttribute("searchWord", searchWord);
		
		return "search/index.tiles2";
		
	}
	
	
}
