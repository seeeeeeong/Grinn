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

	//고객센터-공지사항
	@Override
	public List<NoticeVO> selectList(Map<String, Object> map) {
		return noticeMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return noticeMapper.selectRowCount(map);
	}

	//고객센터-자주묻는질문
	@Override
	public List<NoticeVO> selectFaqList(Map<String, Object> map) {
		return noticeMapper.selectFaqList(map);
	}

	@Override
	public int selectRowCount_faq(Map<String, Object> map) {
		return noticeMapper.selectRowCount_faq(map);
	}
	
	//고객센터-검수기준
	@Override
	public List<NoticeVO> selectAuthList(Map<String, Object> map) {
		return noticeMapper.selectAuthList(map);
	}
	
	@Override
	public int selectRowCount_auth(Map<String, Object> map) {
		return noticeMapper.selectRowCount_auth(map);
	}

	//공지사항 글 등록
	@Override
	public void insertNotice(NoticeVO notice) {
		noticeMapper.insertNotice(notice);
	}

	//게시글 상세
	@Override
	public NoticeVO selectNotice(Integer no_num) {
		return noticeMapper.selectNotice(no_num);
	}

	//공지사항 수정
	@Override
	public void updateNotice(NoticeVO notice) {
		noticeMapper.updateNotice(notice);
	}

	//공지사항 삭제
	@Override
	public void deleteNotice(Integer no_num) {
		noticeMapper.deleteNotice(no_num);
	}
	

	

	

	




}
