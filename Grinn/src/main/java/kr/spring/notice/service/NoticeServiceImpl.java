package kr.spring.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.spring.notice.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService{

	@Override
	public List<NoticeVO> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insertNotice(NoticeVO notice) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public NoticeVO selectNotice(Integer no_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateNotice(NoticeVO notice) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteNotice(Integer no_num) {
		// TODO Auto-generated method stub
		
	}

}
