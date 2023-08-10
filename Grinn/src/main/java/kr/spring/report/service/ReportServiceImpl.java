package kr.spring.report.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.report.dao.ReportMapper;

@Service
@Transactional
public class ReportServiceImpl implements ReportService{
	@Autowired
	ReportMapper reportMapper;
}
