package kr.spring.report.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import kr.spring.report.service.ReportService;
import kr.spring.report.vo.StyleReportVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReportController {
	@Autowired
	private ReportService reportSerivce;
	
	/*========================
	 * 자바빈(VO) 초기화
	 *========================*/
	@ModelAttribute
	public StyleReportVO initCommand() {
		return new StyleReportVO();
	}	
	
	//게시글 신고
	//등록폼
	@ModelAttribute
	public String styleReportForm() {
		return "styleReport";
	}
	//전송된 데이터 처리
	@PostMapping("/report/styleReport.do")
	public String stReportSubmit(@Valid StyleReportVO styleReportVO,
								 BindingResult result,
								 HttpServletRequest request,
								 HttpSession session,
								 Model model) {
		
		
		return "common/resultView";
	}
	//댓글 신고
	
	//신고 상세
	
	//신고 목록
	
	//신고 처
}
