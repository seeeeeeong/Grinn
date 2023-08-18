package kr.spring.chatbot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.chatbot.service.ChatBotService;
import kr.spring.chatbot.vo.ChatBotRoomVO;
import kr.spring.chatbot.vo.ChatBotVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.talk.controller.TalkController;
import kr.spring.talk.vo.TalkVO;
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
	@PostMapping("/chatbot/chathbotDetail.do")
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
		
		return "redirect:/chatbot/chatbotDetail.do";
	}
	
	/* ====================== 채팅방 목록(?) ====================== */
	
	/* ====================== 채팅 메시지 처리 ====================== */
	//챗봇 메세지 페이지 호출
	@RequestMapping("/chatbot/chatbotDetail.do")
	public String chatbotDetail(@RequestParam int croom_num, Model model, HttpSession session) {
		String chatMember = ""; //채팅 멤버
		log.debug("croom_num : "+croom_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//채팅 멤버 id
		model.addAttribute("chatMember", chatMember);
		
		return "talkDetail";
	}
	//채팅 메시지 전송
	@RequestMapping("/chatbot/writeChatbot.do")
	@ResponseBody
	public Map<String,Object> writeChatbotAjax(ChatBotVO vo, HttpSession session){
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user==null) {//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else {//로그인 된 경우
			vo.setMem_num(user.getMem_num());//발신자
			
			log.debug("<<채팅 메시지 전송>> : " + vo);
			
			chatbotService.insertChatBot(vo);
			
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	//채팅 메시지 	읽기
	@RequestMapping("/chatbot/chatbotDetailAjax.do")
	@ResponseBody
	public Map<String,Object> chatbotDetailAjax(@RequestParam int croom_num, HttpSession session){
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {//로그인이 되지않은 경우
			mapJson.put("result", "logout");
		}else {//로그인 된 경우
			Map<String,Integer> map = new HashMap<String,Integer>();
			map.put("croom_num", croom_num);
			map.put("mem_num", user.getMem_num());
			
			List<ChatBotVO> list = chatbotService.selectChatBotDetail(map);
			
			mapJson.put("result", "success");
			mapJson.put("list", list);
			mapJson.put("user_num", user.getMem_num());
		}
		
		return mapJson;
	}
	
	/* ====================== 채팅방 나가기 ====================== */
	
	
	
}












