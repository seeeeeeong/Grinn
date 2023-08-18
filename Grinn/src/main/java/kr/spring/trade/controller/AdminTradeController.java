package kr.spring.trade.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.penalty.service.PenaltyService;
import kr.spring.penalty.vo.PenaltyVO;
import kr.spring.trade.service.TradeService;
import kr.spring.trade.vo.TradeVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminTradeController {
	
	@Autowired
	TradeService tradeService;
	
	/**
	 * ======================================================================================================================
	 * 자바 빈 초기화
	 * ======================================================================================================================
	 **/
	@ModelAttribute
	public TradeVO initCommand() {
		return new TradeVO();
	}

	/**
	 * ======================================================================================================================
	 * 관리자 관련 정보
	 * ======================================================================================================================
	 **/
	// 거래 목록 조회
	@RequestMapping("/trade/admin_list.do")
	public ModelAndView getTradeList(@RequestParam(value="pageNum", defaultValue="1")int currentPage,
									 @RequestParam(value="status", defaultValue="1")int status,
									 HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String message = "";
		String url = "";
		PagingUtil page = null;
		int count = 0;
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		List<TradeVO> list = null;
		if(user == null) {
			message = "로그인이 필요합니다.";
			url = "../member/login.do";
			mav.addObject("message",message);
			mav.addObject("url",url);
			mav.setViewName("common/resultView");
			return mav;
		}else if(user != null && user.getMem_auth() != 9) {
			message = "잘못된 접근입니다.";
			url = "../main/main.do";
			mav.addObject("message",message);
			mav.addObject("url",url);
			mav.setViewName("common/resultView");
			return mav;
		}else {
			count = tradeService.getTradeListCount();
			page = new PagingUtil(currentPage,count,10,5,"/trade/admin_list.do");
			
			if(count > 0) {
				map.put("start",page.getStartRow());
				map.put("end",page.getEndRow());
				map.put("status", status);
				list = tradeService.getTradeList(map);
			}
			
			mav.addObject("list",list);
			mav.addObject("page",page.getPage());
			mav.addObject("count",count);
			mav.setViewName("admin_list");
			mav.addObject("status",status);
			return mav;
		}
		
	}
	
	// 거래 상세 페이지
	@RequestMapping("/trade/admin_detail.do")
	public String getTradeDetail(@RequestParam int trade_num, HttpSession session, Model model) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		TradeVO trade = null;
		if(user == null) {
			model.addAttribute("message","로그인이 필요합니다.");
			model.addAttribute("url","../member/login.do");
			return "common/resultView";
		}else {
			if(user.getMem_auth() != 9) {
				model.addAttribute("message","잘못된 접근입니다.");
				model.addAttribute("url","../main/main.do");
				return "common/resultView";
			}else {
				trade = tradeService.getTradeDetail(trade_num);
				model.addAttribute("trade",trade);
			}
		}
		
		return "admin_detail";
	}
	
	// 거래 상태 수정
	@RequestMapping("/trade/adminUpdateTradeState.do")
	public String updateTradeState(HttpSession session, Model model, @RequestParam int trade_num, @RequestParam int trade_state,@RequestParam(value="pe_type",defaultValue="0")int pe_type){
		MemberVO user = (MemberVO) session.getAttribute("user");
		TradeVO tradeVO = null;
		if(user == null) {
			model.addAttribute("message","로그인이 필요하니다.");
			model.addAttribute("url","../member/login.do");
			return "common/resultView";
		}else {
			if(user.getMem_auth() != 9 || user.getMem_num()!=29) {
				model.addAttribute("message","잘못된 접근입니다.");
				model.addAttribute("url","../main/main.do");
				return "common/resultView";
			}else {
				if(trade_state == 4) {
					// 검수 성공 - 판매자에게 (입찰가 - 수수료) 입금하기
					tradeVO = tradeService.getTradeDetailForDeposit(trade_num);
					int mem_num = tradeVO.getSeller_num();
					int price = tradeVO.getTrade_price();
					int fee = price / 10;
					int total = price - fee;
					log.debug("판매자 : " + tradeVO.getSeller_num());
					// 거래가 판매자에게 입금
					tradeService.sendPointToSeller(mem_num, total); 
					// 거래가 관리자에서 출금
					tradeService.adminWithdraw(total, user.getMem_num());
				}else if(trade_state == 6) {// 거래 실패
					// 거래실패로 상태 변경시 구매자에게 포인트 반환
					tradeVO = tradeService.getTradeDetail(trade_num);
					int mem_num = tradeVO.getBuyerVO().getMem_num();
					int price = tradeVO.getTrade_price();
					int ship = 0;
					if(price < 50000) ship+=3000;
					int fee = price / 10;
					log.debug("구매자 : " + mem_num);
					log.debug("구매액 : " + (price+ship+fee));
					// 구매자에게 포인트 반환
					tradeService.sendPointToBuyer(mem_num, price+ship+fee);
					// 관리자에서 포인트 차감
					tradeService.adminWithdraw(price+ship+fee,user.getMem_num());
					
					// 패널티 부여하기
					PenaltyVO vo = new PenaltyVO();
					vo.setMem_num(tradeVO.getSellerVO().getMem_num());
					vo.setPe_service_type(3);
					vo.setPe_type(pe_type);
					if(pe_type == 7) {
						vo.setPe_score(20);
					}else if(pe_type == 8){
						vo.setPe_score(30);
					}else {
						vo.setPe_score(10);
					}
					
					tradeService.adminInsertPenalty(vo);
				}
				
				tradeService.updateTradeState(trade_num, trade_state);
				model.addAttribute("message","거래 상태를 성공정으로 수정했습니다.");
				model.addAttribute("url","../trade/admin_list.do");
				return "common/resultView";
			}
		}
	}
	
	// 거래 실패로 인한 패널티 부여 페이지
	@RequestMapping("/trade/adminGivePenalty.do")
	public ModelAndView getAdminGivePenaltyForm(@RequestParam int seller_num, @RequestParam int trade_num, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ModelAndView mav = new ModelAndView();
		
		if(user == null) {
			mav.addObject("message","로그인이 필요합니다.");
			mav.addObject("url","../member/login.do");
			mav.setViewName("common/resultView");
			return mav;
		}else {
			if(user.getMem_auth() != 9) {
				mav.addObject("message","잘못된 접근입니다.");
				mav.addObject("url","../main/main.do");
				mav.setViewName("common/resultView");
				return mav;
			}else {
				mav.addObject("trade",tradeService.getTradeDetail(trade_num));
				mav.setViewName("admin_penalty");
				return mav;
			}
		}
	}
	
	/**
	 * ======================================================================================================================
	 * 관리자 포인트 정보
	 * ======================================================================================================================
	 **/
	// 관리자 - 포인트 정보
	@RequestMapping("/admin/point.do")
	public String adminGetPoint(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("message","로그인이 필요합니다.");
			model.addAttribute("url","../member/login.do");
			return "common/resultView";
		}else {
			if(user.getMem_auth() != 9 || user.getMem_num() != 29) {
				model.addAttribute("message","잘못된 접근입니다.");
				model.addAttribute("url","../main/main.do");
				return "common/resultView";
			}else {
				model.addAttribute("point",tradeService.adminGetPoint(user.getMem_num()));
				return "admin_point";
			}
		}
	}
}
