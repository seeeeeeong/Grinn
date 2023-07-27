package kr.spring.notice.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.notice.vo.NoticeVO;

@Mapper
public interface NoticeMapper {
	//고객센터
	public List<NoticeVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	public void insertNotice(NoticeVO notice);
	public NoticeVO selectNotice(Integer no_num);
	public void updateNotice(NoticeVO notice);
	public void deleteNotice(Integer no_num);
}
