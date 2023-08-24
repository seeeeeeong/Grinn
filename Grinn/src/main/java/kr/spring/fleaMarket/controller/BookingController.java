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

import kr.spring.fleaMarket.service.BookingService;
import kr.spring.fleaMarket.service.MarketService;
import kr.spring.fleaMarket.vo.BookingVO;
import kr.spring.fleaMarket.vo.MarketVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
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
	public String getForm(@RequestParam int market_num, Model model) {
		
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
			MarketVO market = marketService.selectMarket(bookingVO.getMarket_num());
			
			model.addAttribute("market", market);
			
			return "selectDate";
		}
				
		MemberVO user = (MemberVO)session.getAttribute("user");
		bookingVO.setMem_num(user.getMem_num());
		
		bookingService.insertBooking(bookingVO);
		
		// View
		model.addAttribute("message", "예약이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/fleamarket/marketList.do?mem_num=" + bookingVO.getMem_num());
		
		return "common/resultView";
	}
	
	
	// ===관리자 - 예약 목록===
	@RequestMapping("/fleamarket/admin_resList.do")
	public ModelAndView adminBookList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, 
			                                        String keyfield, String keyword) {
		log.debug("<<keyfield>> : " + keyfield);
		log.debug("<<keyword>> : " + keyword);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		// 전체/검색 레코드 수
		int count = bookingService.selectCountBooking(map);
		
		log.debug("<<예약 목록 수>>" + count);
		
		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 5, "admin_resList.do");
		
		List<BookingVO> bookList = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			bookList = bookingService.selectListBooking(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminBookList");
		mav.addObject("count", count);
		mav.addObject("bookList", bookList);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	// 관리자 - 예약 상세
	@RequestMapping("/fleamarket/detailBooking.do")
	public String detail(@RequestParam int book_num, Model model) {
		log.debug("<<예약 내역>> : " + book_num);
		// 예약 정보
		BookingVO bookingVO = bookingService.selectBooking(book_num);
		//MarketVO marketVO = marketService.selectMarket(market_num);
		
		model.addAttribute("bookingVO", bookingVO);
		//model.addAttribute("marketVO", marketVO);
		
		return "bookDetail";
	}
	
	
	// ===이용자 - 회원별 예약 목록===
	@RequestMapping("/fleamarket/marketList.do")
	public ModelAndView myMarketPage(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
			                                 String keyfield, String keyword, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("mem_num", user.getMem_num());
		
		// 전체 검색 레코드 수
		int count = bookingService.selectBookingCountByMem_num(map);
		
		log.debug("<<이용자 예약 내역 수>> : " + count);
		
		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 5, "marketList.do");
		
		List<BookingVO> userList = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			userList = bookingService.selectListBookingByMem_num(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("myMarketPage");
		mav.addObject("count", count);
		mav.addObject("userList", userList);
		mav.addObject("page", page.getPage());
				
		return mav;
	}
	
	
	// 이용자 - 회원별 예약 상세
	@RequestMapping("/fleamarket/bookDetail.do")
	public String userDetail(@RequestParam int book_num, Model model) {
		
		BookingVO book = bookingService.selectBooking(book_num);
		
		model.addAttribute("bookingVO", book);
		
		return "myMarketDetail";
	}
	
	

	
	// 이용자 - 예약 취소
	@RequestMapping("/fleamarket/bookingDelete.do")
	public String bookDelete(@RequestParam int book_num, Model model, HttpSession session, HttpServletRequest request) {
		BookingVO db_book = bookingService.selectBooking(book_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		if (db_book.getMem_num() != user.getMem_num()) {
			// 다른 회원 주문 취소 불가
			model.addAttribute("message", "다른 회원의 예약을 취소할 수 없습니다.");
			model.addAttribute("url", request.getContextPath() + "/fleamarket/marketList.do");
			
			return "common/resultView";
		}
		
		// 예약 취소
		bookingService.deleteBooking(book_num);
		
		return "redirect:/fleamarket/marketList.do";
	}
}
