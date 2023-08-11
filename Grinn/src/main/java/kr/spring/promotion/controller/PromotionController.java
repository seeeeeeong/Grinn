package kr.spring.promotion.controller;

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

import kr.spring.promotion.service.PromotionService;
import kr.spring.promotion.vo.PromotionVO;
import kr.spring.util.PagingUtil;
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
	
	@PostMapping("/promotion/adminWrite.do")
	public String submit(@Valid PromotionVO pro, BindingResult result, Model model,
			                    HttpServletRequest request, HttpSession session) {
		log.debug("<<프로모션 등록>> : " + pro);
		
		// 프로모션 이미지 유효성 체크
		if (pro.getPro_photo1().length == 0) {
			result.rejectValue("pro_photo1", "required");
		}
		if (pro.getPro_photo1().length >= 5*1024*1024) {
			result.rejectValue("pro_photo1", "limitUploadSize");
		}
		
		// 유효성 체크 결과 오류가 있으면 폼 호출
		if (result.hasErrors()) {
			return form();
		}
		
		promotionService.insertPromotion(pro);
		
		// View에 표시할 메시지
		model.addAttribute("message", "프로모션 등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/promotion/adminList.do");
		
		return "common/resultView";
	}
	
	
	// ===프로모션 목록===
	@RequestMapping("/promotion/adminList.do")
	public ModelAndView adminList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
			                                    String keyfield, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		
		// 전체/검색 레코드 수
		int count = promotionService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 5, "adminList.do");
		
		List<PromotionVO> list = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = promotionService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminPromotionList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	// ===프로모션 사진 출력===
	@RequestMapping("/promotion/photoView.do")
	public String getPhoto(@RequestParam int pro_num, HttpServletRequest request, Model model) {
		PromotionVO promotionVO = promotionService.selectPromotion(pro_num);
		
		model.addAttribute("photoFile", promotionVO.getPro_photo1());
		model.addAttribute("photoName", promotionVO.getPro_photoName1());
		
		return "photoView";
	}
	
	
	// ===프로모션 수정===
	// 수정 폼
	@GetMapping("/promotion/updatePromotion.do")
	public String updateForm(@RequestParam int pro_num, Model model) {
		PromotionVO promotionVO = promotionService.selectPromotion(pro_num);
		model.addAttribute("promotionVO", promotionVO);
		
		return "adminUpdate";
	}
	
	// 전송된 데이터 처리
	@PostMapping("/promotion/updatePromotion.do")
	public String updateSubmit(@Valid PromotionVO promotionVO, BindingResult result, 
			                   HttpServletRequest request, Model model) {
		log.debug("<<프로모션 수정>> : " + promotionVO);
		
		// 유효성 검사에서 오류 발생시 폼 호출
		if (result.hasErrors()) {
			return "adminUpdate";
		}
		
		promotionService.updatePromotion(promotionVO);
		
		// View
		model.addAttribute("message", "프로모션 수정 완료");
		model.addAttribute("url", request.getContextPath() + "/promotion/adminList.do");
		
		return "common/resultView";
	}
	
	
	// ===프로모션 삭제===
	@RequestMapping("/promotion/deletePromotion.do")
	public String delete(@RequestParam int pro_num) {
		log.debug("<<프로모션 삭제>> : " + pro_num);
		
		promotionService.deletePromotion(pro_num);
		
		return "redirect:/promotion/adminList.do";
	}
}
