package kr.spring.style.service;

import java.util.List;
import java.util.Map;

import kr.spring.style.vo.StyleVO;

public interface StyleService {
	//부모글
	public List<StyleVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertStyle(StyleVO style);
	public StyleVO selectStyle(Integer st_num);
	public void updateStyle(StyleVO style);
	public void deleteStyle(Integer st_num);
}
