package kr.spring.userStyle.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleFavVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.userStyle.service.UserStyleService;
import kr.spring.userStyle.vo.FollowVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserStyleController {

	@Autowired
	private UserStyleService userStyleService;

	/*
	 * =========================== 자바빈 초기화 ===========================
	 */
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}

	@ModelAttribute
	public StyleVO initStyleVO() {
		return new StyleVO();
	}

	@ModelAttribute
	public FollowVO initFollowVO() {
		return new FollowVO();
	}
	/*
	 * =========================== userStyle ===========================
	 */

	@GetMapping("/user/userStyle.do")
	public String userStyle(@RequestParam("mem_num") int memNum, HttpSession session, Model model) {
		// 로그인한 사용자의 mem_num 값을 가져옵니다.
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		// 로그인되지 않은 상태라면 로그인 페이지로 이동
	    if (user == null) {
	        return "redirect:/member/login.do"; // 로그인 페이지로 리다이렉트
	    }
		
		int loggedInUserMemNum = user.getMem_num();

		// mem_num 값과 로그인한 사용자의 mem_num 값을 비교합니다.
		boolean isOwnProfile = memNum == loggedInUserMemNum;
		model.addAttribute("isOwnProfile", isOwnProfile);

		// 팔로워 mem_num, mem_id
		List<MemberVO> followerInfo = userStyleService.followerInfo(memNum);
		model.addAttribute("followerInfo", followerInfo);

		// 팔로잉 mem_num, mem_id
		List<MemberVO> followingInfo = userStyleService.followingInfo(memNum);
		model.addAttribute("followingInfo", followingInfo);

		// mem_num 값과 로그인한 사용자의 mem_num 값을 비교합니다.
		if (memNum == loggedInUserMemNum) {
			// mem_num 값과 로그인한 사용자의 mem_num이 일치하는 경우, 해당 사용자의 정보를 표시합니다.

			MemberVO member = userStyleService.selectMember(memNum);
			model.addAttribute("member", member);

			int totalStyleCount = userStyleService.selectUserStyleCount(memNum);
			model.addAttribute("totalStyleCount", totalStyleCount);

			List<StyleVO> userStyles = userStyleService.selectStyle(memNum);
			model.addAttribute("userStyles", userStyles);

			int followerCount = userStyleService.getFollowerCount(memNum);
			int followingCount = userStyleService.getFollowingCount(memNum);
			model.addAttribute("followerCount", followerCount);
			model.addAttribute("followingCount", followingCount);

			return "userStyle"; // userStyle 페이지로 이동합니다.
		} else {
			// mem_num 값과 로그인한 사용자의 mem_num이 일치하는 경우, 해당 사용자의 정보를 표시합니다.

			MemberVO member = userStyleService.selectMember(memNum);
			model.addAttribute("member", member);

			int totalStyleCount = userStyleService.selectUserStyleCount(memNum);
			model.addAttribute("totalStyleCount", totalStyleCount);

			List<StyleVO> userStyles = userStyleService.selectStyle(memNum);
			model.addAttribute("userStyles", userStyles);

			int followerCount = userStyleService.getFollowerCount(memNum);
			int followingCount = userStyleService.getFollowingCount(memNum);
			model.addAttribute("followerCount", followerCount);
			model.addAttribute("followingCount", followingCount);

			return "userStyle";
		}
	}

	/*
	 * =========================== 스타일 게시물 사진 ===========================
	 */
	@GetMapping("/user/imageView.do")
	public String imageView(@RequestParam int st_num, @RequestParam int st_type, Model model) {
		StyleVO styleVO = userStyleService.selectUserStyle(st_num);

		if (st_type == 1) {
			model.addAttribute("imageFile", styleVO.getSt_photo1());
			model.addAttribute("filename", styleVO.getSt_photo1n());
		} else if (st_type == 2) {
			model.addAttribute("imageFile", styleVO.getSt_photo2());
			model.addAttribute("filename", styleVO.getSt_photo2n());
		} else if (st_type == 3) {
			model.addAttribute("imageFile", styleVO.getSt_photo3());
			model.addAttribute("filename", styleVO.getSt_photo3n());
		} else if (st_type == 4) {
			model.addAttribute("imageFile", styleVO.getSt_photo4());
			model.addAttribute("filename", styleVO.getSt_photo4n());
		}

		return "imageView";
	}

	/*
	 * =========================== 스타일 게시물 작성자 프로필 사진 ===========================
	 */
	@GetMapping("/user/StyleProfile.do")
	public String StyleProfileView(@RequestParam int st_num, Model model, HttpServletRequest request) {
		MemberVO memberVO = userStyleService.selectStyleProfile(st_num);

		if (memberVO.getMem_photo_name() == null) {
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
	@RequestMapping("/user/getFav.do")
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

			StyleFavVO styleFav = userStyleService.selectFav(fav);
			if (styleFav != null) {
				mapJson.put("status", "yesFav");
			} else {
				mapJson.put("status", "noFav");
			}
		}
		mapJson.put("count", userStyleService.selectFavCount(fav.getSt_num()));
		return mapJson;
	}

	// 좋아요 등록/삭제
	@RequestMapping("/user/writeFav.do")
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

			StyleFavVO styleFav = userStyleService.selectFav(fav);
			if (styleFav != null) {// 등록한 좋아요가 있으면 삭제
				userStyleService.deleteFav(styleFav.getStfav_num());

				mapJson.put("result", "success");
				mapJson.put("status", "noFav");
			} else {// 등록한 좋아요가 없으면 등록
				userStyleService.insertFav(fav);

				mapJson.put("result", "success");
				mapJson.put("status", "yesFav");
			}
			mapJson.put("count", userStyleService.selectFavCount(fav.getSt_num()));
		}
		return mapJson;
	}

	/*
	 * =========================== 팔로우 및 팔로우 취소 ===========================
	 */
	@PostMapping("/user/follow")
	@ResponseBody
	public String followUser(@RequestParam("to_user") int toUser, HttpSession session) {

		// 로그인한 사용자의 mem_num 값을 가져옵니다.
		MemberVO user = (MemberVO) session.getAttribute("user");
		int fromUser = user.getMem_num();

		// 이미 팔로우한 경우: 팔로우 취소
		if (userStyleService.isFollowing(toUser, fromUser)) {
			userStyleService.deleteFollow(toUser, fromUser);
			return "unfollow"; // 팔로우 취소 응답
		}
		// 팔로우하지 않은 경우: 팔로우 추가
		else {
			userStyleService.insertFollow(toUser, fromUser);
			return "follow"; // 팔로우 성공 응답
		}
	}

	// 팔로잉 여부 확인
	@GetMapping("/user/getFollowStatus")
	@ResponseBody
	public String getFollowStatus(@RequestParam("to_user") int toUser, HttpSession session, Model model) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		int fromUser = user.getMem_num();

		boolean followCount = userStyleService.isFollowing(toUser, fromUser);
		model.addAttribute("followCount", followCount);

		if (followCount) {
			return "following";
		} else {
			return "not_following";
		}
	}

	// 팔로워,팔로잉 프로필 사진
	@GetMapping("user/FollowerProfileImage.do")
	public String followProfileImage(@RequestParam int mem_num, Model model, HttpServletRequest request) {
		MemberVO memberVO = userStyleService.selectFollowerProfile(mem_num);

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
}
