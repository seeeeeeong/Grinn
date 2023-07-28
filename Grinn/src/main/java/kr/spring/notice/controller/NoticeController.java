package kr.spring.notice.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.notice.service.NoticeService;
import kr.spring.notice.vo.NoticeVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class NoticeController {
	@Autowired
	private NoticeService noticeService;
	
	
	/* ======================== 자바빈(VO) 초기화 ======================== */
	@ModelAttribute
	public NoticeVO initCommand() {
		return new NoticeVO();
	}
	
	
	/* ======================== 고객센터 글 등록 ======================== */
	//등록 폼
	@GetMapping("/notice/write.do")
	public String form() {
		return "noticeWrite";
	}
	//전송된 데이터 처리
	@PostMapping("/notice/write.do")
	public String submit(@Valid NoticeVO noticeVO, BindingResult result,
						HttpServletRequest request, HttpSession session, Model model) {
		
		
		return "";
	}
	
	
	/* ======================== 고객센터 글 목록 ======================== */
	@RequestMapping("/notice/noticeList.do")
	public ModelAndView getNoticeList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
									String keyfield, String keyword) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//전체 레코드 수
		int count = noticeService.selectRowCount(map);
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 10, 5, "noticeList.do");
		
		List<NoticeVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = noticeService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("noticeList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	
}

































