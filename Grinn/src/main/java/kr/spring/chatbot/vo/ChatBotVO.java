package kr.spring.chatbot.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatBotVO {
	private int c_num; //챗봇번호(기본키)
	private int croom_num; //방번호
	private int mem_num; //회원번호
	private String message; //메세지
	private String croom_regdate; //챗봇시작 날짜
	
}
