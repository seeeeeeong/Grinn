package kr.spring.chatbot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.chatbot.service.ChatBotService;
import kr.spring.chatbot.vo.ChatBotMemberVO;
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
	
	/* ====================== 자바빈 초기화 ====================== */
	@ModelAttribute
	public ChatBotVO initCommand() {
		return new ChatBotVO();
	}
	
	/* ====================== 채팅방 생성 ====================== */
	//폼 호출
	@GetMapping("/chatbot/chatbotCreate.do")
	public String chatbotRoomDetail() {
		return "chatbotCreate";
	}
	//전송된 데이터 처리
	@PostMapping("/chatbot/chatbotCreate.do")
	public String chatbotSubmit(ChatBotRoomVO vo, HttpSession session) {
		log.debug("<<챗봇방 만들기>> : " + vo);
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//채팅 멤버 초대문구 설정 시작
		vo.setChatbotVO(new ChatBotVO());
		vo.getChatbotVO().setMem_num(user.getMem_num());
		vo.getChatbotVO().setMessage(user.getMem_id()+"님 반갑습니다. 문의하실 내용을 입력해주세요.");
		//채팅 멤버 초대문구 설정 끝
		
		chatbotService.insertChatBotRoom(vo);
		
		return "redirect:/chatbot/chatbotList.do";
	}
	//방을 만든 회원을 구해야하나?
	
	/* ====================== 챗봇방 목록 ====================== */
	@RequestMapping("/chatbot/chatbotList.do")
	public String chatbotList(@RequestParam(value="croom_num",defaultValue="0") int croom_num,
									HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_num", user.getMem_num());
		log.debug("user넘버 : " + user.getMem_num());//넘버 제대로 들어옴
		int count = chatbotService.selectRowCount(map);
		
		List<ChatBotRoomVO> list = null;
		if(count > 0) {
			list = chatbotService.selectChatBotRoomList(map);
		}
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("croom_num", croom_num);
		log.debug("croom_num : " + croom_num);
		return "chatbotList";
	}
	
	/* ====================== 챗봇 메시지 처리 ====================== */
	//챗봇 메세지 페이지 호출
	@RequestMapping("/chatbot/chatbotDetail.do")
	public String chatbotDetail(@RequestParam int croom_num, Model model, HttpSession session) {
		String chatMember = ""; //채팅 멤버
		log.debug("croom_num : "+croom_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		List<ChatBotMemberVO> list = chatbotService.selectChatBotMember(croom_num);
		for(int i=0; i<list.size(); i++) {
			ChatBotMemberVO vo = list.get(i);
			//멤버 저장
			chatMember += list.get(i).getMem_id();
		}
		
		//채팅 멤버 id
		model.addAttribute("chatMember", chatMember);
		//채팅 멤버수
		model.addAttribute("chatCount", list.size());
		//채팅방 번호
		model.addAttribute("croom_num", croom_num);
		model.addAttribute("list", list);
		
		return "chatbotDetail";
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
			
			Map<String,Integer> map = new HashMap<String,Integer>();
			map.put("c_num", vo.getC_num());
			map.put("croom_num", vo.getCroom_num());
			map.put("mem_num", vo.getMem_num());
			
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
			log.debug("ajax, croom_num : " + croom_num);
			log.debug("ajax, user_num : " + user.getMem_num());
			
			List<ChatBotVO> list = chatbotService.selectChatBotDetail(map);
			
			mapJson.put("result", "success");
			mapJson.put("list", list);
			mapJson.put("user_num", user.getMem_num());
		}
		
		return mapJson;
	}
	
	/* ====================== 채팅방 나가기 ====================== */
	@RequestMapping("/chatbot/deleteChatBotRoomMemberAjax.do")
	@ResponseBody
	public Map<String, String> memberDeleteAjax(ChatBotVO chatbotVO, HttpSession session){
		Map<String, String> mapJson = new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user==null) {//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else {//로그인 된 경우
			chatbotVO.setMem_num(user.getMem_num());
			//chatbotVO.setMessage(user.getMem_id()+"님의 문의가 종료됩니다.");
			chatbotService.deleteChatBotRoomMember(chatbotVO);
			chatbotVO.getC_num();
			
			mapJson.put("result", "success");
		}
		log.debug("<<문의나가기 : " + chatbotVO);
		return mapJson;
	}
	
}
