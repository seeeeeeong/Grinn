package kr.spring.notice.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import kr.spring.notice.vo.NoticeVO;

public interface NoticeService {
	//고객센터-공지사항
	public List<NoticeVO> selectList(Map<String, Object> map);
	//고객센터-자주묻는질문
	public List<NoticeVO> selectFaqList(Map<String, Object> map);
	//고객센터-검수기준
	public List<NoticeVO> selectAuthList(Map<String, Object> map);
	//검수기준 policy 값 구하기
	//public int selectAuthNum(Map<String, Object> map);
	
	public int selectRowCount(Map<String, Object> map);
	public void insertNotice(NoticeVO notice);
	public NoticeVO selectNotice(Integer no_num);
	public void updateNotice(NoticeVO notice);
	public void deleteNotice(Integer no_num);
}
