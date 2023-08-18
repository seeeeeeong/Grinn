package kr.spring.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private ItemService itemService;
	
	@RequestMapping("/")
	public String main() {
		return "redirect:/main/main.do";
	}
	
	@RequestMapping("/main/main.do")
	public String main(Model model) {
		
		// 메인페이지 - 신규 상품 목록
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tab", 0);
		map.put("order", 1);
		map.put("start", 1);
		map.put("end", 4);
		List<ItemVO> list = itemService.selectList(map);
		
		model.addAttribute("itemList",list);
		return "main";//타일스 설정의 식별자
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




