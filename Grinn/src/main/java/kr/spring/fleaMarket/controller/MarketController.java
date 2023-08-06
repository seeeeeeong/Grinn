package kr.spring.fleaMarket.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.fleaMarket.service.MarketService;
import kr.spring.fleaMarket.vo.MarketVO;
import kr.spring.util.PagingUtil;
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
	@RequestMapping("/fleamarket/marketSelect.do")
	public ModelAndView getList() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("marketSelect");
		
		return mav;
	}
	
	// ===부스 예약 목록===
	@RequestMapping("/fleamarket/boothList.do")
	public ModelAndView getBoothList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, 
			                         @RequestParam(value="order", defaultValue="1") int order, 
			                         String keyfield, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		// 전체/검색 레코드수
		int count = marketService.selectRowCount(map);
				
		log.debug("<<count>> : " + count);
		
		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 5, "boothList.do", "&order="+order);
		
		List<MarketVO> list = null;
		if (count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = marketService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("boothList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
}
