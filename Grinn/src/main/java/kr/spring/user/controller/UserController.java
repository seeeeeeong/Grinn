package kr.spring.user.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.item.vo.ItemVO;
import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.trade.vo.TradeVO;
import kr.spring.user.service.UserService;
import kr.spring.util.AuthCheckException;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	/*
	 * =========================== 자바빈 초기화 ===========================
	 */
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	
	@ModelAttribute
	public ItemVO initItemVO() {
		return new ItemVO();
	}
	
	@ModelAttribute
	public StyleVO initStyleVO() {
		return new StyleVO();
	}
	/*
	 * =========================== MY페이지 ===========================
	 */
	
	/*
	 * 클라이언트에서 /user/myPage.do URL로 요청이 들어오면 메서드 실행
	 * 
	 * HttpSession은 클라이언트와 서버 간의 세션 정보를 관리하는 객체,
	 * 여기서는 사용자의 세션 정보를 저장하고 있는 session 객체를 받아옴
	 * 
	 * Model 객체는 뷰에 데이터를 전달하기 위한 객체
	 */
	
	@GetMapping("/user/myPage.do")
	public String myPage(HttpSession session,Model model) {
		
		/*
		 * session 객체에서 user라는 이름으로 저장된 사용자 정보를 가져옴
		 * user는 로그인한 사용자 정보가 저장되어 있는 세션의 속성 이름
		 * 예를 들어, 로그인 성공시 사용자 정보를 MemberVO 형태로 세션에 저장
		 */
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		/*
		 * UserService를 통해 회원 정보를 조회하기 위해 user.getMem_num()을 통해
		 * 사용자의 회원번호를 얻어와 회원 정보를 조회
		 */
		MemberVO member = userService.selectMember(user.getMem_num());
		
		/*
		 * 조회한 회원 정보를 member라는 이름으로 Model에 추가,
		 * Model에 추가한 데이터는 뷰에서 사용 가능
		 */
		model.addAttribute("member", member);
		
	    //mem_photo, mem_nickname, mem_email, mem_auth, mem_point Model에 추가
	    model.addAttribute("mem_photo", member.getMem_photo());
	    model.addAttribute("mem_nickname", member.getMem_nickname());
	    model.addAttribute("mem_email", member.getMem_email());
	    model.addAttribute("mem_num", member.getMem_num());
	    
	    //mem_auth 값이 2이면 "일반회원", 9이면 "관리자"로 표시
	    String memAuthText = (member.getMem_auth() == 2) ? "일반회원" : (member.getMem_auth() == 9) ? "관리자" : "";
	    model.addAttribute("mem_auth", memAuthText);
	    model.addAttribute("mem_point", member.getMem_point());
		
		//구매 상품 - trade
	    List<TradeVO> purchasedTrades = userService.selectPurchasedTrades(user.getMem_num());
	    model.addAttribute("purchasedTrades", purchasedTrades);
	    
	    //구매 상품 - item
		List<ItemVO> purchasedItems = userService.selectPurchasedItems(user.getMem_num());
		model.addAttribute("purchasedItems", purchasedItems);
		
        //구매 상품 - Size
        List<ItemSizeVO> purchasedItemSize = userService.selectPurchasedItemSize(user.getMem_num());
        model.addAttribute("purchasedItemSize", purchasedItemSize);
		
		//판매 상품 - trade
		List<TradeVO> selectSoldTrades = userService.selectSoldTrades(user.getMem_num());
		model.addAttribute("selectSoldTrades", selectSoldTrades);	
	
		//판매 상품 - item
        List<ItemVO> soldItems = userService.selectSoldItems(user.getMem_num());
        model.addAttribute("soldItems", soldItems);
        
        //판매 상품 - Size
        List<ItemSizeVO> soldItemSize = userService.selectSoldItemSize(user.getMem_num());
        model.addAttribute("soldItemSize", soldItemSize);
        
        //관심 상품
        List<ItemVO> favoriteItems = userService.selectFavoriteItems(user.getMem_num());
        model.addAttribute("favoriteItems", favoriteItems);
		
		/*
		 * myPage라는 뷰를 찾아 해당 데이터를 사용하여 뷰를 렌더링
		 */
		return "myPage";
	}
	
	
	/*
	 * =========================== 아이템 사진 ===========================
	 */
	@GetMapping("/user/ItemImageView.do")
	public String ItemImageView(@RequestParam int item_num, Model model) {
	    ItemVO ItemVO = userService.selectItem(item_num);
			
	    model.addAttribute("imageFile", ItemVO.getItem_photo1());
		model.addAttribute("filename", ItemVO.getItem_photo1name());
		
	    return "imageView";
	}
	
	/*=======================
	 * 프로필 사진 출력
	 *=======================*/
	//프로필 사진 출력(로그인 전용)
	@RequestMapping("/user/photoView.do")
	public String getProfile(HttpSession session,
			                 HttpServletRequest request,
			                 Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		log.debug("<<photoView>> : " + user);
		
		if(user==null) {//로그인 안 된 경우
			//기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(
					      request.getServletContext().getRealPath(
					    		                "/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		}else {//로그인 된 경우
			MemberVO memberVO = 
				userService.selectMember(user.getMem_num());
			viewProfile(memberVO,request,model);
		}
		
		return "imageView";
	}
	
	//프로필 사진 출력(회원번호 지정)
	@RequestMapping("/user/viewProfile.do")
	public String getProfileByMem_num(
			            @RequestParam int mem_num,
			            HttpServletRequest request,
			            Model model) {
		MemberVO memberVO = 
				userService.selectMember(mem_num);
		viewProfile(memberVO,request,model);		
		
		return "imageView";
	}
	
	//프로필 사진 처리를 위한 공통 코드
	public void viewProfile(MemberVO memberVO,
			                HttpServletRequest request,
			                Model model) {
		if(memberVO==null || memberVO.getMem_photo_name()==null) {
			//기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(
					      request.getServletContext().getRealPath(
					    		                "/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		}else {//업로드한 프로필 사진이 있는 경우
			model.addAttribute("imageFile", memberVO.getMem_photo());
			model.addAttribute("filename", memberVO.getMem_photo_name());
		}
	}
	
	/*=======================
	 * 프로필 사진 업데이트
	 *=======================*/
	@RequestMapping("/user/updateMyPhoto.do")
	@ResponseBody
	public Map<String,String> updateProfile(MemberVO memberVO,
			HttpSession session){
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapAjax.put("result", "logout");
		}else {
			memberVO.setMem_num(user.getMem_num());
			userService.updateProfile(memberVO);
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
	
	
	/*
	 * =========================== 쇼핑 정보 - 구매 내역 ===========================
	 */
    @GetMapping("/user/userPurchasedItems.do")
    public String purchasedItemsPage(HttpSession session, Model model) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");

        //구매 상품 - trade
	    List<TradeVO> purchasedTrades = userService.selectPurchasedTrades(user.getMem_num());
	    model.addAttribute("purchasedTrades", purchasedTrades);
	    
	    //구매 상품 - item
		List<ItemVO> purchasedItems = userService.selectPurchasedItems(user.getMem_num());
		model.addAttribute("purchasedItems", purchasedItems);
		
        //구매 상품 - Size
        List<ItemSizeVO> purchasedItemSize = userService.selectPurchasedItemSize(user.getMem_num());
        model.addAttribute("purchasedItemSize", purchasedItemSize);

        //purchasedItems 페이지로 이동
        return "userPurchasedItems";
    }
    
	/*
	 * =========================== 쇼핑 정보 - 판매 내역 ===========================
	 */
    @GetMapping("/user/userSoldItems.do")
    public String soldItemsPage(HttpSession session, Model model) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");

		//판매 상품 - trade
		List<TradeVO> selectSoldTrades = userService.selectSoldTrades(user.getMem_num());
		model.addAttribute("selectSoldTrades", selectSoldTrades);	
	
		//판매 상품 - item
        List<ItemVO> soldItems = userService.selectSoldItems(user.getMem_num());
        model.addAttribute("soldItems", soldItems);
        
        //판매 상품 - Size
        List<ItemSizeVO> soldItemSize = userService.selectSoldItemSize(user.getMem_num());
        model.addAttribute("soldItemSize", soldItemSize);
        
        //purchasedItems 페이지로 이동
        return "userSoldItems";
    }
    
	/*
	 * =========================== 쇼핑 정보 - 관심 상품 ===========================
	 */
    @GetMapping("/user/userFavoriteItems.do")
    public String favoriteItemsPage(HttpSession session, Model model) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");

        //판매 내역 조회
        List<ItemVO> favoriteItems = userService.selectFavoriteItems(user.getMem_num());
        model.addAttribute("favoriteItems", favoriteItems);
        
        //favoriteItems 페이지로 이동
        return "userFavoriteItems";
    }
    
	/*
	 * =========================== 쇼핑 정보 - 좋아요 ===========================
	 */
    @GetMapping("/user/userLikedStyles.do")
    public String likedStylesPage(HttpSession session, Model model) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        //좋아요한 게시물 조회
        List<StyleVO> likedStyles = userService.selectLikedStyles(user.getMem_num());
        model.addAttribute("likedStyles", likedStyles);
        
        List<String> memId = userService.selectStyleId(user.getMem_num());
        model.addAttribute("memId", memId);
        
        //likedStyles 페이지로 이동
        return "userLikedStyles";
    }
    
	/*
	 * =========================== 좋아요 사진 ===========================
	 */
	@GetMapping("/user/StyleImageView.do")
	public String StyleImageView(@RequestParam int st_num, Model model) {
	    StyleVO StyleVO = userService.selectStyle(st_num);
			
	    model.addAttribute("imageFile", StyleVO.getSt_photo1());
		model.addAttribute("filename", StyleVO.getSt_photo1n());
		
	    return "imageView";
	}
	
	/*
	 * =========================== 좋아요 작성자 ===========================
	 */

    
    /*
     * =========================== 내 정보 - 로그인 정보 ===========================
     */
    @GetMapping("/user/userLoginInfo.do")
    public String loginInfo(HttpSession session, Model model) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");

        //회원 정보 조회
        MemberVO member = userService.selectMember(user.getMem_num());

        //회원 정보 Model에 추가
        model.addAttribute("member", member);

        //action 파라미터가 없거나 잘못된 값일 경우 기본 페이지로 이동
        return "userLoginInfo";
    }

    //이메일 변경
    @PostMapping("/user/updateEmail")
    @ResponseBody
    public String updateEmail(@RequestParam("newEmail") String newEmail, HttpSession session) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        //회원 정보 조회
        MemberVO member = userService.selectMember(user.getMem_num());
        	
        //회원 정보에 새로운 이메일 설정
        member.setMem_email(newEmail);
        
        //회원 정보 업데이트
        userService.updateEmail(member);
        
        return "success";
    }

    //전화번호 변경
    @PostMapping("/user/updatePhoneNumber")
    @ResponseBody
    public String updatePhoneNumber(@RequestParam("newPhone") String newPhone, HttpSession session) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        //회원 정보 조회
        MemberVO member = userService.selectMember(user.getMem_num());
        	
        //회원 정보에 새로운 전화번호 설정
        member.setMem_phone(newPhone);
        
    	userService.updatePhoneNumber(member);
        return "success";
    }
        
    //주소 변경
    @PostMapping("/user/saveAddress")
    @ResponseBody
    public String saveAddress(@RequestParam String zipcode,
                              @RequestParam String address1,
                              @RequestParam String address2, HttpSession session) {
    	//로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        //회원 정보 조회
        MemberVO member = userService.selectMember(user.getMem_num());
        	
        //회원 정보에 새로운 주소 설정
        member.setMem_zipcode(zipcode);
        member.setMem_address1(address1);
        member.setMem_address2(address2);

        if(member.getMem_zipcode() == null) {
        	userService.addShippingAddress(member);
        }else {
        	userService.updateShippingAddress(member);
        }        
        return "success";
    }
    
    //닉네임 변경
    @PostMapping("/user/modifyNickname")
    @ResponseBody
    public String modifyNickname(@RequestParam("newNickname") String newNickname, HttpSession session) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        //회원 정보 조회
        MemberVO member = userService.selectMember(user.getMem_num());
        	
        //회원 정보에 새로운 닉네임 설정
        member.setMem_nickname(newNickname);
        
        if(member.getMem_nickname() == null) {
        	userService.addNickname(member);
        }else {
        	userService.updateNickname(member);
        }
        return "success";
    }

    //소개글 변경
    @PostMapping("/user/modifyInt")
    @ResponseBody
    public String modifyInt(@RequestParam("newInt") String newInt, HttpSession session) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        //회원 정보 조회
        MemberVO member = userService.selectMember(user.getMem_num());
        	
        //회원 정보에 새로운 소개글 설정
        member.setMem_int(newInt);
        
        if(member.getMem_int() == null) {
        	userService.addIntroduction(member);
        }else {
        	userService.updateInt(member);
        }
        return "success";
    }

    //비밀번호 변경
    @PostMapping("/user/updatePassword")
    @ResponseBody
    public String updatePassword(@ModelAttribute MemberVO member) {
        userService.updatePassword(member);
        return "success"; 
    }
    
	//주소 변경
	@PostMapping("/user/addressUpdate.do")
	public String addressUpdate(@Valid MemberVO memberVO,
			BindingResult result, Model model, HttpSession session) {
		 //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        //회원 정보 조회
        MemberVO member = userService.selectMember(user.getMem_num());
		
		//회원 정보에 새로운 주소 설정
        member.setMem_zipcode(memberVO.getMem_zipcode());
        member.setMem_address1(memberVO.getMem_address1());
        member.setMem_address2(memberVO.getMem_address2());
        		
        if(member.getMem_zipcode() == null) {
        	userService.addShippingAddress(member);
        }else {
        	userService.updateShippingAddress(member);
        }
        return "success";      
	}
    
	/*=======================
	 * 회원탈퇴(회원정보삭제)
	 *=======================*/
	//회원탈퇴 폼 호출
	//회원 탈퇴
	@GetMapping("/user/delete.do")
	public String formDelete() {
		return "userDelete";
	}
	//전송된 데이터 처리
	@PostMapping("/user/delete.do")
	public String submitDelete(@Valid MemberVO memberVO,
			            BindingResult result, HttpSession session,
			            Model model) {
		log.debug("<<회원탈퇴>> : " + memberVO);
		
		//id와 passwd 필드만 유효성 체크, 유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasFieldErrors("mem_id") || 
				result.hasFieldErrors("mem_passwd")) {
			return formDelete();
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO db_member = 
				userService.selectMember(user.getMem_num());
		boolean check = false;
		//아이디, 비밀번호 일치 여부 체크
		try {
			if(db_member!=null && 
					db_member.getMem_id().equals(memberVO.getMem_id())) {
				//비밀번호 일치 여부 체크
				check = db_member.isCheckedPassword(
						              memberVO.getMem_passwd());
			}
			if(check) {
				//인증 성공, 회원정보 삭제
				userService.deleteMember(user.getMem_num());
				//로그아웃
				session.invalidate();
				
				model.addAttribute("accessMsg", 
						   "회원탈퇴를 완료했습니다.");
				return "common/notice";
			}
			//인증 실패
			throw new AuthCheckException();
		}catch(AuthCheckException e) {
			result.reject("invalidIdOrPassword");
			return formDelete();
		}
	}
	
    /*
     * =========================== 페널티 정보 조회 ===========================
     */
    @GetMapping("/user/userPenaltyInfo.do")
    public String getPenaltyInfo(HttpSession session, Model model) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");

        //패널티 통합 점수 조회
        Integer pe_total = userService.getPenaltyTotalScore(user.getMem_num());
        model.addAttribute("pe_total", pe_total);

        //게시판 페널티 조회
        List<MemberVO> penaltyBoardList = userService.getPenaltyBoard(user.getMem_num());
        model.addAttribute("penaltyBoardList", penaltyBoardList);

        //거래 페널티 조회
        List<MemberVO> penaltyTradeList = userService.getPenaltyTrade(user.getMem_num());
        model.addAttribute("penaltyTradeList", penaltyTradeList);

        //penaltyInfo.jsp로 이동
        return "userPenaltyInfo";
    }   
}
