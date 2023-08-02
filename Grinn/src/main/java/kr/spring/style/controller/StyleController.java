package kr.spring.style.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.service.StyleService;
import kr.spring.style.vo.StyleVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
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
	
	//상품 검색
	@RequestMapping("/style/itemSearchAjax.do")
	@ResponseBody
	public Map<String,Object> itemSearchAjax(@RequestParam String item_name){
		Map<String,Object> mapJson = new HashMap<String,Object>();
	
		List<ItemVO> item_tag = styleService.selectSearchItem(item_name);
		mapJson.put("result", "success");
		mapJson.put("item_tag", item_tag);
		
		return mapJson;
	}
	
	//전송된 데이터 처리
	@PostMapping("/style/write.do")
	public String submit(@Valid StyleVO styleVO,
            			 BindingResult result,
            			 HttpServletRequest request,
            			 HttpSession session,
            			 Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
	
		log.debug("<<STYLE 작성>> : " + styleVO);
		
		//유효성 체크 결과 오류가 있으며 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//로그인 작업 완료 후 세션에서 회원번호 호출하여 셋팅하는 것으로 변경
		styleVO.setMem_num(user.getMem_num());
		styleService.insertStyle(styleVO);
		
		model.addAttribute("message", "스타일 업로드 완료!");
		model.addAttribute("url", request.getContextPath()+"/style/list.do");
		
		return "common/resultView";
	}
	
	/*========================
	 * 게시판 목록
	 *========================*/
	@RequestMapping("/style/list.do")
	public ModelAndView getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								@RequestParam(value="order", defaultValue="1") int order,
								String keyfield,String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드수
		int count = styleService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,5,10,"list.do","&order="+order);
		
		List<StyleVO> list = null;
		if(count > 0) {
			map.put("order",order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = styleService.selectList(map);			
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("styleList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*========================
	 * 스타일 상세
	 *========================*/
	@RequestMapping("/style/detail.do")
	public ModelAndView getDetail(@RequestParam int st_num) {
		log.debug("<<스타일 상세 - st_num>> : " + st_num);
		
		//글상세 
		StyleVO style = styleService.selectStyle(st_num);
		
		style.setSt_phrase(StringUtil.useBrNoHtml(style.getSt_phrase()));
		
		return new ModelAndView("styleDetail","style", style);
	}
	
}
