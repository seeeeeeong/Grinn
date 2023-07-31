package kr.spring.style.service;

import java.util.List;
import java.util.Map;

import kr.spring.item.vo.ItemVO;
import kr.spring.style.vo.StyleVO;

public interface StyleService {
	//부모글
	//목록
	public List<StyleVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	//작성
	public void insertStyle(StyleVO style);
	//태그할 상품 검색
	public List<ItemVO> selectSearchItem(String item_name);
	//상세
	public StyleVO selectStyle(Integer st_num);
	//수정
	public void updateStyle(StyleVO style);
	//삭제
	public void deleteStyle(Integer st_num);
}
