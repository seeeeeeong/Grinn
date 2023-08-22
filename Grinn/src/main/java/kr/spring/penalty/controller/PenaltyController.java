package kr.spring.penalty.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.penalty.service.PenaltyService;
import kr.spring.penalty.vo.PenaltyVO;
import kr.spring.user.service.UserService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PenaltyController {
	@Autowired
	private PenaltyService penaltyService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private UserService userService;
	
	// 자바빈 초기화
	@ModelAttribute
	public PenaltyVO initCommand() {
		return new PenaltyVO();
	}
	
	// ===마이페이지 회원 페널티 조회===
	/*
	@RequestMapping("/user/userPenaltyInfo.do")
	public String list(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO member = memberService.selectMember(user.getMem_num());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_num", user.getMem_num());
		
		int penalty_sum = userService.getPenaltyTotalScore(user.getMem_num());
		
		List<PenaltyVO> penaltyList = null;
		if (penalty_sum > 0) {
			penaltyList = penaltyService.selectList(map);
		}
		
		model.addAttribute("member", member);
		model.addAttribute("penalty_sum", penalty_sum);
		model.addAttribute("penaltyList", penaltyList);
		
		return "penaltyList";
	}
	*/
}
