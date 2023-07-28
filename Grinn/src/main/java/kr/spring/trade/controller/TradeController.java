package kr.spring.trade.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.sbid.vo.SaleSizePriceVO;
import kr.spring.trade.service.TradeService;
import kr.spring.trade.vo.TradeVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TradeController {
	@Autowired
	TradeService tradeService;
	
	/**
	 * ======================================================================================================================
	 * 												자바 빈 초기화
	 * ======================================================================================================================
	 **/
	@ModelAttribute
	public TradeVO initCommand() {
		return new TradeVO();
	}
	
	/**
	 * ======================================================================================================================
	 * 								구매하기 버튼 클릭 시 상품에 따른 사이즈 정보 제공
	 * ======================================================================================================================
	 **/
	@GetMapping("/purchase/selectSize.do")
	public ModelAndView getItemAndSize(@RequestParam int item_num) {
		// 사이즈 별 판매 입찰 정보를 뿌리기
		List<SaleSizePriceVO> sspList = tradeService.selectSaleSizePrice(item_num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("selectSize");
		mav.addObject("list",sspList);
		return mav;
	}
	
	
	
}
