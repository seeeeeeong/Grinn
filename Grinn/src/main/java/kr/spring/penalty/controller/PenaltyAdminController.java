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

import kr.spring.penalty.service.PenaltyService;
import kr.spring.penalty.vo.PenaltyVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PenaltyAdminController {
	@Autowired
	private PenaltyService penaltyService;
	
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
		
		if (result.hasErrors()) {
			return form();
		}
		
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
}
