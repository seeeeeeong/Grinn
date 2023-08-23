
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
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleVO;
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
            
            List<StyleVO> styleInfoList = alertService.selectStyleInfo(user.getMem_num());

            Map<Integer, List<String>> commentsMap = new HashMap<>();

            for (StyleVO styleInfo : styleInfoList) {
                Integer st_num = styleInfo.getSt_num();

                // 좋아요 한 회원 정보 가져오기
                List<MemberVO> favInfo = alertService.favId(st_num);
                model.addAttribute("favInfo", favInfo);

                // 댓글 작성자 아이디, 내용 가져오기
                List<MemberVO> commentInfo = alertService.commentId(st_num);
                List<String> comments = alertService.comment(st_num);

                model.addAttribute("commentInfo", commentInfo);
                commentsMap.put(st_num, comments);
             
            }
            
            
            List<MemberVO> followInfo = alertService.followId(user.getMem_num());
            model.addAttribute("followInfo", followInfo);
            
            model.addAttribute("styleInfoList", styleInfoList);
            model.addAttribute("commentsMap", commentsMap);
            
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




