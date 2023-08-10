package kr.spring.fleaMarket.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	
	// ===자바빈 초기화===
	@ModelAttribute
	public BookingVO initCommand() {
		return new BookingVO();
	}
	
	// ===예약 폼===    
	@RequestMapping("/fleamarket/booking.do")
	public String getForm(@RequestParam int market_num, HttpSession session, Model model) {
		
		MarketVO market = marketService.selectMarket(market_num);
		
		model.addAttribute("market", market);
		
		return "selectDate";
	}
	
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
	
	
}
