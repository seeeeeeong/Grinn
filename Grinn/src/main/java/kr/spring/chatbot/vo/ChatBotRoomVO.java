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
	private int mem_num; //회원번호
	private String mem_id; //회원아이디
	private String croom_question; //회원의 질문
	private String croom_answer; //답변
}
