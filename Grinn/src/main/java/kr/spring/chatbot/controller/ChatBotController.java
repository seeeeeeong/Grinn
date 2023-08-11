package kr.spring.chatbot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import kr.spring.chatbot.service.ChatBotService;
import kr.spring.member.service.MemberService;
import kr.spring.talk.controller.TalkController;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatBotController {
	@Autowired
	private ChatBotService chatbotService;
	@Autowired
	private MemberService memberService;
	
	/* ====================== 채팅방 생성 ====================== */
	//폼 호출
	@GetMapping("/chatbot/chatbotDetail.do")
	public String chatbotRoomDetail() {
		return "chatbotDetail";
	}
	//전송된 데이터 처리
	public String chatbotSubmit() {
		
		
		return "mapJson";
	}
	
	/* ====================== 채팅방 목록 ====================== */
	
	/* ====================== 채팅 메시지 처리 ====================== */
	
	/* ====================== 채팅방 나가기 ====================== */
	
	
	
}
