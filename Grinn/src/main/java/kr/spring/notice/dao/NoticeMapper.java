package kr.spring.notice.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.notice.vo.NoticeVO;

@Mapper
public interface NoticeMapper {
	//고객센터-공지사항
	@Select("SELECT * FROM notice WHERE no_status=1")
	public List<NoticeVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	
	//고객센터-자주묻는질문
	public List<NoticeVO> selectFaqList(Map<String, Object> map);
	public int selectRowCount_faq(Map<String, Object> map);
	
	//카테고리별 선택-1
	public List<NoticeVO> selectCategoryOne(Map<String, Object> map);
	@Select("SELECT * FROM notice WHERE no_status=2 AND no_category=2")
	public List<NoticeVO> selectCategoryTwo(Map<String, Object> map);
	@Select("SELECT * FROM notice WHERE no_status=2 AND no_category=3")
	public List<NoticeVO> selectCategoryThree(Map<String, Object> map);
	@Select("SELECT * FROM notice WHERE no_status=2 AND no_category=4")
	public List<NoticeVO> selectCategoryFour(Map<String, Object> map);
	
	//고객센터-검수기준
	@Select("SELECT * FROM notice WHERE no_status=3 ORDER BY no_policy asc")
	public List<NoticeVO> selectAuthList(Map<String, Object> map);
	public int selectRowCount_auth(Map<String, Object> map);
	
	//검수기준 policy 값 구하기
	@Select("SELECT no_policy FROM notice WHERE no_num=#{no_num}")
	public int selectAuthNum(Map<String, Object> map);
	
	public void insertNotice(NoticeVO notice);
	
	public NoticeVO selectNotice(Integer no_num);
	
	@Update("UPDATE notice SET no_title=#{no_title}, no_content=#{no_content}, "
			+ "no_modifydate=SYSDATE WHERE no_num=#{no_num}")
	public void updateNotice(NoticeVO notice);
	
	@Delete("DELETE FROM notice WHERE no_num=#{no_num}")
	public void deleteNotice(Integer no_num);

}
