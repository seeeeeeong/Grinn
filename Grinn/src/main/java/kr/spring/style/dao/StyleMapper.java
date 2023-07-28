package kr.spring.style.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.style.vo.StyleVO;

@Mapper
public interface StyleMapper {
	//부모글
	public List<StyleVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertStyle(StyleVO style);
	public StyleVO selectStyle(Integer st_num);
	public void updateStyle(StyleVO style);
	public void deleteStyle(Integer st_num);
}
