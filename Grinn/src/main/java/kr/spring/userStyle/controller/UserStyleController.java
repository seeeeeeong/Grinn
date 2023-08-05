package kr.spring.userStyle.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.userStyle.service.UserStyleService;

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
	/*
	 * =========================== userStyle ===========================
	 */
	
	@GetMapping("/user/userStyle.do")
	public String userStyle(HttpSession session, Model model) {
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    MemberVO member = userStyleService.selectMember(user.getMem_num());
	    model.addAttribute("member", member);

	    int totalStyleCount = userStyleService.selectUserStyleCount(user.getMem_num());
	    model.addAttribute("totalStyleCount", totalStyleCount);
	    
        List<StyleVO> userStyles = userStyleService.selectStyle(user.getMem_num());
        model.addAttribute("userStyles", userStyles);
	    
        List<Integer> followers = userStyleService.getFollowers(user.getMem_num());
        List<Integer> followings = userStyleService.getFollowings(user.getMem_num());
        model.addAttribute("followers", followers);
        model.addAttribute("followings", followings);
        
        int followerCount = userStyleService.getFollowerCount(user.getMem_num());
        int followingCount = userStyleService.getFollowingCount(user.getMem_num());
        model.addAttribute("followerCount", followerCount);
        model.addAttribute("followingCount", followingCount);
        
	    return "userStyle";
	}
	
	/*
	 * =========================== 스타일 게시물 사진 ===========================
	 */
	@GetMapping("/user/imageView.do")
	public String imageView(@RequestParam int st_num, @RequestParam int st_type,Model model) {
	    StyleVO styleVO = userStyleService.selectUserStyle(st_num);
	    
	    if(st_type==1) {
	    	model.addAttribute("imageFile", styleVO.getSt_photo1());
			model.addAttribute("filename", styleVO.getSt_photo1n());
	    }else if(st_type==2) {
	    	model.addAttribute("imageFile", styleVO.getSt_photo2());
			model.addAttribute("filename", styleVO.getSt_photo2n());
	    }else if(st_type==3) {
	    	model.addAttribute("imageFile", styleVO.getSt_photo3());
			model.addAttribute("filename", styleVO.getSt_photo3n());
	    }else if(st_type==4) {
	    	model.addAttribute("imageFile", styleVO.getSt_photo4());
			model.addAttribute("filename", styleVO.getSt_photo4n());
	    }
		
	    return "imageView";
	}

	/*
	 * =========================== 팔로우 ===========================
	 */
	@GetMapping("/user/follow.do")
	@ResponseBody
	public Map<String, Object> follow(@RequestParam("to_user") Integer to_user, HttpSession session) {
	    Map<String, Object> resultMap = new HashMap<>();
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    Integer from_user = user.getMem_num();

	    try {
	        // 팔로우 추가
	        userStyleService.insertFollow(from_user, to_user);
	        resultMap.put("status", "success");
	    } catch (Exception e) {
	        resultMap.put("status", "error");
	        resultMap.put("message", "Failed to follow the user.");
	    }

	    return resultMap;
	}

	/*
	 * =========================== 팔로우 취소 ===========================
	 */
	@GetMapping("/user/unfollow.do")
	@ResponseBody
	public Map<String, Object> unfollow(@RequestParam("to_user") Integer to_user, HttpSession session) {
	    Map<String, Object> resultMap = new HashMap<>();
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    Integer from_user = user.getMem_num();

	    try {
	        // 팔로우 취소
	        userStyleService.deleteFollow(from_user, to_user);
	        resultMap.put("status", "success");
	    } catch (Exception e) {
	        resultMap.put("status", "error");
	        resultMap.put("message", "Failed to unfollow the user.");
	    }

	    return resultMap;
	}

}
