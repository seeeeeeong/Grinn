package kr.spring.fleaMarket.controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.fleaMarket.service.BookingService;
import kr.spring.fleaMarket.service.MarketService;
import kr.spring.fleaMarket.vo.BookingVO;
import kr.spring.fleaMarket.vo.MarketVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BookingController {
	@Autowired
	private BookingService bookingService;
	@Autowired
	private MarketService marketService;
	@Autowired
	private MemberService memberService;
	
	// ===자바빈 초기화===
	@ModelAttribute
	public BookingVO initCommand() {
		return new BookingVO();
	}
	
	// ===예약===
	// 예약 폼
	@GetMapping("/fleamarket/booking.do")
	public String getForm(@RequestParam int market_num, HttpSession session, Model model) {
		
		//로그인한 사용자의 회원번호 와 market_num 이용해서 예약했는지 여부 확인
		// boolean, yes/no, if문 등으로 확인 후에 
		// 이미 예약한 경우: 예약했다고 알림창을 띄우기(날짜도 알려줌?)
		// 예약 내역이 없는 경우: 이어서
		// String result = "no";
		// BookingVO book = bookingService.
		MarketVO market = marketService.selectMarket(market_num);
			
		model.addAttribute("market", market);
		//model.addAttribute("result", result);
		
		return "selectDate";
	}
	
	// 전송된 데이터 처리
	@PostMapping("/fleamarket/booking.do")
	public String submitDate(@Valid BookingVO bookingVO, BindingResult result, 
			                        HttpServletRequest request, HttpSession session, Model model) {
		log.debug("<<예약 제출>> : " + bookingVO);
		
		// 유효성 체크 결과 오류가 있으면 폼 호출
		if (result.hasErrors()) {
			//return getForm(bookingVO, session, model);
		}
				
		MemberVO user = (MemberVO)session.getAttribute("user");
		bookingVO.setMem_num(user.getMem_num());
		
		bookingService.insertBooking(bookingVO);
		
		// View
		model.addAttribute("message", "예약이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/fleamarket/marketList.do?mem_num=" + bookingVO.getMem_num());
		
		return "common/resultView";
	}
	
	/*
	// ===예약 날짜 선택===
	@RequestMapping("/fleamarket/selectDate.do")
	@ResponseBody
	public Map<String, String> submit(BookingVO bookingVO, HttpSession session) {
		log.debug("<<BookingVO>> : " + bookingVO);
		
		Map<String, String> mapJson = new HashMap<String, String>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if (user == null) { // 로그인 상태 X
			mapJson.put("result", "logout");
		} else { // 로그인 상태
			bookingVO.setMem_num(user.getMem_num());
			
			BookingVO db_book = bookingService.selectBooking(bookingVO);
			if (user != null && db_book == null) { // 예약된 동일 내역이 없는 경우
				bookingService.insertBooking(bookingVO);
				mapJson.put("result", "success");
			} else if (user != null && db_book != null) { // 이미 예약한 내역이 있는 경우***
				mapJson.put("result", "alreadyBooked");
			} else {
				mapJson.put("result", "wrongAccess");
			}
		}
		return mapJson;
	}
	*/
	
	// ===회원별 예약 목록===
	@RequestMapping("fleamarket/marketList.do")
	public String myMarketPage(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		// 회원 정보 반환
		MemberVO member = memberService.selectMember(user.getMem_num());
		// BookingVO book = bookingService.selectBooking(book);
		
		// 회원 정보
		model.addAttribute("member", member);
		
		return "userMarketPage";
	}
	
	
	// 이용자/관리자 - 예약 상세
	
	// 이용자 - 예약 취소
	@RequestMapping("/fleamarket/bookingDelete.do")
	public String bookDelete(@RequestParam int book_num) {
		log.debug("<<예약 취소>> : " + book_num);
		
		bookingService.deleteBooking(book_num);
		
		return "redirect:/fleamarket/marketList.do";
	}
}
