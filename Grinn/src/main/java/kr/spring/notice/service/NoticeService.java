package kr.spring.notice.service;

import java.util.List;
import java.util.Map;

import kr.spring.notice.vo.NoticeVO;

public interface NoticeService {
	//고객센터
	public List<NoticeVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	public void insertNotice(NoticeVO notice);
	public NoticeVO selectNotice(Integer no_num);
	public void updateNotice(NoticeVO notice);
	public void deleteNotice(Integer no_num);
}
