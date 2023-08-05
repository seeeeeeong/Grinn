package kr.spring.trade.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.pbid.vo.PurchaseSizePriceVO;
import kr.spring.sbid.vo.SaleBidVO;
import kr.spring.sbid.vo.SaleSizePriceVO;
import kr.spring.trade.service.TradeService;
import kr.spring.trade.vo.TradeVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TradeController {
	@Autowired
	TradeService tradeService;
	@Autowired
	MemberService memberService;

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
	 * 구매하기 버튼 클릭 시 상품에 따른 사이즈 정보 제공
	 * ======================================================================================================================
	 **/
	@GetMapping("/purchase/selectSize.do")
	public ModelAndView getPurchaseItemAndSize(@RequestParam int item_num) {

		// Login인터셉터로 로그인 되어있는지 확인필요 ***********

		// 사이즈 별 판매 입찰 정보를 뿌리기
		log.debug("<< item_num >> : " + item_num);
		List<SaleSizePriceVO> sspList = tradeService.selectSaleSizePrice(item_num);
		log.debug("<<sspList 크기 >> : " + sspList.size());
		log.debug("<<test>> : " + sspList.get(0));
		ModelAndView mav = new ModelAndView();
		mav.setViewName("selectSize");
		mav.addObject("list", sspList);

		// 아이템 번호로 아이템 정보 구하기 ***********

		return mav;
	}

	/**
	 * ======================================================================================================================
	 * 사이즈 버튼 클릭 시 구매 동의 화면으로 이동
	 * ======================================================================================================================
	 **/
	@GetMapping("/purchase/check.do")
	public String getPurchaseAgree(@RequestParam int item_num, @RequestParam int item_sizenum,
			@RequestParam String item_size, Model model, HttpSession session) {

		// Login인터셉터로 로그인 되어있는지 확인필요 ***********

		// 아이템 번호로 아이템 정보 구해서 넘기기 *********

		model.addAttribute("item_num", item_num); // item 정보를 구하게 된다면 vo 객체를 넘겨줄거임
		model.addAttribute("item_sizenum", item_sizenum);
		model.addAttribute("item_size", item_size);

		return "check";
	}

	/**
	 * ======================================================================================================================
	 * 구매 : 구매 계속 버튼 클릭 시 구매 관련 상세 정보 처리
	 * ======================================================================================================================
	 **/
	// 구매 기본 화면 구성
	@GetMapping("/purchase/purchaseDetail.do")
	public String getPurchaseDetail(@RequestParam int item_num, @RequestParam int item_sizenum,
			@RequestParam String item_size, Model model, HttpSession session) {

		// Login인터셉터로 로그인 되어있는지 확인 필요 ****************

		// 판매입찰 정보가 등록되어 있는지 확인
		int saleBidCount = tradeService.selectGetSaleBidByItemAndSize(item_num, item_sizenum);
		// 구매입찰 정보가 등록되어 있는지 확인
		int purchaseBidCount = tradeService.selectGetPurchaseBidByItemAndSize(item_num, item_sizenum);
		// 즉시 구매가 정보 넘기기
		int minSaleBid = 0;
		if (saleBidCount > 0) {
			minSaleBid = tradeService.selectMinSaleBid(item_num, item_sizenum);
		} else {
			minSaleBid = 0; // 입찰 정보가 없기 때문에 아이템 정가가 들어가야함 *********************************
		}

		// 즉시 판매가 정보 넘기기
		int maxPurchaseBid = 0;
		if (purchaseBidCount > 0) {
			maxPurchaseBid = tradeService.selectMaxPurchaseBid(item_num, item_sizenum);
		} else {
			maxPurchaseBid = 0; // 입찰 정보가 없기 때문에 아이템 정가가 들어가야함 *********************************
		}

		model.addAttribute("minSaleBid", minSaleBid); // 즉시 구매가
		model.addAttribute("maxPurchaseBid", maxPurchaseBid); // 즉시 판매가
		model.addAttribute("item_num", item_num);
		model.addAttribute("item_size", item_size);
		model.addAttribute("item_sizenum", item_sizenum);
		model.addAttribute("saleBidCount", saleBidCount);
		// 아이템 번호로 아이템 정보 구해서 넘기기 *********
		// 구매자 정보 넘기기 **************
		return "purchaseDetail";
	}

	// 구매 입찰 버튼 클릭 시 통신
	@RequestMapping("/purchase/paymentPurchaseBid.do")
	@ResponseBody
	public Map<String, Object> getPaymentPurchaseBid(@RequestParam int minSaleBid, @RequestParam int item_num,
			@RequestParam int item_sizenum, @RequestParam String item_size, @RequestParam String deadline,
			@RequestParam int purchase_price, @RequestParam String dateDeadline, @RequestParam String type,
			HttpSession session) {
		Map<String, Object> mapJson = new HashMap<String, Object>();
		// 로그인 되어있는지 체크
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 구매 입찰을 등록했는지 체크
		PurchaseBidVO pbVO = null;

		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			pbVO = tradeService.selectPurchaseBidByUserNum(user.getMem_num(), item_num);
			MemberVO member = memberService.selectMember(user.getMem_num());
			if (pbVO == null || type.equals("1")) {
				log.debug("<<dateDeadline >> : " + dateDeadline);
				log.debug("<<purchase_price >> : " + purchase_price);
				log.debug("<<minSaleBid >> : " + minSaleBid);
				mapJson.put("minSaleBid", minSaleBid);
				mapJson.put("item_num", item_num);
				mapJson.put("item_sizenum", item_sizenum);
				mapJson.put("deadline", Integer.parseInt(deadline));
				mapJson.put("purchase_price", purchase_price);
				mapJson.put("member", member);
				mapJson.put("dateDeadline", dateDeadline);
				mapJson.put("result", "success");
				mapJson.put("type", type);
			} else {
				mapJson.put("result", "duplicated");
			}
		}
		return mapJson;
	}

	// 구매입찰 - 결제하기 버튼 클릭 시
	@PostMapping("/purchase/purchasePaymentBid.do")
	public String paymentBidFinish(PurchaseBidVO pbVO, @RequestParam int total, Model model, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) {
			model.addAttribute("message", "로그인이 필요합니다!");
			model.addAttribute("url", "../member/login.do");
		} else {
			pbVO.setMem_num(user.getMem_num());
			tradeService.insertPurchaseBid(pbVO);
			// total로 결제 금액 결제 진행 하기

			model.addAttribute("message", "[구매입찰] 결제가 완료되었습니다.");
			model.addAttribute("url", "../item/itemList.do");
		}

		return "common/resultView";
	}

	// 즉시구매 - 결제하기 버튼 클릭 시
	@PostMapping("/purchase/purchasePaymentDirect.do")
	public String paymentDirectFinish(TradeVO tradeVO, @RequestParam int sale_price, Model model, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) {
			model.addAttribute("message", "로그인이 필요합니다!");
			model.addAttribute("url", "../member/login.do");
		} else {
			int seller_num = tradeService.selectSellerNum(tradeVO.getItem_num(), tradeVO.getItem_sizenum(), sale_price);
			if(seller_num == user.getMem_num()) {
				model.addAttribute("message","본인이 등록한 입찰 정보로 즉시 구매 할 수 없습니다.");
				model.addAttribute("url","../item/itemList.do");
			}else {
				// 거래 정보 저장을 위한 거래 번호 생성
				int trade_num = tradeService.selectTradeNum();
				int mem_num = seller_num;
				int sale_num = tradeService.selectSaleBidNumber(mem_num, tradeVO.getItem_num(), sale_price);
				tradeVO.setTrade_num(trade_num);
				tradeVO.setBuyer_num(user.getMem_num());
				tradeVO.setSeller_num(seller_num);
	
				tradeService.insertTrade(tradeVO);
				// 판매입찰 정보 삭제
				tradeService.deleteSaleBid(sale_num);
				model.addAttribute("message", "[즉시구매] 결제를 완료했습니다.");
				model.addAttribute("url", "../item/itemList.do");
				
				// total로 결제 진행하기
			}
		}
		return "common/resultView";
	}

	/**
	 * ======================================================================================================================
	 * 판매하기 버튼 클릭 시 상품에 따른 사이즈 정보 제공
	 * ======================================================================================================================
	 **/
	@GetMapping("/sale/selectSaleSize.do")
	public ModelAndView getSaleItemAndSize(@RequestParam int item_num) {

		// Login인터셉터로 로그인 되어있는지 확인필요 ***********

		// 사이즈 별 구매 입찰 정보를 뿌리기
		log.debug("<< item_num >> : " + item_num);
		List<PurchaseSizePriceVO> pspList = tradeService.selectPurchaseSizePrice(item_num);
		log.debug("<<sspList 크기 >> : " + pspList.size());
		log.debug("<<test>> : " + pspList.get(0));
		ModelAndView mav = new ModelAndView();
		mav.setViewName("selectSaleSize");
		mav.addObject("list", pspList);

		// 아이템 번호로 아이템 정보 구하기 ***********

		return mav;
	}

	/**
	 * ======================================================================================================================
	 * 사이즈 버튼 클릭 시 판매 동의 화면으로 이동
	 * ======================================================================================================================
	 **/
	@GetMapping("/sale/checkSale.do")
	public String getSaleAgree(@RequestParam int item_num, @RequestParam int item_sizenum,
			@RequestParam String item_size, Model model, HttpSession session) {

		// Login인터셉터로 로그인 되어있는지 확인필요 ***********

		// 아이템 번호로 아이템 정보 구해서 넘기기 *********

		model.addAttribute("item_num", item_num); // item 정보를 구하게 된다면 vo 객체를 넘겨줄거임
		model.addAttribute("item_sizenum", item_sizenum);
		model.addAttribute("item_size", item_size);

		return "checkSale";
	}

	/**
	 * ======================================================================================================================
	 * 판매 : 판매 계속 버튼 클릭 시 판매 관련 상세 정보 처리
	 * ======================================================================================================================
	 **/
	// 판매 기본 화면 구성
	@GetMapping("/sale/saleDetail.do")
	public String getSaleDetail(@RequestParam int item_num, @RequestParam int item_sizenum,
			@RequestParam String item_size, Model model, HttpSession session) {

		// Login인터셉터로 로그인 되어있는지 확인 필요 ****************

		// 판매입찰 정보가 등록되어 있는지 확인
		int saleBidCount = tradeService.selectGetSaleBidByItemAndSize(item_num, item_sizenum);
		// 구매입찰 정보가 등록되어 있는지 확인
		int purchaseBidCount = tradeService.selectGetPurchaseBidByItemAndSize(item_num, item_sizenum);
		// 즉시 구매가 정보 넘기기
		int minSaleBid = 0;
		if (saleBidCount > 0) {
			minSaleBid = tradeService.selectMinSaleBid(item_num, item_sizenum);
		} else {
			minSaleBid = 0; // 입찰 정보가 없기 때문에 아이템 정가가 들어가야함 *********************************
		}

		// 즉시 판매가 정보 넘기기
		int maxPurchaseBid = 0;
		if (purchaseBidCount > 0) {
			maxPurchaseBid = tradeService.selectMaxPurchaseBid(item_num, item_sizenum);
		} else {
			maxPurchaseBid = 0; // 입찰 정보가 없기 때문에 아이템 정가가 들어가야함 *********************************
		}

		model.addAttribute("minSaleBid", minSaleBid); // 즉시 구매가
		model.addAttribute("maxPurchaseBid", maxPurchaseBid); // 즉시 판매가
		model.addAttribute("item_num", item_num);
		model.addAttribute("item_size", item_size);
		model.addAttribute("item_sizenum", item_sizenum);
		model.addAttribute("purchaseBidCount", purchaseBidCount);
		// 아이템 번호로 아이템 정보 구해서 넘기기 *********
		// 구매자 정보 넘기기 **************
		return "saleDetail";
	}

	// 판매 입찰 버튼 클릭 시 통신
	@RequestMapping("/sale/paymentSaleBid.do")
	@ResponseBody
	public Map<String, Object> getPaymentSaleBid(@RequestParam int maxPurchaseBid, 
												 @RequestParam int item_num,
												 @RequestParam int item_sizenum, 
												 @RequestParam String item_size, 
												 @RequestParam String deadline,
												 @RequestParam int sale_price, 
												 @RequestParam String dateDeadline, 
												 @RequestParam String type,
												 HttpSession session) {
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		// 로그인 되어있는지 체크
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 판메 입찰을 등록했는지 체크
		SaleBidVO sbVO = null;

		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			sbVO = tradeService.selectSaleBidByUserNum(user.getMem_num(), item_num);
			MemberVO member = memberService.selectMember(user.getMem_num());
			if (sbVO == null || type.equals("1")) {
				log.debug("<<dateDeadline >> : " + dateDeadline);
				log.debug("<<sale_price >> : " + sale_price);
				log.debug("<<maxPurchaseBid >> : " + maxPurchaseBid);
				mapJson.put("maxPurchaseBid", maxPurchaseBid);
				mapJson.put("item_num", item_num);
				mapJson.put("item_sizenum", item_sizenum);
				mapJson.put("deadline", Integer.parseInt(deadline));
				mapJson.put("sale_price", sale_price);
				mapJson.put("member", member);
				mapJson.put("dateDeadline", dateDeadline);
				mapJson.put("result", "success");
				mapJson.put("type", type);
			} else {
				mapJson.put("result", "duplicated");
			}
		}
		return mapJson;
	}
	// 판매입찰 - 판매입찰하기 버튼 클릭 시
	@PostMapping("/sale/salePaymentBid.do")
	public String saleBidFinish(SaleBidVO sbVO, @RequestParam int total, Model model, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) {
			model.addAttribute("message", "로그인이 필요합니다!");
			model.addAttribute("url", "../member/login.do");
		} else {
			sbVO.setMem_num(user.getMem_num());
			tradeService.insertSaleBid(sbVO);
			// 수수료 계산하기

			model.addAttribute("message", "[판매입찰] 완료되었습니다.");
			model.addAttribute("url", "../item/itemList.do");
		}

		return "common/resultView";
	}

	// 즉시판매 - 즉시판매하기 버튼 클릭 시
	@PostMapping("/sale/salePaymentDirect.do")
	public String saleDirectFinish(TradeVO tradeVO, @RequestParam int purchase_price, Model model, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) {
			model.addAttribute("message", "로그인이 필요합니다!");
			model.addAttribute("url", "../member/login.do");
		} else {
			int buyer_num = tradeService.selectBuyerNum(tradeVO.getItem_num(), tradeVO.getItem_sizenum(), purchase_price);
			if(buyer_num == user.getMem_num()) {
				model.addAttribute("message","본인이 등록한 입찰 정보로 즉시 판매할 수 없습니다.");
				model.addAttribute("url","../item/itemList.do");
			}else {
				// 거래 정보 저장을 위한 거래 번호 생성
				int trade_num = tradeService.selectTradeNum();
				int mem_num = buyer_num;
				int purchase_num = tradeService.selectPurchaseBidNumber(mem_num, tradeVO.getItem_num(), purchase_price);
				tradeVO.setTrade_num(trade_num);
				tradeVO.setBuyer_num(buyer_num);
				tradeVO.setSeller_num(user.getMem_num());
	
				tradeService.insertTrade(tradeVO);
				
				// 구매 입찰 정보 삭제
				tradeService.deletePurchaseBid(purchase_num);
				model.addAttribute("message", "[즉시판매] 완료했습니다.");
				model.addAttribute("url", "../item/itemList.do");
				
				// 수수료 계산
			}
		}
		return "common/resultView";
	}
	
	@RequestMapping("/myPage/buying.do")
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
			page = new PagingUtil(currentPage,count,10,5,"/myPage/buying.do");
			
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
			
			page = new PagingUtil(currentPage,count,10,5,"/myPage/buying.do");
			
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
			
			page = new PagingUtil(currentPage,count,10,5,"/myPage/buying.do");
			
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

}
