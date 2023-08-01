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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
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
	    model.addAttribute("mem_photo", member.getPhoto());
	    model.addAttribute("mem_nickname", member.getMem_nickname());
	    model.addAttribute("mem_email", member.getMem_email());

	    //mem_auth 값이 2이면 "일반회원", 9이면 "관리자"로 표시
	    String memAuthText = (member.getMem_auth() == 2) ? "일반회원" : (member.getMem_auth() == 9) ? "관리자" : "";
	    model.addAttribute("mem_auth", memAuthText);
	    model.addAttribute("mem_point", member.getMem_point());
		
		//구매 상품
		List<TradeVO> purchasedItems = userService.selectPurchasedItems(user.getMem_num());
		model.addAttribute("purchasedItems", purchasedItems);
		
		//판매 상품
        List<TradeVO> soldItems = userService.selectSoldItems(user.getMem_num());
        model.addAttribute("soldItems", soldItems);

        //관심 상품
        List<ItemVO> favoriteItems = userService.selectFavoriteItems(user.getMem_num());
        model.addAttribute("favoriteItems", favoriteItems);
		
		/*
		 * myPage라는 뷰를 찾아 해당 데이터를 사용하여 뷰를 렌더링
		 */
		return "myPage";
	}
	
	/*
	 * =========================== 쇼핑 정보 - 구매 내역 ===========================
	 */
    @GetMapping("/user/purchasedItems.do")
    public String purchasedItemsPage(HttpSession session, Model model) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");

        //구매 내역 조회
        List<TradeVO> purchasedItems = userService.selectPurchasedItems(user.getMem_num());
        model.addAttribute("purchasedItems", purchasedItems);

        //purchasedItems 페이지로 이동
        return "purchasedItems";
    }
    
	/*
	 * =========================== 쇼핑 정보 - 판매 내역 ===========================
	 */
    @GetMapping("/user/soldItems.do")
    public String soldItemsPage(HttpSession session, Model model) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");

        //판매 내역 조회
        List<TradeVO> soldItems = userService.selectSoldItems(user.getMem_num());
        model.addAttribute("soldItems", soldItems);
        
        //purchasedItems 페이지로 이동
        return "soldItems";
    }
    
	/*
	 * =========================== 쇼핑 정보 - 관심 상품 ===========================
	 */
    @GetMapping("/user/favoriteItems.do")
    public String favoriteItemsPage(HttpSession session, Model model) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");

        //판매 내역 조회
        List<ItemVO> favoriteItems = userService.selectFavoriteItems(user.getMem_num());
        model.addAttribute("favoriteItems", favoriteItems);
        
        //favoriteItems 페이지로 이동
        return "favoriteItems";
    }
    
	/*
	 * =========================== 쇼핑 정보 - 좋아요 ===========================
	 */
    @GetMapping("/user/likedStyles.do")
    public String likedStylesPage(HttpSession session, Model model) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");

        //좋아요한 상품들 조회
        List<MemberVO> likedStyles = userService.selectLikedStyles(user.getMem_num());
        model.addAttribute("likedStyles", likedStyles);

        //likedStyles 페이지로 이동
        return "likedStyles";
    }
    
    /*
     * =========================== 내 정보 - 로그인 정보 ===========================
     */
    @GetMapping("/user/loginInfo.do")
    public String loginInfo(HttpSession session, Model model,
                            @RequestParam(name = "action", required = false) String action) {
        //로그인된 사용자 정보 가져오기
        MemberVO user = (MemberVO) session.getAttribute("user");

        //회원 정보 조회
        MemberVO member = userService.selectMember(user.getMem_num());

        //회원 정보 Model에 추가
        model.addAttribute("member", member);

        //action 파라미터에 따라 다른 뷰를 리턴하도록 처리
        if ("userInfo".equals(action)) {
            // userInfo.jsp로 이동
            return "userInfo";
        } else if ("updateProfile".equals(action)) {
            // 회원 정보 수정 페이지로 이동
            return "updateProfile";
        } else if ("updatePassword".equals(action)) {
            // 비밀번호 수정 페이지로 이동
            return "updatePassword";
        } else if ("deleteMember".equals(action)) {
            // 회원 탈퇴 페이지로 이동
            return "deleteMember";
        }

        //action 파라미터가 없거나 잘못된 값일 경우 기본 페이지로 이동
        return "loginInfo";
    }
        
    /*
     * =========================== 페널티 정보 조회 ===========================
     */
    @GetMapping("/user/penaltyInfo.do")
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
        return "penaltyInfo";
    }   
}
