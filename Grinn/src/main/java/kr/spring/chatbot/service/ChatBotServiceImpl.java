package kr.spring.chatbot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.chatbot.dao.ChatBotMapper;

@Service
@Transactional
public class ChatBotServiceImpl implements ChatBotService{
	@Autowired
	ChatBotMapper chatbotMapper;
}
