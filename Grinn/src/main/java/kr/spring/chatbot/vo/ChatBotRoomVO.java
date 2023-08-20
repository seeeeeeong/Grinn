package kr.spring.chatbot.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatBotRoomVO {
	private int croom_num; //방번호
	private String croom_question; //회원의 질문
	private String croom_answer; //답변
	private Date croom_date; //질문 날짜
	
	private int[] members; //챗봇 멤버의 회원번호
	private ChatBotVO chatbotVO; //챗봇 메세지 VO
	private ChatBotAnswerVO chatbotAnswerVO; //챗봇 답변 VO
	
	private int mem_num;
	
}
