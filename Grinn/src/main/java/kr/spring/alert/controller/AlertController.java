package kr.spring.alert.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.alert.service.AlertService;
import kr.spring.alert.vo.AlertVO;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.trade.vo.TradeVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AlertController {

	@Autowired
	private AlertService alertService;	
	
	
    @RequestMapping("/user/alert.do")
    public String main(HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        
        if (user != null) {
            
        	List<AlertVO> commentList = alertService.commentInfo(user.getMem_num());
            model.addAttribute("commentList", commentList);
            
            List<AlertVO> favList = alertService.favInfo(user.getMem_num());
            model.addAttribute("favList", favList);
            
            List<MemberVO> followInfo = alertService.followId(user.getMem_num());
            model.addAttribute("followInfo", followInfo);
            
        	List<AlertVO> purchaseList = alertService.purchaseInfo(user.getMem_num());
            model.addAttribute("purchaseList", purchaseList);
            
            List<AlertVO> saleList = alertService.saleInfo(user.getMem_num());
            model.addAttribute("saleList", saleList);
        }
		return "/user/alert";
	}
		


    
	/*
	 * =========================== 프로필 사진 ===========================
	 */
	@GetMapping("/user/userProfile.do")
	public String favProfileView(@RequestParam int mem_num, Model model, HttpServletRequest request) {
		MemberVO memberVO = alertService.profilePhoto(mem_num);

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
	

}