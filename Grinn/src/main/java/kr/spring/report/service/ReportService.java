package kr.spring.report.service;

import java.util.List;
import java.util.Map;

import kr.spring.report.vo.ComReportVO;
import kr.spring.report.vo.StyleReportVO;

public interface ReportService {
	//사용자
	//신고
	//게시글 신고
	public void insertStyleReport(StyleReportVO styleReportVO);
	//댓글 신고
	public void insertCommentReport(ComReportVO comReportVO);
	//내가 신고한 목록
	
	//사용자, 관리자
	//신고 상세
	
	//관리자
	//신고 목록
	//게시글 신고 목록
	public List<StyleReportVO> selectListStyleReport(Map<String, Object> map);
	public int selectStyleReportRowCount(Map<String,Object> map);
	//댓글 신고 목록
	public List<ComReportVO> selectListComReport(Map<String, Object> map);
	public int selectComReportRowCount(Map<String,Object> map);
	//신고 상태 변경
	
}
