package kr.spring.style.service;

import java.util.List;
import java.util.Map;

import kr.spring.item.vo.ItemVO;
import kr.spring.style.vo.StyleCommentVO;
import kr.spring.style.vo.StyleFavVO;
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
	//좋아요
	public StyleFavVO selectFav(StyleFavVO fav);
	public int selectFavCount(Integer st_num);
	public void insertFav(StyleFavVO fav);
	public void deleteFav(Integer stfav_num);
	public void deleteFavByStNum(Integer st_num);
	//댓글
	public List<StyleCommentVO> selectListComment(Map<String,Object> map);
	public int selectRowCountComment(Map<String,Object> map);
	public StyleCommentVO selectComment(Integer com_num);
	public void insertComment(StyleCommentVO styleComment);
	public void updateComment(StyleCommentVO styleComment);
	public void deleteComment(Integer com_num);
	
	
	//게시글 비공개(관리자 처리)
	public void hideStyle(Integer st_num);
	//댓글 비공개(관리자 처리)
	public void hideComment(Integer com_num);
}
