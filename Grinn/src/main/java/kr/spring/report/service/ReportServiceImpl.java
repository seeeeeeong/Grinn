package kr.spring.report.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.report.dao.ReportMapper;
import kr.spring.report.vo.ComReportVO;
import kr.spring.report.vo.StyleReportVO;

@Service
@Transactional
public class ReportServiceImpl implements ReportService{
	@Autowired
	ReportMapper reportMapper;

	@Override
	public void insertStyleReport(StyleReportVO styleReportVO) {
		reportMapper.insertStyleReport(styleReportVO);
	}

	@Override
	public void insertCommentReport(ComReportVO comReportVO) {
		reportMapper.insertCommentReport(comReportVO);
	}

	@Override
	public List<StyleReportVO> selectListStyleReport(Map<String, Object> map) {
		
		return reportMapper.selectListStyleReport(map);
	}

	@Override
	public List<ComReportVO> selectListComReport(Map<String, Object> map) {
		return reportMapper.selectListComReport(map);
	}

	@Override
	public int selectStyleReportRowCount(Map<String, Object> map) {
		
		return reportMapper.selectStyleReportRowCount(map);
	}

	@Override
	public int selectComReportRowCount(Map<String, Object> map) {
		
		return reportMapper.selectComReportRowCount(map);
	}

	@Override
	public StyleReportVO selectStyleReport(Integer rst_num) {
		return reportMapper.selectStyleReport(rst_num);
	}

	@Override
	public ComReportVO selectComReport(Integer rcom_num) {
		return reportMapper.selectComReport(rcom_num);
	}

	@Override
	public void handleStyleReport(Integer rst_num, Integer rep_hide) {
		reportMapper.handleStyleReport(rst_num, rep_hide);
	}

	@Override
	public void handleComReport(Integer rcom_num, Integer rep_hide) {
		reportMapper.handleComReport(rcom_num, rep_hide);
	}
}
