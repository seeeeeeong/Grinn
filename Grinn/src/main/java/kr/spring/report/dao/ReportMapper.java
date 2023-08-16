package kr.spring.report.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
	
	//관리자
	//신고 목록
	//게시글 신고 목록
	public List<StyleReportVO> selectListStyleReport(Map<String, Object> map);
	public int selectStyleReportRowCount(Map<String,Object> map);
	//댓글 신고 목록
	public List<ComReportVO> selectListComReport(Map<String, Object> map);
	public int selectComReportRowCount(Map<String,Object> map);
	//신고 상세
	//게시물 신고 상세
	@Select("SELECT r.rst_num, r.rep_type, r.rep_com, r.rep_hide, r.rep_status, r.rep_regdate, r.st_num, r.report_mem, r.reported_mem, report.mem_id report_id, reported.mem_id reported_id FROM report_st r LEFT OUTER JOIN member report ON r.report_mem = report.mem_num LEFT OUTER JOIN member reported ON r.reported_mem = reported.mem_num WHERE rst_num = #{rst_num}")
	public StyleReportVO selectStyleReport(Integer rst_num);
	//댓글 신고 상세
	@Select("SELECT r.rcom_num, r.rep_type, r.rep_com, r.rep_hide, r.rep_status, r.rep_regdate, r.com_num, r.report_mem, r.reported_mem, report.mem_id report_id, reported.mem_id reported_id FROM report_com r LEFT OUTER JOIN member report ON r.report_mem = report.mem_num LEFT OUTER JOIN member reported ON r.reported_mem = reported.mem_num WHERE rcom_num = #{rcom_num}")
	public ComReportVO selectComReport(Integer rcom_num);
	//신고 상태 변경
	//게시물 신고 처리
	@Update("UPDATE report_st SET rep_hide=#{rep_hide}, rep_status=1 WHERE rst_num=#{rst_num}")
	public void handleStyleReport(@Param(value="rst_num")Integer rst_num, @Param(value="rep_hide")Integer rep_hide);
	//댓글 신고 처리
	@Update("UPDATE report_com SET rep_hide=#{rep_hide}, rep_status=1 WHERE rcom_num=#{rcom_num}")
	public void handleComReport(@Param(value="rcom_num")Integer rcom_num, @Param(value="rep_hide")Integer rep_hide);
}
