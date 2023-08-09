package kr.spring.style.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.item.vo.ItemVO;
import kr.spring.style.dao.StyleMapper;
import kr.spring.style.vo.StyleCommentVO;
import kr.spring.style.vo.StyleFavVO;
import kr.spring.style.vo.StyleVO;

@Service
@Transactional
public class StyleServiceImpl implements StyleService{
	
	@Autowired
	StyleMapper styleMapper;
	
	@Override
	public List<StyleVO> selectList(Map<String, Object> map) {
		return styleMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return styleMapper.selectRowCount(map);
	}

	@Override
	public void insertStyle(StyleVO style) {
		styleMapper.insertStyle(style);
	}

	@Override
	public StyleVO selectStyle(Integer st_num) {
		return styleMapper.selectStyle(st_num);
	}

	@Override
	public void updateStyle(StyleVO style) {
		styleMapper.updateStyle(style);
	}

	@Override
	public void deleteStyle(Integer st_num) {
		styleMapper.deleteStyle(st_num);
	}


	@Override
	public List<ItemVO> selectSearchItem(String item_name) {
		
		return styleMapper.selectSearchItem(item_name);
	}

	@Override
	public StyleFavVO selectFav(StyleFavVO fav) {
		
		return styleMapper.selectFav(fav);
	}

	@Override
	public int selectFavCount(Integer st_num) {
		
		return styleMapper.selectFavCount(st_num);
	}

	@Override
	public void insertFav(StyleFavVO fav) {
		
		styleMapper.insertFav(fav);
	}

	@Override
	public void deleteFav(Integer stfav_num) {
		styleMapper.deleteFav(stfav_num);
	}

	@Override
	public void deleteFavByStNum(Integer st_num) {
		styleMapper.deleteFavByStNum(st_num);
	}

	@Override
	public List<StyleCommentVO> selectListComment(Map<String, Object> map) {
		return styleMapper.selectListComment(map);
	}

	@Override
	public int selectRowCountComment(Map<String, Object> map) {
		
		return styleMapper.selectRowCountComment(map);
	}

	@Override
	public StyleCommentVO selectComment(Integer com_num) {
		
		return styleMapper.selectComment(com_num);
	}

	@Override
	public void insertComment(StyleCommentVO styleComment) {
		styleMapper.insertComment(styleComment);
	}

	@Override
	public void updateComment(StyleCommentVO styleComment) {
		styleMapper.updateComment(styleComment);
	}

	@Override
	public void deleteComment(Integer com_num) {
		styleMapper.deleteComment(com_num);
	}

	

}
