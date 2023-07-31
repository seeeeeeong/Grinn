package kr.spring.fleaMarket.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.fleaMarket.service.MarketService;
import kr.spring.fleaMarket.vo.MarketVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MarketController {
	
	@Autowired
	private MarketService marketService;
	
	// ===자바빈 초기화===
	@ModelAttribute
	public MarketVO initCommand() {
		return new MarketVO();
	}
	
	// ===플리마켓 예약 선택===
	@RequestMapping("/fleaMarket/marketSelect.do")
	public ModelAndView getList() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("marketSelect");
		
		return mav;
	}
	
}
