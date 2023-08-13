package kr.spring.report.controller;

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

import kr.spring.member.vo.MemberVO;
import kr.spring.report.service.ReportService;
import kr.spring.report.vo.ComReportVO;
import kr.spring.report.vo.StyleReportVO;
import kr.spring.style.service.StyleService;
import kr.spring.style.vo.StyleCommentVO;
import kr.spring.style.vo.StyleVO;
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
	
	//신고 처리
	
}
