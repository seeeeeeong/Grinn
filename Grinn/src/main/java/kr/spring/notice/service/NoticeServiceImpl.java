package kr.spring.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.notice.dao.NoticeMapper;
import kr.spring.notice.vo.NoticeVO;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService{
	@Autowired
	NoticeMapper noticeMapper;

	@Override
	public List<NoticeVO> selectList(Map<String, Object> map) {
		return noticeMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return noticeMapper.selectRowCount(map);
	}

	@Override
	public List<NoticeVO> selectFaqList(Map<String, Object> map) {
		return noticeMapper.selectFaqList(map);
	}

	

	@Override
	public void insertNotice(NoticeVO notice) {
		noticeMapper.insertNotice(notice);
	}

	@Override
	public NoticeVO selectNotice(Integer no_num) {
		return noticeMapper.selectNotice(no_num);
	}

	@Override
	public void updateNotice(NoticeVO notice) {
		noticeMapper.updateNotice(notice);
	}

	@Override
	public void deleteNotice(Integer no_num) {
		noticeMapper.deleteNotice(no_num);
	}

	@Override
	public List<NoticeVO> selectAuthList(Map<String, Object> map) {
		return noticeMapper.selectAuthList(map);
	}




}
