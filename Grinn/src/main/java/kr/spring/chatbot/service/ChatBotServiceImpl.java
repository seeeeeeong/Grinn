package kr.spring.chatbot.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.chatbot.dao.ChatBotMapper;
import kr.spring.chatbot.vo.ChatBotMemberVO;
import kr.spring.chatbot.vo.ChatBotRoomVO;
import kr.spring.chatbot.vo.ChatBotVO;

@Service
@Transactional
public class ChatBotServiceImpl implements ChatBotService{
	@Autowired
	ChatBotMapper chatbotMapper;
	
	//챗봇방 목록
	@Override
	public List<ChatBotRoomVO> selectChatBotRoomList(Map<String, Object> map) {
		return chatbotMapper.selectChatBotRoomList(map);
	}
	@Override
	public int selectRowCount(Map<String, Object> map) {
		return chatbotMapper.selectRowCount(map);
	}
	
	//챗봇방 생성
	@Override
	public void insertChatBotRoom(ChatBotRoomVO chatbotRoomVO) {
		//기본키 생성
		chatbotRoomVO.setCroom_num(chatbotMapper.selectChatBotRoomNum());
		//챗봇방 생성
		chatbotMapper.insertChatBotRoom(chatbotRoomVO);
		
		//입장메세지 처리 시작
		chatbotRoomVO.getChatbotVO().setC_num(chatbotMapper.selectChatBotNum());
		chatbotRoomVO.getChatbotVO().setCroom_num(chatbotRoomVO.getCroom_num());
		//채팅메세지 저장
		chatbotMapper.insertChatBot(chatbotRoomVO.getChatbotVO());
		//입장메세지 처리 끝
		
		//채팅방 멤버 생성
		for(Integer mem_num : chatbotRoomVO.getMembers()) {
			chatbotMapper.insertChatBotRoomMember(chatbotRoomVO.getCroom_num(), mem_num);
		}
	}
	
	//챗봇 멤버 읽기
	@Override
	public List<ChatBotMemberVO> selectChatBotMember(Integer croom_num) {
		return chatbotMapper.selectChatBotMember(croom_num);
	}

	//챗봇 메시지 등록
	@Override
	public void insertChatBot(ChatBotVO chatbotVO) {
		//챗봇 번호를 생성해서 자바빈(VO)에 저장
		chatbotVO.setC_num(chatbotMapper.selectChatBotNum());
		//챗봇 메세지 저장
		chatbotMapper.insertChatBot(chatbotVO);
		//챗봇방 멤버가 읽지 않은 채팅 정보 저장 -?
	}

	//챗봇 메시지 읽기
	@Override
	public List<ChatBotVO> selectChatBotDetail(Map<String, Integer> map) {
		//읽은 채팅기록 삭제 -?
		return chatbotMapper.selectChatBotDetail(map);
	}

	//챗봇방 상세
	@Override
	public ChatBotRoomVO selectChatBotRoom(Integer croom_num) {
		return chatbotMapper.selectChatBotRoom(croom_num);
	}

	//챗봇방 나가기
	@Override
	public void deleteChatBotRoom(ChatBotVO chatbotVO) {
		
	}
	
	
}
