package kr.spring.chatbot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.chatbot.vo.ChatBotMemberVO;
import kr.spring.chatbot.vo.ChatBotRoomVO;
import kr.spring.chatbot.vo.ChatBotVO;

@Mapper
public interface ChatBotMapper {
	//챗봇방 목록
	public List<ChatBotRoomVO> selectChatBoatRoomList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//챗봇방 번호 생성
	@Select("SELECT chatbot_seq.nextval FROM dual")
	public int selectChatBotRoomNum();
	//챗봇방 생성
	@Insert("INSERT INTO cahtbot (croom_num,mem_num,mem_id) VALUES (#{croom_num},#{mem_num},#{mem_id})")
	public void insertChatBotRoom(ChatBotRoomVO chatbotRoomVO);
	//챗봇방 멤버등록
	public void insertChatBotRoomMember(@Param(value="croom_num") Integer croom_num, @Param(value="mem_num") Integer mem_num);
	
	//챗봇 멤버 읽기 -?
	public List<ChatBotMemberVO> selectChatBotMember(Integer croom_num);
	
	//챗봇 메세지 번호 생성
	public int selectChatBotNum();
	//챗봇 메세지 등록
	public void insertChatBot(ChatBotVO chatbotVO);
	//챗봇 메세지 읽기
	public List<ChatBotVO> selectChatBotDetail(Map<String,Integer> map);
	
	//읽지않은 챗봇 기록 저장 -?
	//읽은 챗봇 기록 삭제 -?
	
	//챗봇방 상세
	public ChatBotRoomVO selectChatBotRoom(Integer croom_num);
	
	//챗봇방 나가기(종료)
	//public void deleteChatBotRoomMember(ChatBotVO chatbotVO);
	//public void deleteChatBot(Integer croom_num);
	//public void deleteChatBotRoom(Integer croom_num);
}
