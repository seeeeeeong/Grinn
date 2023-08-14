package kr.spring.chatbot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.chatbot.service.ChatBotService;
import kr.spring.chatbot.vo.ChatBotRoomVO;
import kr.spring.chatbot.vo.ChatBotVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
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
	public String chatbotSubmit(@RequestParam int croom_num, Model model, ChatBotRoomVO vo, HttpSession session) {
		Map<String,Object> mapJson = new HashMap<String,Object>();
		log.debug("<<챗봇방 만들기>> : " + vo);
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}
		
		//채팅 멤버 초대문구 설정 시작
		vo.setChatbotVO(new ChatBotVO());
		vo.getChatbotVO().setMem_num(user.getMem_num());
		vo.getChatbotVO().setMessage(user.getMem_id()+"님 반갑습니다. 문의하실 내용을 입력해주세요.");
		//채팅 멤버 초대문구 설정 끝
		
		chatbotService.insertChatBotRoom(vo);
		
		return "chatbotDetail";
	}
	
	/* ====================== 채팅방 목록(?) ====================== */
	
	/* ====================== 채팅 메시지 처리 ====================== */
	//챗봇 메세지 페이지 호출
	@RequestMapping("/chatbot/chatbotDetail.do")
	public String chatbotDetail(@RequestParam int croom_num, Model model, HttpSession session) {
		String chatMember = ""; //채팅 멤버
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//채팅 멤버 id
		model.addAttribute("chatMember", chatMember);
		
		return "talkDetail";
	}
	
	/* ====================== 채팅방 나가기 ====================== */
	
	
	
}
