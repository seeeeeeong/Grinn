package kr.spring.penalty.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.penalty.service.PenaltyService;
import kr.spring.penalty.vo.PenaltyVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PenaltyAdminController {
	@Autowired
	private PenaltyService penaltyService;
	
	@Autowired
	private MemberService memberService;
	
	// 자바빈 초기화
	@ModelAttribute
	public PenaltyVO initCommand() {
		return new PenaltyVO();
	}
	
	
	// ===페널티 등록===
	@GetMapping("/penalty/adminPenaltyWrite.do")
	public String form() {
		return "adminPenaltyWrite";
	}
	
	@PostMapping("/penalty/adminPenaltyWrite.do")
	public String submit(@Valid PenaltyVO vo, BindingResult result, Model model,
			                    HttpServletRequest request, HttpSession session) {
		log.debug("<<페널티 등록>> : " + vo);
		
		// 유효성 체크
		if (result.hasErrors()) {
			return form();
		}
		
		//MemberVO mem_num = memberService.selectMember(vo.getMem_num());
		penaltyService.insertPenalty(vo);
		
		// View
		model.addAttribute("message", "페널티 등록이 완료되었습니다");
		model.addAttribute("url", request.getContextPath() + "penalty/admin_list.do");
		
		return "common/resultView";
	}
	
	
	// ===페널티 목록===
	@RequestMapping("/penalty/admin_list.do")
	public ModelAndView list(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
			                 String keyfield, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		// 전체 검색 레코드 수
		int count = penaltyService.selectRowCount(map);
		
		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 5, "admin_list.do");
		
		List<PenaltyVO> list = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = penaltyService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminPenaltyList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	// 페널티 상세
	@RequestMapping("/penalty/admin_detail.do")
	public String detail(@RequestParam int pe_num, Model model) {
		log.debug("<<페널티 내역>> : " + pe_num);
		
		PenaltyVO penaltyVO = penaltyService.selectPenalty(pe_num);
		
		model.addAttribute("penaltyVO", penaltyVO);
		
		return "penaltyDetail";
	}
	
	// ===페널티 수정===
	// 수정 폼
	@GetMapping("/penalty/modifyPenalty.do")
	public String modifyForm(@RequestParam int pe_num, Model model) {
		PenaltyVO penaltyVO = penaltyService.selectPenalty(pe_num);
		model.addAttribute("penaltyVO", penaltyVO);
		
		return "penaltyModify";
	}
	
	// 전송된 데이터 처리
	@PostMapping("/penalty/modifyPenalty.do")
	public String modifySubmit(@Valid PenaltyVO penaltyVO, BindingResult result,
			                   HttpServletRequest request, Model model) {
		log.debug("<<페널티 수정>> : " + penaltyVO);
		
		// 유효성 검사 오류 발생의 경우
		if (result.hasErrors()) {
			return "penaltyModify";
		}
		
		penaltyService.updatePenalty(penaltyVO);
		
		// View
		model.addAttribute("message", "프로모션 수정 완료");
		model.addAttribute("url", request.getContextPath() + "/penalty/admin_detail.do?pe_num=" + penaltyVO.getPe_num());
		
		
		return "common/resultView";
	}
}
