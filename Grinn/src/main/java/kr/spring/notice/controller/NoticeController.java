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

import kr.spring.member.vo.MemberVO;
import kr.spring.notice.service.NoticeService;
import kr.spring.notice.vo.NoticeVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
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
		if(result.hasErrors()) {
			return form();
		}
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//회원번호 세팅
		noticeVO.setMem_num(user.getMem_num());
		noticeVO.setMem_auth(user.getMem_auth());
		
		//글 쓰기
		noticeService.insertNotice(noticeVO);
		
		//관리자만 글을 쓸 수 있도록 mem_auth받기
		//int mem_auth = user.getMem_auth();
		
		model.addAttribute("message", "글쓰기가 완료되었습니다");
		model.addAttribute("url", request.getContextPath()+"/notice/noticeList.do");
		
		return "common/resultView";
	}
	
	/* ======================== 고객센터(공지사항) 글 목록 ======================== */
	@RequestMapping("/notice/noticeList.do")
	public ModelAndView getNoticeList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
									String keyfield, String keyword, HttpSession session) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//전체 레코드 수
		int count = noticeService.selectRowCount(map);
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 3, 5, "noticeList.do");
		
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
										 @RequestParam(value="no_category", defaultValue="1") int no_category,
										 String keyfield, String keyword) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//전체 레코드 수
		int count = noticeService.selectRowCount_faq(map);
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 10, 5, "/notice/noticefaq.do");
		
		List<NoticeVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("no_category", no_category);
			list = noticeService.selectFaqList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("noticefaq");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		mav.addObject("no_category", no_category);
		
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
		int count = noticeService.selectRowCount_auth(map);

		List<NoticeVO> list = null;
		
		if(count > 0) {
			list = noticeService.selectAuthList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("noticeAuth_policy");
		mav.addObject("count", count);
		mav.addObject("list", list);
		
		return mav;
	}
	
	/* ======================== 글 상세 ======================== */
	@RequestMapping("/notice/detail.do")
	public ModelAndView getDetail(@RequestParam int no_num,HttpSession session) {
		//글 상세
		NoticeVO notice = noticeService.selectNotice(no_num);
		//제목에 태그를 허용하지 않음
		notice.setNo_title(StringUtil.useNoHtml(notice.getNo_title()));
		//CKEditor를 사용하지 않을 경우 내용에 태그 불허
		//notice.setNo_content(StringUtil.useBrNoHtml(notice.getNo_content()));

		MemberVO user = (MemberVO)session.getAttribute("user");
		int auth;
		if(user==null || user.getMem_auth()!=9) {
			auth = 2;
		}else {
			auth = user.getMem_auth();
			log.debug("auth"+auth);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("noticeDetail");
		mav.addObject("notice", notice);

		mav.addObject("auth", auth);
		
		return mav;
	}
	/* ======================== 글 수정 ======================== */
	//수정 폼 호출
	@GetMapping("/notice/update.do")
	public String formUpdate(@RequestParam int no_num, Model model) {
		NoticeVO noticeVO = noticeService.selectNotice(no_num);
		model.addAttribute("noticeVO", noticeVO);
		
		return "noticeModify";
	}
	//전송된 데이터 처리
	@PostMapping("/notice/update.do")
	public String submitUpdate(@Valid NoticeVO noticeVO, BindingResult result,
						HttpServletRequest request, Model model) {
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "noticeModify";
		}
		
		//글 수정
		noticeService.updateNotice(noticeVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "글 수정 완료!");
		model.addAttribute("url", request.getContextPath()
							+"/notice/detail.do?no_num="+noticeVO.getNo_num());
		
		return "common/resultView";
	}
	/* ======================== 글 삭제 ======================== */
	@RequestMapping("/notice/delete.do")
	public String submitDelete(@RequestParam int no_num) {
		//글삭제
		noticeService.deleteNotice(no_num);
		
		return "redirect:/notice/noticeList.do";
	}
	
}

