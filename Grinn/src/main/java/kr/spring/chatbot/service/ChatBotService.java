package kr.spring.chatbot.service;

import java.util.List;
import java.util.Map;

import kr.spring.chatbot.vo.ChatBotRoomVO;

public interface ChatBotService {
	//챗봇방 목록
	public List<ChatBotRoomVO> selectChatBoatRoomList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//챗봇방 번호 생성
	public int selectChatBotRoomNum();
	//챗봇방 생성
	public void insertChatBotRoom(ChatBotRoomVO chatbotRoomVO);
}
