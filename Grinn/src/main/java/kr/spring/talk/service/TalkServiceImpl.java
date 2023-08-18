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
	
	//채팅방 목록
	@Override
	public List<TalkRoomVO> selectTalkRoomList(Map<String, Object> map) {
		return talkMapper.selectTalkRoomList(map);
	}
	@Override
	public int selectRowCount(Map<String, Object> map) {
		return talkMapper.selectRowCount(map);
	}

	//채팅방 생성
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

	//채팅 멤버 읽기
	@Override
	public List<TalkMemberVO> selectTalkMember(Integer talkroom_num) {
		return talkMapper.selectTalkMember(talkroom_num);
	}

	//채팅 메시지 등록
	@Override
	public void insertTalk(TalkVO talkVO) {
		//채팅 번호를 생성해서 자바빈(VO)에 저장
		talkVO.setTalk_num(talkMapper.selectTalkNum());
		//채팅 메시지 저장
		talkMapper.insertTalk(talkVO);
		//채팅방 멤버가 읽지 않은 채팅 정보 저장
		for(TalkMemberVO vo : talkMapper.selectTalkMember(talkVO.getTalkroom_num())) {
			talkMapper.insertTalkRead(talkVO.getTalkroom_num(), 
											talkVO.getTalk_num(), vo.getMem_num());
		}
	}

	//채팅메시지 읽기
	@Override
	public List<TalkVO> selectTalkDetail(Map<String, Integer> map) {
		//읽은 채팅 기록 삭제
		talkMapper.deleteTalkRead(map);
		return talkMapper.selectTalkDetail(map);
	}

	//채팅방 이름 변경하기
	@Override
	public void changeRoomName(TalkMemberVO vo) {
		talkMapper.changeRoomName(vo);
	}

	//채팅방 상세
	@Override
	public TalkRoomVO selectTalkRoom(Integer talkroom_num) {
		return talkMapper.selectTalkRoom(talkroom_num);
	}

	//채팅 멤버 추가
	@Override
	public void insertNewMember(TalkRoomVO talkRoomVO) {
		//입장 메시지 처리
		talkRoomVO.getTalkVO().setTalk_num(talkMapper.selectTalkNum());
		//메시지 저장
		talkMapper.insertTalk(talkRoomVO.getTalkVO());
		//채팅방 멤버 생성
		for(Integer mem_num : talkRoomVO.getMembers()) {
			talkMapper.insertTalkRoomMember(talkRoomVO.getTalkroom_num(),
											talkRoomVO.getBasic_name(), mem_num);
		}
	}

	//채팅방 나가기
	@Override
	public void deleteTalkRoomMember(TalkVO talkVO) {
		talkMapper.deleteTalkRoomMember(talkVO);
		List<TalkMemberVO> list = talkMapper.selectTalkMember(talkVO.getTalkroom_num());
		
		if(list.size() > 1) {
			//탈출 메시지 처리
			talkVO.setTalk_num(talkMapper.selectTalkNum());
			talkMapper.insertTalk(talkVO);
		}else {
			//채팅멤버가 1명인데 마지막 채팅멤버가 방을 나갈 경우 남아있는 채팅 내용을
			//모두 지우고 채팅방도 삭제
			talkMapper.deleteTalk(talkVO.getTalkroom_num());
			talkMapper.deleteTalkRoom(talkVO.getTalkroom_num());
		}
	}
}
