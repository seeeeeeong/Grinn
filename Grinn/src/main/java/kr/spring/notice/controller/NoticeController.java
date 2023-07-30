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
		//유효성 체크 결과 오류가 있으면 폼 호출
		//if(result.hasErrors()) {
		//	return form();
		//}
		
		//회원번호 세팅
		//noticeVO.setMem_num(((NoticeVO)session.getAttribute("user")).getMem_num());
		
		//로그인작업 완료 후 세션에서 회원번호 호출하여 세팅하는 것으로 변경
		noticeVO.setMem_num(1);		
		//글 쓰기
		noticeService.insertNotice(noticeVO);
		
		model.addAttribute("message", "글쓰기가 완료되었습니다");
		model.addAttribute("url", request.getContextPath()+"/notice/List.do");
		
		return "common/resultView";
	}
	
	
	/* ======================== 고객센터(공지사항) 글 목록 ======================== */
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
	/* ======================== 고객센터(자주묻는질문) 글 목록 ======================== */
	@RequestMapping("/notice/noticefaq.do")
	public ModelAndView getNoticeFaqList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
			String keyfield, String keyword) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//전체 레코드 수
		int count = noticeService.selectRowCount(map);
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 10, 5, "noticefaq.do");
		
		List<NoticeVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = noticeService.selectFaqList(map);
		}
		
		//NoticeVO vo = new NoticeVO();
		//vo.setNo_category(category);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("noticefaq");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		//mav.addObject("vo", vo);
		
		return mav;
	}
	/* ======================== 고객센터(검수기준) 글 목록 ======================== */
	@RequestMapping("/notice/noticeAuth_policy.do")
	public ModelAndView getNoticeAuthPolicyList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
			String keyfield, String keyword) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//전체 레코드 수
		int count = noticeService.selectRowCount(map);
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 10, 5, "noticeAuth_policy.do");
		
		List<NoticeVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = noticeService.selectAuthList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("noticeAuth_policy");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
}

































