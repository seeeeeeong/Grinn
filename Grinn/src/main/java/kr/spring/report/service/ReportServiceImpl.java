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
		
		return null;
	}

	@Override
	public List<ComReportVO> selectListComReport(Map<String, Object> map) {
		return null;
	}
}
