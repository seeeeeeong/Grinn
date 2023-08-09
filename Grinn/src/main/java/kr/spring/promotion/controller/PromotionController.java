package kr.spring.promotion.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.spring.promotion.service.PromotionService;
import kr.spring.promotion.vo.PromotionVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PromotionController {
	@Autowired
	private PromotionService promotionService;
	
	@ModelAttribute
	public PromotionVO initCommand() {
		return new PromotionVO();
	}
	
	// ===프로모션 등록===
	@GetMapping("/promotion/adminWrite.do")
	public String form() {
		return "adminWrite";
	}
}
