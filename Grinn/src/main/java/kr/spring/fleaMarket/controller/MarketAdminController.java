package kr.spring.fleaMarket.controller;

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

import kr.spring.fleaMarket.service.MarketService;
import kr.spring.fleaMarket.vo.MarketVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MarketAdminController {
	@Autowired
	private MarketService marketService;
	
	@ModelAttribute
	public MarketVO initCommand() {
		return new MarketVO();
	}
	
	// ===플리마켓 목록 - 관리자===
	@RequestMapping("/fleamarket/adminMarketList.do")
	public ModelAndView getAdminMarketList(@RequestParam(value="pageNum", defaultValue="1") 
	                                          int currentPage, String keyfield, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		// 전체/검색 레코드수
		int count = marketService.selectCount(map);
		
		log.debug("<<count>> : " + count);
		
		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 5, "adminMarketList.do");
		
		List<MarketVO> marketList = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			marketList = marketService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminMarketList");
		mav.addObject("count", count);
		mav.addObject("marketList", marketList);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	//===플리마켓 등록===
	// 등록 폼
	@GetMapping("/fleamarket/adminMarketWrite.do")
	public String marketWriteForm() {
		return "adminMarketWrite";
	}
	
	@PostMapping("/fleamarket/adminMarketWrite.do")
	public String marketWriteSubmit(@Valid MarketVO vo, BindingResult result, Model model,
			                              HttpServletRequest request, HttpSession session) {
		log.debug("<<플리마켓 등록>> : " + vo);
		
		// 이미지 유효성 체크
		if (vo.getMarket_poster().length == 0) {
			result.rejectValue("market_poster", "required");
		}
		if (vo.getMarket_thumbNail().length == 0) {
			result.rejectValue("market_thumbNail", "required");
		}
		
		if (vo.getMarket_poster().length >= 5*1024*1024) {
			result.rejectValue("market_poster", "limitUploadSize", new Object[] {"5MB"}, null);
		}
		if (vo.getMarket_thumbNail().length >= 5*1024*1024) {
			result.rejectValue("market_thumbNail", "limitUploadSize", new Object[] {"5MB"}, null);
		}
		
		// 유효성 체크 결과 오류 발생시 폼 호출
		if (result.hasErrors()) {
			return marketWriteForm();
		}
		
		marketService.insertMarket(vo);
		
		// View에 표시할 메시지
		model.addAttribute("message", "이용자용 플리마켓 등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/fleamarket/adminMarketList.do");
		
		return "common/resultView";
	}
	
	
	// ===부스 목록 - 관리자===
	@RequestMapping("/fleamarket/adminBoothList.do")
	public ModelAndView getAdminBoothList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, 
											String keyfield, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		// 전체/검색 레코드수
		int count = marketService.selectCount(map);
		
		log.debug("<<count>> : " + count);
		
		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 5, "adminBoothList.do");
		
		List<MarketVO> boothList = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			boothList = marketService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminBoothList");
		mav.addObject("count", count);
		mav.addObject("boothList", boothList);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	//===부스 등록===
	// 등록 폼
	@GetMapping("/fleamarket/adminBoothWrite.do")
	public String boothWriteForm() {
		return "adminBoothWrite";
	}
	
	@PostMapping("/fleamarket/adminBoothWrite.do")
	public String boothWriteSubmit(@Valid MarketVO vo, BindingResult result, Model model,
			                              HttpServletRequest request, HttpSession session) {
		log.debug("<<부스 등록>> : " + vo);
		
		// 이미지 유효성 체크
		if (vo.getMarket_poster().length == 0) {
			result.rejectValue("market_poster", "required");
		}
		if (vo.getMarket_thumbNail().length == 0) {
			result.rejectValue("market_thumbNail", "required");
		}
		
		if (vo.getMarket_poster().length >= 5*1024*1024) {
			result.rejectValue("market_poster", "limitUploadSize", new Object[] {"5MB"}, null);
		}
		if (vo.getMarket_thumbNail().length >= 5*1024*1024) {
			result.rejectValue("market_thumbNail", "limitUploadSize", new Object[] {"5MB"}, null);
		}
		
		// 유효성 체크 결과 오류 발생시 폼 호출
		if (result.hasErrors()) {
			return boothWriteForm();
		}
		
		marketService.insertMarket(vo);
		
		// View에 표시할 메시지
		model.addAttribute("message", "판매자용 플리마켓 등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/fleamarket/adminBoothList.do");
		
		return "common/resultView";
	}
	
	
	//===부스 수정===
	// 수정 폼 호출
	@GetMapping("/fleamarket/updateBooth.do")
	public String boothFormUpdate(@RequestParam int market_num, Model model) {
		MarketVO marketVO = marketService.selectMarket(market_num);
		model.addAttribute("marketVO", marketVO);
		
		return "adminBoothUpdate";
	}
	
	// 전송된 데이터 처리
	@PostMapping("/fleamarket/updateBooth.do")
	public String boothSubmitUpdate(@Valid MarketVO marketVO, BindingResult result,
			                        HttpServletRequest request, Model model) {
		log.debug("<<부스 수정>> : " + marketVO);
		
		// 유효성 검사에서 오류 발생시 폼 호출
		if (result.hasErrors()) {
			return "adminBoothUpdate";
		}
		
		marketService.updateMarket(marketVO);
		
		// View
		model.addAttribute("message", "부스 수정 완료");
		model.addAttribute("url", request.getContextPath() + "/fleamarket/adminBoothList.do");
		
		return "common/resultView";
	}
	
	
	//===부스 삭제===
	@RequestMapping("/fleamarket/deleteBooth.do")
	public String deleteBooth(@RequestParam int market_num) {
		log.debug("<<부스 삭제>> : " + market_num);
		
		marketService.deleteMarket(market_num);
		
		return "redirect:/fleamarket/adminBoothList.do";
	}
	
	
	//===장소 등록===
	// 등록 폼
	@GetMapping("/fleamarket/adminLocationWrite.do")
	public String locationWriteForm() {
		return "adminLocationWrite";
	}
	
	//===장소 리스트===
}
