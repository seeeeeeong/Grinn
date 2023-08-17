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

import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
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
	@Autowired
	ItemService itemService;
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
		ItemVO item = itemService.selectItem(item_num);
		mav.addObject("item",item);
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
		ItemVO item = itemService.selectItem(item_num);

		model.addAttribute("item_num", item_num); // item 정보를 구하게 된다면 vo 객체를 넘겨줄거임
		model.addAttribute("item_sizenum", item_sizenum);
		model.addAttribute("item_size", item_size);
		model.addAttribute("item",item);
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
		ItemVO item = itemService.selectItem(item_num);
		model.addAttribute("item",item);
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
	public String paymentBidFinish(PurchaseBidVO pbVO,
								   @RequestParam String trade_zipcode,
								   @RequestParam String trade_address1,
								   @RequestParam String trade_address2,
								   @RequestParam int total, Model model, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) {
			model.addAttribute("message", "로그인이 필요합니다!");
			model.addAttribute("url", "../member/login.do");
		} else {
			pbVO.setMem_num(user.getMem_num());
			// total로 결제 금액 결제 진행 하기 **************************************************************
			MemberVO member = memberService.selectMember(user.getMem_num());
			
			if(member.getMem_point() - total < 0) {
				model.addAttribute("message","잔액이 부족합니다. 금액을 충전해주세요.");
				model.addAttribute("url","../item/itemList.do");
				return "common/resultView";
			}else {
				tradeService.executePayment(total); // 관리자에게 입금
				// 포인트 차감 진행.
				tradeService.spendPoint(user.getMem_num(), total);
				pbVO.setPurchase_zipcode(trade_zipcode);
				pbVO.setPurchase_address1(trade_address1);
				pbVO.setPurchase_address2(trade_address2);
				tradeService.insertPurchaseBid(pbVO);
				
			}
			model.addAttribute("message", "[구매입찰] 결제가 완료되었습니다.");
			model.addAttribute("url", "../item/itemList.do");
		}

		return "common/resultView";
	}

	// 즉시구매 - 결제하기 버튼 클릭 시
	@PostMapping("/purchase/purchasePaymentDirect.do")
	public String paymentDirectFinish(TradeVO tradeVO, 
									  @RequestParam String trade_zipcode,
									  @RequestParam String trade_address1,
									  @RequestParam String trade_address2,
									  @RequestParam int total, Model model, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) {
			model.addAttribute("message", "로그인이 필요합니다!");
			model.addAttribute("url", "../member/login.do");
		}else{
			int seller_num = tradeService.selectSellerNum(tradeVO.getItem_num(), tradeVO.getItem_sizenum(), tradeVO.getTrade_price());
			if(seller_num == user.getMem_num()) {
				model.addAttribute("message","본인이 등록한 입찰 정보로 즉시 구매 할 수 없습니다.");
				model.addAttribute("url","../item/itemList.do");
				return "common/resultView";
			}else {
				MemberVO member = memberService.selectMember(user.getMem_num());
				
				if(total > member.getMem_point()) {
					model.addAttribute("message","잔액이 부족합니다. 금액을 충전해주세요.");
					model.addAttribute("url","../item/itemList.do");
					return "common/resultView";
				}
				// 거래 정보 저장을 위한 거래 번호 생성
				int trade_num = tradeService.selectTradeNum();
				int mem_num = seller_num;
				int sale_num = tradeService.selectSaleBidNumber(mem_num, tradeVO.getItem_num(), tradeVO.getTrade_price());
				
				// 판매입찰 정보에서 등록한 판매자 반환주소 정보 받아오기
				SaleBidVO sbvo = tradeService.selectSaleBidBySaleNum(sale_num);
				// 판매자 반환주소 설정
				tradeVO.setTrade_sendZipcode(sbvo.getSale_zipcode());
				tradeVO.setTrade_sendAddress1(sbvo.getSale_address1());
				tradeVO.setTrade_sendAddress2(sbvo.getSale_address2());
				
				// 구매자 배송 주소 설정
				tradeVO.setTrade_rcvZipcode(trade_zipcode);
				tradeVO.setTrade_rcvAddress1(trade_address1);
				tradeVO.setTrade_rcvAddress2(trade_address2);
				
				tradeVO.setTrade_num(trade_num);
				tradeVO.setBuyer_num(user.getMem_num());
				tradeVO.setSeller_num(seller_num);
				
				// 관리자에게 입금
				tradeService.executePayment(total);
				tradeService.spendPoint(user.getMem_num(), total);
				
				// 구매입찰을 등록했는데 즉시구매를 했을 경우
				PurchaseBidVO pbVO = null;
				pbVO = tradeService.selectPurchaseBidForDirectBuy(user.getMem_num(), tradeVO.getItem_num(), tradeVO.getItem_sizenum());
				if(pbVO != null) {
					if(pbVO.getMem_num() == user.getMem_num()) {
						// 입금했던 거래가 다시 반환
						int deposit = 0;
						if(pbVO.getPurchase_price() < 50000) {
							deposit += 3000;
						}
						deposit += (pbVO.getPurchase_price() / 10);
						deposit += pbVO.getPurchase_price();
						// 사용자 포인트 반환
						tradeService.sendPointToBuyer(user.getMem_num(), deposit);
						// 관리자 포인트 차감
						tradeService.cancelExecutePayment(deposit);
						
						// 구매 입찰 정보 삭제
						tradeService.deletePurchaseBid(pbVO.getPurchase_num());
					}
				}
				tradeService.insertTrade(tradeVO);
				// 판매입찰 정보 삭제
				tradeService.deleteSaleBid(sale_num);
				model.addAttribute("message", "[즉시구매] 결제를 완료했습니다.");
				model.addAttribute("url", "../item/itemList.do");
			}
		}
		return "common/resultView";
	}

	/**
	 * ======================================================================================================================
	 * 판매하기 버튼 클릭 시 상품에 따른 사이즈 정보 제공
	 * ======================================================================================================================
	 **/
	@GetMapping("/sale/selectSize.do")
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
		ItemVO item = itemService.selectItem(item_num);
		mav.addObject("item",item);
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
		ItemVO item = itemService.selectItem(item_num);

		model.addAttribute("item_num", item_num); // item 정보를 구하게 된다면 vo 객체를 넘겨줄거임
		model.addAttribute("item_sizenum", item_sizenum);
		model.addAttribute("item_size", item_size);
		model.addAttribute("item",item);
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
		ItemVO item = itemService.selectItem(item_num);
		model.addAttribute("item",item);
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
	public String saleBidFinish(SaleBidVO sbVO,
								@RequestParam String trade_zipcode,
							    @RequestParam String trade_address1,
							    @RequestParam String trade_address2,
							    @RequestParam int total, Model model, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) {
			model.addAttribute("message", "로그인이 필요합니다!");
			model.addAttribute("url", "../member/login.do");
		} else {
			sbVO.setMem_num(user.getMem_num());
			sbVO.setSale_zipcode(trade_zipcode);
			sbVO.setSale_address1(trade_address1);
			sbVO.setSale_address2(trade_address2);
			tradeService.insertSaleBid(sbVO);

			model.addAttribute("message", "[판매입찰] 완료되었습니다.");
			model.addAttribute("url", "../item/itemList.do");
		}

		return "common/resultView";
	}

	// 즉시판매 - 즉시판매하기 버튼 클릭 시
	@PostMapping("/sale/salePaymentDirect.do")
	public String saleDirectFinish(TradeVO tradeVO,
								   @RequestParam String trade_zipcode,
							       @RequestParam String trade_address1,
							       @RequestParam String trade_address2,
								   @RequestParam int purchase_price, Model model, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) {
			model.addAttribute("message", "로그인이 필요합니다!");
			model.addAttribute("url", "../member/login.do");
		} else {
			int buyer_num = tradeService.selectBuyerNum(tradeVO.getItem_num(), tradeVO.getItem_sizenum(), purchase_price);
			SaleBidVO sbVO = null;
			sbVO = tradeService.selectSaleBidForDirectSell(user.getMem_num(), tradeVO.getItem_num(), tradeVO.getItem_sizenum());
			if(sbVO != null) {
				model.addAttribute("message","이미 등록된 입찰 정보가 있어, 즉시 판매를 할 수 없습니다.");
				model.addAttribute("url","../item/itemList.do");
				return "common/resultView";
			}
			if(buyer_num == user.getMem_num()) {
				model.addAttribute("message","본인이 등록한 입찰 정보로 즉시 판매할 수 없습니다.");
				model.addAttribute("url","../item/itemList.do");
				return "common/resultView";
			}else {
				// 거래 정보 저장을 위한 거래 번호 생성
				int trade_num = tradeService.selectTradeNum();
				int mem_num = buyer_num;
				int purchase_num = tradeService.selectPurchaseBidNumber(mem_num, tradeVO.getItem_num(), purchase_price);
				// 구매자 배송지 정보
				PurchaseBidVO pbvo = tradeService.selectPurchaseBidByPurchaseNum(purchase_num);
				tradeVO.setTrade_rcvZipcode(pbvo.getPurchase_zipcode());
				tradeVO.setTrade_rcvAddress1(pbvo.getPurchase_address1());
				tradeVO.setTrade_rcvAddress2(pbvo.getPurchase_address2());
				
				// 판매자 반송 배송지 정보 설정
				tradeVO.setTrade_sendZipcode(trade_zipcode);
				tradeVO.setTrade_sendAddress1(trade_address1);
				tradeVO.setTrade_sendAddress2(trade_address2);
				
				tradeVO.setTrade_num(trade_num);
				tradeVO.setBuyer_num(buyer_num);
				tradeVO.setSeller_num(user.getMem_num());
				tradeVO.setTrade_price(purchase_price);
				
				tradeService.insertTrade(tradeVO);
				
				// 구매 입찰 정보 삭제
				tradeService.deletePurchaseBid(purchase_num);
				model.addAttribute("message", "[즉시판매] 완료했습니다.");
				model.addAttribute("url", "../item/itemList.do");
			}
		}
		return "common/resultView";
	}
}