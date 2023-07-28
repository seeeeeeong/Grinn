package kr.spring.style.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.style.service.StyleService;
import kr.spring.style.vo.StyleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class StyleController {
	@Autowired
	private StyleService styleService;
	
	/*========================
	 * 자바빈(VO) 초기화
	 *========================*/
	@ModelAttribute
	public StyleVO initCommand() {
		return new StyleVO();
	}
	
	/*========================
	 * 게시물 작성
	 *========================*/
	//등록폼
	@GetMapping("/style/write.do")
	public String form() {
		return "styleWrite";
	}
	//전송된 데이터 처리
	@PostMapping("/style/write.do")
	public String submit(@Valid StyleVO styleVO,
            BindingResult result,
            HttpServletRequest request,
            HttpSession session,
            Model model) {
		
		log.debug("<<STYLE 작성>> : " + styleVO);
		
		//유효성 체크 결과 오류가 있으며 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		return "common/resultView";
	}
	
	/*========================
	 * 게시판 목록
	 *========================*/
	@RequestMapping("/style/list.do")
	public void getList() {
		
		//return mav;
	}
	
}
