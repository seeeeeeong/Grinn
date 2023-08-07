package kr.spring.talk.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.talk.dao.TalkMapper;
import kr.spring.talk.vo.TalkMemberVO;
import kr.spring.talk.vo.TalkRoomVO;
import kr.spring.talk.vo.TalkVO;

@Service
@Transactional
public class TalkServiceImpl implements TalkService{
	@Autowired
	TalkMapper talkMapper;
	
	@Override
	public List<TalkRoomVO> selectTalkRoomList(Map<String, Object> map) {
		return null;
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return 0;
	}

	@Override
	public void insertTalkRoom(TalkRoomVO talkRoomVO) {
		//기본키 생성
		talkRoomVO.setTalkroom_num(talkMapper.selectTalkRoomNum());
		//채팅방 생성
		talkMapper.insertTalkRoom(talkRoomVO);
		
		//입장메세지 처리 시작
		talkRoomVO.getTalkVO().setTalk_num(talkMapper.selectTalkNum());
		talkRoomVO.getTalkVO().setTalkroom_num(talkRoomVO.getTalkroom_num());
		//채팅메세지 저장
		talkMapper.insertTalk(talkRoomVO.getTalkVO());
		//입장메세지 처리 끝
		
		//채팅방 멤버 생성
		for(Integer mem_num : talkRoomVO.getMembers()) {
			talkMapper.insertTalkRoomMember(talkRoomVO.getTalkroom_num(), talkRoomVO.getBasic_name(), mem_num);
		}
	}

	@Override
	public List<TalkMemberVO> selectTalkMember(Integer talkroom_num) {
		return null;
	}

	@Override
	public void insertTalk(TalkVO talkVO) {
		
	}

	@Override
	public List<TalkVO> selectTalkDetail(Map<String, Integer> map) {
		return null;
	}

	@Override
	public void changeRoomName(TalkMemberVO vo) {
		
	}

	@Override
	public TalkRoomVO selectTalkRoom(Integer talkroom_num) {
		return null;
	}

	@Override
	public void insertNewMember(TalkRoomVO talkRoomVO) {
		
	}

	@Override
	public void deleteTalkRoomMember(TalkVO talkVO) {
		
	}
}
