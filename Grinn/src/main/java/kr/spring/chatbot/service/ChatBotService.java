package kr.spring.chatbot.service;

import java.util.List;
import java.util.Map;

import kr.spring.chatbot.vo.ChatBotMemberVO;
import kr.spring.chatbot.vo.ChatBotRoomVO;
import kr.spring.chatbot.vo.ChatBotVO;

public interface ChatBotService {
	//챗봇방 목록
	public List<ChatBotRoomVO> selectChatBotRoomList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	//챗봇방 생성
	public void insertChatBotRoom(ChatBotRoomVO chatbotRoomVO);
	
	//챗봇 멤버 읽기
	public List<ChatBotMemberVO> selectChatBotMember(Integer croom_num);
	
	//챗봇 메시지 등록
	public void insertChatBot(ChatBotVO chatbotVO);
	
	//챗봇 메시지 읽기
	public List<ChatBotVO> selectChatBotDetail(Map<String,Integer> map);
	
	//챗봇방 상세
	public ChatBotRoomVO selectChatBotRoom(Integer croom_num);
	
	//챗봇방 나가기
	public void deleteChatBotRoom(ChatBotVO chatbotVO);
}
