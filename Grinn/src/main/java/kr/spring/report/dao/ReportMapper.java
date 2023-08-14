package kr.spring.report.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import kr.spring.report.vo.ComReportVO;
import kr.spring.report.vo.StyleReportVO;

@Mapper
public interface ReportMapper {
	//사용자
	//게시글 신고
	@Insert("INSERT INTO report_st (rst_num, rep_type, rep_com, st_num, report_mem, reported_mem) VALUES (report_st_seq.nextval, #{rep_type}, #{rep_com}, #{st_num}, #{report_mem}, #{reported_mem})")
	public void insertStyleReport(StyleReportVO styleReportVO);
	//댓글 신고
	@Insert("INSERT INTO report_com (rcom_num, rep_type, rep_com, com_num, report_mem, reported_mem) VALUES (report_com_seq.nextval, #{rep_type}, #{rep_com}, #{com_num}, #{report_mem}, #{reported_mem})")
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
