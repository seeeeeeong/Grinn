package kr.spring.chatbot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

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
}
