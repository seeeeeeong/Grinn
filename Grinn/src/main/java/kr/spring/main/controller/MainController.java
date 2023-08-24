package kr.spring.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.promotion.service.PromotionService;
import kr.spring.promotion.vo.PromotionVO;
import kr.spring.trade.service.TradeService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private ItemService itemService;
	@Autowired
	private TradeService tradeService;
	@Autowired
	private PromotionService promotionService;
	
	@RequestMapping("/")
	public String main() {
		return "redirect:/main/main.do";
	}
	
	@RequestMapping("/main/main.do")
	public String main(@RequestParam(value="item_gender", defaultValue="0") int item_gender, Model model) {
		
		// 메인페이지 - 카테고리 선택 시 동작
		if(item_gender > 0) { // 메인 - 헤더에서 카테고리 선택 시 동작
			List<ItemVO> itemGenderList = tradeService.mainGetItemListForRecommend(item_gender);
			List<ItemVO> itemGenderShoesList = tradeService.mainGetItemListForGenderCateRecommend(item_gender, 1);
			List<ItemVO> itemGenderShirtsList = tradeService.mainGetItemListForGenderCateRecommend(item_gender, 2);
			List<ItemVO> itemGenderPantsList = tradeService.mainGetItemListForGenderCateRecommend(item_gender, 3);
			model.addAttribute("itemGenderList",itemGenderList);
			model.addAttribute("itemGenderShoesList",itemGenderShoesList);
			model.addAttribute("itemGenderShirtsList",itemGenderShirtsList);
			model.addAttribute("itemGenderPantsList",itemGenderPantsList);
		}
		
		// 메인페이지 - 신규 상품 목록
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tab", 0);
		map.put("order", 1);
		map.put("start", 1);
		map.put("end", 4);
		map.put("item_status", 1);
		List<ItemVO> list = itemService.selectList(map);
		
		// 메인페이지 - 신규 브랜드 목록
		List<ItemVO> brand = tradeService.mainGetItemList();
		
		// 메인페이지 - 작은 배너 목록
		Map<String, Object> promotionMap = new HashMap<String, Object>();
		promotionMap.put("start", 1);
		promotionMap.put("end", 2);
		List<PromotionVO> promotionList = promotionService.selectList(promotionMap);
		
		model.addAttribute("itemList",list);
		model.addAttribute("brand",brand);
		model.addAttribute("promotionList",promotionList);
		model.addAttribute("item_gender",item_gender);
		return "main_search";//타일스 설정의 식별자
	}
	
	@RequestMapping("/main/admin.do")
	public String adminMain(Model model) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", 1);
		map.put("end", 5);
		
		List<MemberVO> memberList = memberService.selectList(map);
		
		//최신 5명 회원정보
		model.addAttribute("memberList", memberList);
		
		return "admin";//타일스 설정의 식별자
	}
}




