package kr.spring.talk.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.talk.vo.TalkMemberVO;
import kr.spring.talk.vo.TalkRoomVO;
import kr.spring.talk.vo.TalkVO;

@Mapper
public interface TalkMapper {
	//채팅방 목록
	public List<TalkRoomVO> selectTalkRoomList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//채팅방 번호 생성
	@Select("SELECT talkroom_seq.nextval FROM dual")
	public int selectTalkRoomNum();
	
	//채팅방 생성
	@Insert("INSERT INTO talk_member (talkroom_num,basic_num) VALUES(#{talkroom_num},#{basic_name})")
	public void insertTalkRoom(TalkRoomVO talkRoomVO);
	
	//채팅방 멤버 등록
	@Insert("INSERT INTO talk_member (talkroom_num,room_name,mem_num) VALUES (#{talkroom_num},#{room_name},#{mem_num})")
	public void insertTalkRoomMember(@Param(value="talkroom_num") Integer talkroom_num,@Param(value="room_name") String room_name,@Param(value="mem_num") Integer mem_num);
	
	
	//채팅 멤버 읽기
	public List<TalkMemberVO> selectTalkMember(Integer talkroom_num);
	
	//채팅 메시지 번호 생성
	@Select("SELECT talk_seq.nextval FROM dual")
	public int selectTalkNum();
	
	//채팅 메시지 등록
	public void insertTalk(TalkVO talkVO);
	
	//채팅메시지 읽기
	public List<TalkVO> selectTalkDetail(Map<String,Integer> map);
	
	//채팅방 이름 변경하기
	public void changeRoomName(TalkMemberVO vo);
	
	//채팅방 상세
	public TalkRoomVO selectTalkRoom(Integer talkroom_num);
	
	//채팅 멤버 추가
	public void insertNewMember(TalkRoomVO talkRoomVO);
	
	//채팅방 나가기
	public void deleteTalkRoomMember(TalkVO talkVO);
}







