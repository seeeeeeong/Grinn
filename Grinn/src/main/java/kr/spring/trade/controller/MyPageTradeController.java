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
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.sbid.vo.SaleBidVO;
import kr.spring.trade.service.TradeService;
import kr.spring.trade.vo.TradeVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MyPageTradeController {
	
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
	 * 마이페이지 : 구매, 판매 내역
	 * ======================================================================================================================
	 **/
	// 마이페이지 - 구매 내역
	@RequestMapping("/user/buying.do")
	public ModelAndView myPurchaseBidInfO(
									  @RequestParam(value="way",defaultValue="1") int way,
									  @RequestParam(value="status",defaultValue="1") int status,
									  @RequestParam(value="pageNum",defaultValue="1") int currentPage,
									  HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		int count = 0;
		int bidCount = tradeService.selectPurchaseBidCount(user.getMem_num());
		int tradeCount = tradeService.selectTradePurchaseCount(user.getMem_num());
		int quitCount = tradeService.selectTradePurchaseQuitCount(user.getMem_num());
		PagingUtil page = null;
		List<PurchaseBidVO> purchaseBidList = null;
		List<TradeVO> purchaseTradeList = null;
		
		if(way == 1) {
			count = tradeService.selectPurchaseBidCount(user.getMem_num());
			bidCount = tradeService.selectPurchaseBidCount(user.getMem_num());
			page = new PagingUtil(currentPage,count,10,5,"/user/buying.do");
			
			map.put("status", status);
			map.put("mem_num", user.getMem_num());
			
			if(count > 0 ) {
				map.put("start", page.getStartRow());
				map.put("end",page.getEndRow());
				purchaseBidList = tradeService.selectPurchaseBidInfo(map);
			}
			
			mav.addObject("list",purchaseBidList);
		}else if(way == 2) {
			count = tradeService.selectTradePurchaseCount(user.getMem_num());
			
			page = new PagingUtil(currentPage,count,10,5,"/user/buying.do");
			
			map.put("status", status);
			map.put("mem_num", user.getMem_num());
			
			if(count > 0 ) {
				map.put("start", page.getStartRow());
				map.put("end",page.getEndRow());
				purchaseTradeList = tradeService.selectTradePurchaseInfo(map);
			}
			log.debug("<< count >> : " + count);
			mav.addObject("list",purchaseTradeList);
		}else if(way == 3) {
			status = 5;
			count = tradeService.selectTradePurchaseQuitCount(user.getMem_num());
			
			page = new PagingUtil(currentPage,count,10,5,"/user/buying.do");
			
			map.put("status", status);
			map.put("mem_num", user.getMem_num());
			
			if(count > 0) {
				map.put("start", page.getStartRow());
				map.put("end",page.getEndRow());
				purchaseTradeList = tradeService.selectTradePurchaseInfo(map);
			}
			mav.addObject("list",purchaseTradeList);
		}
		
		
		mav.addObject("page",page.getPage());
		mav.addObject("count",count);
		mav.addObject("bidCount",bidCount);
		mav.addObject("tradeCount",tradeCount);
		mav.addObject("quitCount",quitCount);
		mav.addObject("status",status);
		mav.addObject("way",way);
		mav.setViewName("buying");
		return mav;
	}
	
	// 마이페이지 - 판매내역
	@RequestMapping("/user/selling.do")
	public ModelAndView mySaleInfo(
									@RequestParam(value="way",defaultValue="1") int way,
									@RequestParam(value="status",defaultValue="1") int status,
									@RequestParam(value="pageNum",defaultValue="1") int currentPage,
									HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		int count = 0;
		int bidCount = tradeService.selectSaleBidCount(user.getMem_num());
		int tradeCount = tradeService.selectTradeSaleCount(user.getMem_num());
		int quitCount = tradeService.selectTradeSaleQuitCount(user.getMem_num());
		
		PagingUtil page = null;
		List<SaleBidVO> saleBidList = null;
		List<TradeVO> saleTradeList = null;
		
		if(way == 1) { // 판매 입찰 내역
			count = tradeService.selectSaleBidCount(user.getMem_num());
			bidCount = tradeService.selectSaleBidCount(user.getMem_num());
			page = new PagingUtil(currentPage,count,10,5,"/user/buying.do");
			
			map.put("status", status);
			map.put("mem_num", user.getMem_num());
			
			if(count > 0 ) {
				map.put("start", page.getStartRow());
				map.put("end",page.getEndRow());
				saleBidList = tradeService.selectSaleBidInfo(map);
			}
			
			mav.addObject("list",saleBidList);
		}else if(way == 2) { // 판매 거래 정보 내역
			count = tradeService.selectTradeSaleCount(user.getMem_num());
			
			page = new PagingUtil(currentPage,count,10,5,"/user/buying.do");
			
			map.put("status", status);
			map.put("mem_num", user.getMem_num());
			
			if(count > 0 ) {
				map.put("start", page.getStartRow());
				map.put("end",page.getEndRow());
				saleTradeList = tradeService.selectTradeSaleInfo(map);
			}
			log.debug("<< count >> : " + count);
			mav.addObject("list",saleTradeList);
		}else if(way == 3) { // 종료된 판매 거래 정보 내역
			status = 5;
			count = tradeService.selectTradeSaleQuitCount(user.getMem_num());
			
			page = new PagingUtil(currentPage,count,10,5,"/user/buying.do");
			
			map.put("status", status);
			map.put("mem_num", user.getMem_num());
			
			if(count > 0) {
				map.put("start", page.getStartRow());
				map.put("end",page.getEndRow());
				saleTradeList = tradeService.selectTradeSaleInfo(map);
				log.debug("<< 종료된 판매 거래 >> : " + saleTradeList.size());
			}
			mav.addObject("list",saleTradeList);
		}
		
		
		mav.addObject("page",page.getPage());
		mav.addObject("count",count);
		mav.addObject("bidCount",bidCount);
		mav.addObject("tradeCount",tradeCount);
		mav.addObject("quitCount",quitCount);
		mav.addObject("status",status);
		mav.addObject("way",way);
		mav.setViewName("selling");
		return mav;
	}
	
	// 마이페이지 - 구매입찰 내역 삭제
	@RequestMapping("/purchase/deleteBid.do")
	public String deletePurchaseBid(@RequestParam int purchase_num,HttpSession session,Model model) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		if(user == null) {
			model.addAttribute("message","로그인이 필요합니다!!!");
			model.addAttribute("url","../member/login.do");
		}else {
			// 구매 입찰 시 결제한 포인트 반환
			PurchaseBidVO pbVO = tradeService.selectPurchaseBidByPurchaseNum(purchase_num);
			int ship = 0;
			if(pbVO.getPurchase_price() < 50000) ship+=3000;
			int fee = pbVO.getPurchase_price() / 10;
			int total = pbVO.getPurchase_price() + ship + fee;
			
			tradeService.sendPointToBuyer(user.getMem_num(), total);
			
			// 구매 입찰 내역 삭제
			tradeService.deletePurchaseBid(purchase_num);
						
			model.addAttribute("message","구매입찰 내역이 성공적으로 삭제되었습니다.");
			model.addAttribute("url","../user/buying.do");
		}
		
		return "common/resultView";
	}
	
	// 마이페이지 - 판매입찰 내역 삭제
	@RequestMapping("/sale/deleteBid.do")
	public String deleteSaleBid(@RequestParam int sale_num,HttpSession session, Model model) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		if(user == null) {
			model.addAttribute("message","로그인이 필요합니다.");
			model.addAttribute("url","../member/login.do");
		}else {
			tradeService.deleteSaleBid(sale_num);
			model.addAttribute("message","판매입찰 내역이 성공적으로 삭제되었습니다.");
			model.addAttribute("url","../user/selling.do");
		}
		
		return "common/resultView";
	}
	
	// 마이페이지 - 판매 거래 상태 변경 ( 검수준비중 -> 검수중 )
	@RequestMapping("/sale/sendItem.do")
	public String updateTradeStateToSend(@RequestParam int trade_num, HttpSession session, Model model) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		if(user == null) {
			model.addAttribute("message","로그인이 필요합니다.");
			model.addAttribute("url","../member/login.do");
		}else {
			tradeService.updateTradeStateToSend(trade_num);
			model.addAttribute("message","상품을 보냅니다.");
			model.addAttribute("url","../user/selling.do");
		}
		
		return "common/resultView";
	}
}
