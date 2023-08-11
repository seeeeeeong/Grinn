package kr.spring.chatbot.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.chatbot.dao.ChatBotMapper;
import kr.spring.chatbot.vo.ChatBotRoomVO;

@Service
@Transactional
public class ChatBotServiceImpl implements ChatBotService{
	@Autowired
	ChatBotMapper chatbotMapper;
	
	//챗봇방 목록
	@Override
	public List<ChatBotRoomVO> selectChatBoatRoomList(Map<String, Object> map) {
		return chatbotMapper.selectChatBoatRoomList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return chatbotMapper.selectRowCount(map);
	}

	//챗봇방 번호 생성
	@Override
	public int selectChatBotRoomNum() {
		return 0;
	}
	//챗봇방 생성
	@Override
	public void insertChatBotRoom(ChatBotRoomVO chatbotRoomVO) {
		// TODO Auto-generated method stub
		
	}
}
