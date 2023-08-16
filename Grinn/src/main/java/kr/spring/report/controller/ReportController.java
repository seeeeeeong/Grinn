package kr.spring.report.controller;

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
import kr.spring.report.service.ReportService;
import kr.spring.report.vo.ComReportVO;
import kr.spring.report.vo.StyleReportVO;
import kr.spring.style.service.StyleService;
import kr.spring.style.vo.StyleCommentVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReportController {
	@Autowired
	private ReportService reportService;
	
	@Autowired
	private StyleService styleService;
	
	/*========================
	 * 자바빈(VO) 초기화
	 *========================*/
	@ModelAttribute
	public StyleReportVO initCommand() {
		return new StyleReportVO();
	}	
	
	//게시글 신고
	//등록폼
	@GetMapping("/style/styleReport.do")
	public String styleReportForm(@RequestParam int st_num, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("message", "로그인 후 이용 가능합니다.");
			model.addAttribute("url", "../member/login.do");
			return "common/resultView"; 
		}
		
		StyleVO style = styleService.selectStyle(st_num);
		
		model.addAttribute("style", style);
		
		return "styleReport";
	}
	//전송된 데이터 처리
	@PostMapping("/style/styleReport.do")
	public String stReportSubmit(StyleReportVO styleReportVO,
								 HttpSession session,
								 HttpServletRequest request,
								 Model model) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("message", "로그인 후 이용 가능합니다.");
			model.addAttribute("url", "../member/login.do");
			return "common/resultView"; 
		}
		
		int report_mem = user.getMem_num();
		
		styleReportVO.setReport_mem(report_mem);
		
		reportService.insertStyleReport(styleReportVO);
		
		model.addAttribute("message", "신고가 접수되었습니다.");
		model.addAttribute("url", "../style/list.do");
		
		return "common/resultView";
	}
	//댓글 신고
	//등록폼
	@GetMapping("/style/commentReport.do")
	public String commentReportForm(@RequestParam int com_num, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("message", "로그인 후 이용 가능합니다.");
			model.addAttribute("url", "../member/login.do");
			return "common/resultView"; 
		}
		
		StyleCommentVO comment = styleService.selectComment(com_num);
		
		model.addAttribute("comment", comment);
		
		return "commentReport";
	}
	//전송된 데이터 처리
	@PostMapping("/style/commentReport.do")
	public String comReportSubmit(ComReportVO commentReportVO,
								 HttpSession session,
								 HttpServletRequest request,
								 Model model) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("message", "로그인 후 이용 가능합니다.");
			model.addAttribute("url", "../member/login.do");
			return "common/resultView"; 
		}
		
		int report_mem = user.getMem_num();
		
		commentReportVO.setReport_mem(report_mem);
		
		reportService.insertCommentReport(commentReportVO);
		
		model.addAttribute("message", "신고가 접수되었습니다.");
		model.addAttribute("url", "../style/list.do");
		
		return "common/resultView";
	}	
	//신고 상세
	
	//신고 목록
	//(관리자) 게시물 신고 목록
	@RequestMapping("/report/styleReportList.do")
	public ModelAndView getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								@RequestParam(value="order", defaultValue="1") int order,
								String keyfield,String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드수
		int count = reportService.selectStyleReportRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,5,10,"styleReportList.do","&order="+order);
		
		List<StyleReportVO> list = null;
		if(count > 0) {
			map.put("order",order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = reportService.selectListStyleReport(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("styleReportList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	//(관리자) 댓글 신고 목록
	@RequestMapping("/report/comReportList.do")
	public ModelAndView getComList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								@RequestParam(value="order", defaultValue="1") int order,
								String keyfield,String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드수
		int count = reportService.selectComReportRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,5,10,"comReportList.do","&order="+order);
		
		List<ComReportVO> list = null;
		if(count > 0) {
			map.put("order",order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = reportService.selectListComReport(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("comReportList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}	
	
	//(관리자) 게시물 신고 상세
	@RequestMapping("/report/styleReportDetail.do")
	public ModelAndView getStyleReportDetail(@RequestParam int rst_num, @RequestParam(value="rep_hide", defaultValue="0") int rep_hide) {
		
		//신고 글 상세
		StyleReportVO style = reportService.selectStyleReport(rst_num);
		
		style.setRep_com(StringUtil.useBrNoHtml(style.getRep_com()));
		
		//신고 처리
		reportService.handleStyleReport(rst_num, rep_hide);
		
		//게시물 비공개 처리
		if(rep_hide == 2) {
			styleService.hideStyle(style.getSt_num());
		}
		
		return new ModelAndView("styleReportDetail","style", style);
	}
	
	//(관리자) 댓글 신고 상세
	@RequestMapping("/report/comReportDetail.do")
	public ModelAndView getComReportDetail(@RequestParam int rcom_num, @RequestParam(value="rep_hide", defaultValue="0") int rep_hide) {
		
		//신고 글 상세
		ComReportVO com = reportService.selectComReport(rcom_num);
		
		com.setRep_com(StringUtil.useBrNoHtml(com.getRep_com()));
		
		//신고 처리
		reportService.handleComReport(rcom_num, rep_hide);
		
		//게시물 비공개 처리
		if(rep_hide == 2) {
			styleService.hideComment(com.getCom_num());
		}
		
		return new ModelAndView("comReportDetail","com", com);
	}	
	
	
	//신고 처리
	
}
