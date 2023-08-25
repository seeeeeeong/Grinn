package kr.spring.user.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.item.vo.ItemFavVO;
import kr.spring.item.vo.ItemVO;
import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.penalty.vo.PenaltyVO;
import kr.spring.sbid.vo.SaleBidVO;
import kr.spring.style.vo.StyleFavVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.trade.vo.TradeVO;
import kr.spring.user.service.UserService;
import kr.spring.util.AuthCheckException;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
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
	
	@ModelAttribute
	public PenaltyVO initPenaltyVO() {
		return new PenaltyVO();
	}

	/*
	 * =========================== MY페이지 ===========================
	 */
	@GetMapping("/user/myPage.do")
	public String myPage(HttpSession session, Model model) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		// 로그인되지 않은 상태라면 로그인 페이지로 이동
	    if (user == null) {
	        return "redirect:/member/login.do"; // 로그인 페이지로 리다이렉트
	    }
		
		MemberVO member = userService.selectMember(user.getMem_num());

		model.addAttribute("member", member);

		model.addAttribute("mem_photo", member.getMem_photo());
		model.addAttribute("mem_id", member.getMem_id());
		model.addAttribute("mem_email", member.getMem_email());
		model.addAttribute("mem_num", member.getMem_num());

		String memAuthText = (member.getMem_auth() == 2) ? "일반회원" : (member.getMem_auth() == 9) ? "관리자" : "";
		model.addAttribute("mem_auth", memAuthText);
		model.addAttribute("mem_point", member.getMem_point());

		int purchasedCount = userService.purchasedCount(user.getMem_num());
		int ongoingCount = userService.ongoingCount(user.getMem_num());
		int completedCount = userService.completedCount(user.getMem_num());

		model.addAttribute("purchasedCount", purchasedCount);
		model.addAttribute("ongoingCount", ongoingCount);
		model.addAttribute("completedCount", completedCount);

		List<ItemVO> purchasedItems = userService.purchasedItems(user.getMem_num());
		model.addAttribute("purchasedItems", purchasedItems);

		List<Date> purchasedDate = userService.purchasedDate(user.getMem_num());
		model.addAttribute("purchasedDate", purchasedDate);

		List<Integer> purchasedState = userService.purchasedState(user.getMem_num());
		model.addAttribute("purchasedState", purchasedState);

		int saledCount = userService.saledCount(user.getMem_num());
		int saledOngoingCount = userService.saledOngoingCount(user.getMem_num());
		int saledCompleteCount = userService.saledCompletedCount(user.getMem_num());

		model.addAttribute("saledCount", saledCount);
		model.addAttribute("saledOngoingCount", saledOngoingCount);
		model.addAttribute("saledCompleteCount", saledCompleteCount);

		List<ItemVO> saledItems = userService.saledItems(user.getMem_num());
		model.addAttribute("saledItems", saledItems);

		List<Date> saledDate = userService.saledDate(user.getMem_num());
		model.addAttribute("saledDate", saledDate);

		List<Integer> saledState = userService.saledState(user.getMem_num());
		model.addAttribute("saledState", saledState);

		// 관심 상품
		List<ItemVO> favoriteItems = userService.selectFavoriteItems(user.getMem_num());
		model.addAttribute("favoriteItems", favoriteItems);

		return "myPage";
	}

	/*
	 * =========================== 구매상품 사진 ===========================
	 */
	@GetMapping("/user/purchasedItem.do")
	public String purchasedItemImageView(@RequestParam int item_num, Model model) {
		ItemVO ItemVO = userService.selectItem(item_num);

		model.addAttribute("imageFile", ItemVO.getItem_photo1());
		model.addAttribute("filename", ItemVO.getItem_photo1name());

		return "imageView";
	}

	/*
	 * =========================== 판매상품 사진 ===========================
	 */
	@GetMapping("/user/saledItem.do")
	public String saledItemImageView(@RequestParam int item_num, Model model) {
		ItemVO ItemVO = userService.selectItem(item_num);

		model.addAttribute("imageFile", ItemVO.getItem_photo1());
		model.addAttribute("filename", ItemVO.getItem_photo1name());

		return "imageView";
	}

	/*
	 * =========================== 아이템 사진 ===========================
	 */
	@GetMapping("/user/itemImageView.do")
	public String ItemImageView(@RequestParam int item_num, Model model) {
		ItemVO ItemVO = userService.selectItem(item_num);

		model.addAttribute("imageFile", ItemVO.getItem_photo1());
		model.addAttribute("filename", ItemVO.getItem_photo1name());

		return "imageView";
	}

	/*
	 * ======================= 프로필 사진 출력 =======================
	 */
	// 프로필 사진 출력(로그인 전용)
	@RequestMapping("/user/photoView.do")
	public String getProfile(HttpSession session, HttpServletRequest request, Model model) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		log.debug("<<photoView>> : " + user);

		if (user == null) {// 로그인 안 된 경우
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		} else {// 로그인 된 경우
			MemberVO memberVO = userService.selectMember(user.getMem_num());
			viewProfile(memberVO, request, model);
		}

		return "imageView";
	}

	// 프로필 사진 출력(회원번호 지정)
	@RequestMapping("/user/viewProfile.do")
	public String getProfileByMem_num(@RequestParam int mem_num, HttpServletRequest request, Model model) {
		MemberVO memberVO = userService.selectMember(mem_num);
		viewProfile(memberVO, request, model);

		return "imageView";
	}

	// 프로필 사진 처리를 위한 공통 코드
	public void viewProfile(MemberVO memberVO, HttpServletRequest request, Model model) {
		if (memberVO == null || memberVO.getMem_photo_name() == null) {
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		} else {// 업로드한 프로필 사진이 있는 경우
			model.addAttribute("imageFile", memberVO.getMem_photo());
			model.addAttribute("filename", memberVO.getMem_photo_name());
		}
	}

	/*
	 * ======================= 프로필 사진 업데이트 =======================
	 */
	@RequestMapping("/user/updateMyPhoto.do")
	@ResponseBody
	public Map<String, String> updateProfile(MemberVO memberVO, HttpSession session) {
		Map<String, String> mapAjax = new HashMap<String, String>();

		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {
			mapAjax.put("result", "logout");
		} else {
			memberVO.setMem_num(user.getMem_num());
			userService.updateProfile(memberVO);

			mapAjax.put("result", "success");
		}

		return mapAjax;
	}

	/*
	 * =========================== 쇼핑 정보 - 관심 상품 ===========================
	 */
	@GetMapping("/user/userFavoriteItems.do")
	public String favoriteItemsPage(HttpSession session, Model model,
			@RequestParam(name = "pageNum", defaultValue = "1") int pageNum) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		// 로그인되지 않은 상태라면 로그인 페이지로 이동
	    if (user == null) {
	        return "redirect:/member/login.do"; // 로그인 페이지로 리다이렉트
	    }
		
		// 판매 내역 조회
		List<ItemVO> favoriteItems = userService.selectFavoriteItems(user.getMem_num());

		int totalCount = favoriteItems.size(); // 전체 게시물 수
		int rowCount = 10; // 한 페이지에 보여줄 게시물 수 (원하는 값으로 변경)
		int pageCount = 5; // 한 화면에 보여줄 페이지 수 (원하는 값으로 변경)

		String subUrl = ""; // URL 파라미터를 따로 붙이지 않습니다.

		PagingUtil pagingUtil = new PagingUtil(pageNum, totalCount, rowCount, pageCount, "/user/userFavoriteItems.do",
				subUrl);

		int startRow = pagingUtil.getStartRow();
		int endRow = pagingUtil.getEndRow();

		// 현재 페이지의 게시물들을 추출 (범위를 벗어나지 않도록 조정)
		if (startRow <= totalCount) {
			List<ItemVO> currentPageItems = favoriteItems.subList(startRow - 1, Math.min(endRow, totalCount));
			model.addAttribute("favoriteItems", currentPageItems);
		} else {
			model.addAttribute("favoriteItems", Collections.emptyList());
		}

		model.addAttribute("page", pagingUtil.getPage().toString());

		return "userFavoriteItems";
	}

	/*
	 * =========================== 쇼핑 정보 - 좋아요 ===========================
	 */
	@GetMapping("/user/userLikedStyles.do")
	public String likedStylesPage(HttpSession session, Model model) {
	    // 로그인된 사용자 정보 가져오기
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    // 좋아요한 게시물 조회
	    List<StyleVO> likedStyles = userService.selectLikedStyles(user.getMem_num());

	    // 각 StyleVO에 대해 profileId를 가져와서 리스트에 추가
	    List<String> profileIds = new ArrayList<>();
	    for (StyleVO style : likedStyles) {
	        int st_num = style.getSt_num();
	        String profileId = userService.selectProfileId(st_num);
	        profileIds.add(profileId);
	    }

	    model.addAttribute("likedStyles", likedStyles);
	    model.addAttribute("profileIds", profileIds);

	    // likedStyles 페이지로 이동
	    return "userLikedStyles";
	}


	/*
	 * =========================== 좋아요 사진 ===========================
	 */
	@GetMapping("/user/StyleImageView.do")
	public String styleImageView(@RequestParam int st_num, Model model) {
		StyleVO StyleVO = userService.selectStyle(st_num);

		model.addAttribute("imageFile", StyleVO.getSt_photo1());
		model.addAttribute("filename", StyleVO.getSt_photo1n());

		return "imageView";
	}

	/*
	 * =========================== 좋아요 작성자 프로필 사진 ===========================
	 */
	@GetMapping("user/ProfileImageView.do")
	public String profileImageView(@RequestParam int st_num, Model model, HttpServletRequest request) {
		MemberVO memberVO = userService.selectProfile(st_num);

		if (memberVO == null || memberVO.getMem_photo_name() == null) {
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		} else {// 업로드한 프로필 사진이 있는 경우
			model.addAttribute("imageFile", memberVO.getMem_photo());
			model.addAttribute("filename", memberVO.getMem_photo_name());
		}
		return "imageView";
	}

	/*
	 * ======================== 스타일 좋아요 ========================
	 */
	// 좋아요 읽기
	@RequestMapping("/user/getStyleFav.do")
	@ResponseBody
	public Map<String, Object> getFav(StyleFavVO fav, HttpSession session) {
		log.debug("<<스타일 좋아요 읽기 - StyleFavVO>> : " + fav);

		Map<String, Object> mapJson = new HashMap<String, Object>();

		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {// 로그인이 되지 않은 상태
			mapJson.put("status", "noFav");
		} else {
			// 로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());

			StyleFavVO styleFav = userService.selectFav(fav);
			if (styleFav != null) {
				mapJson.put("status", "yesFav");
			} else {
				mapJson.put("status", "noFav");
			}
		}
		mapJson.put("count", userService.selectFavCount(fav.getSt_num()));

		return mapJson;
	}

	// 좋아요 등록/삭제
	@RequestMapping("/user/writeStyleFav.do")
	@ResponseBody
	public Map<String, Object> writeFav(StyleFavVO fav, HttpSession session) {
		log.debug("<<스타일 좋아요 등록/삭제 - StyleFavVO>> : " + fav);

		Map<String, Object> mapJson = new HashMap<String, Object>();

		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			// 로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());

			StyleFavVO styleFav = userService.selectFav(fav);
			if (styleFav != null) {// 등록한 좋아요가 있으면 삭제
				userService.deleteFav(styleFav.getStfav_num());

				mapJson.put("result", "success");
				mapJson.put("status", "noFav");
			} else {// 등록한 좋아요가 없으면 등록
				userService.insertFav(fav);

				mapJson.put("result", "success");
				mapJson.put("status", "yesFav");
			}
			mapJson.put("count", userService.selectFavCount(fav.getSt_num()));
		}
		return mapJson;
	}

	/*
	 * =========================== 내 정보 - 로그인 정보 ===========================
	 */
	@GetMapping("/user/userLoginInfo.do")
	public String loginInfo(HttpSession session, Model model) {
		// 로그인된 사용자 정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 회원 정보 조회
		MemberVO member = userService.selectMember(user.getMem_num());

		// 회원 정보 Model에 추가
		model.addAttribute("member", member);

		// action 파라미터가 없거나 잘못된 값일 경우 기본 페이지로 이동
		return "userLoginInfo";
	}

	// 이메일 변경
	@PostMapping("/user/updateEmail")
	@ResponseBody
	public String updateEmail(@RequestParam("newEmail") String newEmail, HttpSession session) {
		// 로그인된 사용자 정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 회원 정보 조회
		MemberVO member = userService.selectMember(user.getMem_num());

		// 회원 정보에 새로운 이메일 설정
		member.setMem_email(newEmail);

		// 회원 정보 업데이트
		userService.updateEmail(member);

		return "success";
	}

	// 비밀번호 변경
	@PostMapping("/user/updatePassword")
	@ResponseBody
	public String updatePassword(@RequestParam("newPassword") String newPassword, HttpSession session) {
		// 로그인된 사용자 정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 회원 정보 조회
		MemberVO member = userService.selectMember(user.getMem_num());

		member.setMem_passwd(newPassword);

		userService.updatePassword(member);

		return "success";
	}

	// 전화번호 변경
	@PostMapping("/user/updatePhoneNumber")
	@ResponseBody
	public String updatePhoneNumber(@RequestParam("newPhone") String newPhone, HttpSession session) {
		// 로그인된 사용자 정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 회원 정보 조회
		MemberVO member = userService.selectMember(user.getMem_num());

		// 회원 정보에 새로운 전화번호 설정
		member.setMem_phone(newPhone);

		userService.updatePhoneNumber(member);
		return "success";
	}

	/*
	 * =========================== 내 정보 - 프로필 관리 ===========================
	 */
	@GetMapping("/user/userProfileInfo.do")
	public String ProfileInfo(HttpSession session, Model model) {
		// 로그인된 사용자 정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 회원 정보 조회
		MemberVO member = userService.selectMember(user.getMem_num());

		// 회원 정보 Model에 추가
		model.addAttribute("member", member);

		// action 파라미터가 없거나 잘못된 값일 경우 기본 페이지로 이동
		return "userProfileInfo";
	}

	// 닉네임 변경
	@PostMapping("/user/modifyNickname")
	@ResponseBody
	public String modifyNickname(@RequestParam("newNickname") String newNickname, HttpSession session) {
		// 로그인된 사용자 정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 회원 정보 조회
		MemberVO member = userService.selectMember(user.getMem_num());

		// 회원 정보에 새로운 닉네임 설정
		member.setMem_nickname(newNickname);

		if (member.getMem_nickname() == null) {
			userService.addNickname(member);
		} else {
			userService.updateNickname(member);
		}
		return "success";
	}

	// 소개글 변경
	@PostMapping("/user/modifyInt")
	@ResponseBody
	public String modifyInt(@RequestParam("newInt") String newInt, HttpSession session) {
		// 로그인된 사용자 정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 회원 정보 조회
		MemberVO member = userService.selectMember(user.getMem_num());

		// 회원 정보에 새로운 소개글 설정
		member.setMem_int(newInt);

		if (member.getMem_int() == null) {
			userService.addIntroduction(member);
		} else {
			userService.updateInt(member);
		}
		return "success";
	}

	/*
	 * =========================== 내 정보 - 주소록 ===========================
	 */
	@GetMapping("/user/userAddressBook.do")
	public String userAddressBook(HttpSession session, Model model) {
		// 로그인된 사용자 정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 회원 정보 조회
		MemberVO member = userService.selectMember(user.getMem_num());

		// 회원 정보 Model에 추가
		model.addAttribute("member", member);

		// action 파라미터가 없거나 잘못된 값일 경우 기본 페이지로 이동
		return "userAddressBook";
	}

	// 주소 변경
	@PostMapping("/user/saveAddress")
	@ResponseBody
	public String saveAddress(@RequestParam String zipcode, @RequestParam String address1,
			@RequestParam String address2, HttpSession session) {
		// 로그인된 사용자 정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 회원 정보 조회
		MemberVO member = userService.selectMember(user.getMem_num());

		// 회원 정보에 새로운 주소 설정
		member.setMem_zipcode(zipcode);
		member.setMem_address1(address1);
		member.setMem_address2(address2);

		if (member.getMem_zipcode() == null) {
			userService.addShippingAddress(member);
		} else {
			userService.updateShippingAddress(member);
		}
		return "success";
	}

	// 주소 변경
	@PostMapping("/user/addressUpdate.do")
	public String addressUpdate(@Valid MemberVO memberVO, BindingResult result, Model model, HttpSession session) {
		// 로그인된 사용자 정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 회원 정보 조회
		MemberVO member = userService.selectMember(user.getMem_num());

		// 회원 정보에 새로운 주소 설정
		member.setMem_zipcode(memberVO.getMem_zipcode());
		member.setMem_address1(memberVO.getMem_address1());
		member.setMem_address2(memberVO.getMem_address2());

		if (member.getMem_zipcode() == null) {
			userService.addShippingAddress(member);
		} else {
			userService.updateShippingAddress(member);
		}
		return "success";
	}

	/*
	 * ======================= 회원탈퇴(회원정보삭제) =======================
	 */
    @PostMapping("/user/deleteAccount")
    @ResponseBody
    public String deleteAccount(HttpSession session) {
    	// 로그인된 사용자 정보 가져오기
    			MemberVO user = (MemberVO) session.getAttribute("user");
    	
    	try {
            // 회원 정보 삭제 로직 실행
            userService.deleteMember(user.getMem_num()); 
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

	/*
	 * =========================== 페널티 정보 조회 ===========================
	 */
	@GetMapping("/user/userPenaltyInfo.do")
	public String getPenaltyInfo(HttpSession session, Model model) {
		// 로그인된 사용자 정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		// 회원 정보 조회
		MemberVO member = userService.selectMember(user.getMem_num());

		// 패널티 통합 점수 조회
		Integer pe_total = userService.getPenaltyTotalScore(user.getMem_num());
		
		// 회원 패널티 리스트
		List<PenaltyVO> penaltyList = userService.getPenaltyList(user.getMem_num());
		
		model.addAttribute("member", member);
		model.addAttribute("pe_total", pe_total);
		model.addAttribute("penaltyList", penaltyList);
		

		// 게시판 페널티 조회
		//List<MemberVO> penaltyBoardList = userService.getPenaltyBoard(user.getMem_num());
		//model.addAttribute("penaltyBoardList", penaltyBoardList);

		// 거래 페널티 조회
		//List<MemberVO> penaltyTradeList = userService.getPenaltyTrade(user.getMem_num());
		//model.addAttribute("penaltyTradeList", penaltyTradeList);

		// penaltyInfo.jsp로 이동
		return "userPenaltyInfo";
	}
}
