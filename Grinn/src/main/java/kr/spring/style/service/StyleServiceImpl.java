package kr.spring.style.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.style.dao.StyleMapper;
import kr.spring.style.vo.StyleVO;

@Service
@Transactional
public class StyleServiceImpl implements StyleService{
	
	@Autowired
	StyleMapper styleMapper;
	
	@Override
	public List<StyleVO> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insertStyle(StyleVO style) {
		styleMapper.insertStyle(style);
	}

	@Override
	public StyleVO selectStyle(Integer st_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateStyle(StyleVO style) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteStyle(Integer st_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void uploadPhoto(StyleVO styleVO) {
		// TODO Auto-generated method stub
		
	}

}
