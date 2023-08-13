package kr.spring.chatbot.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatBotVO {
	private int croom_num; //방번호
	private int mem_num; //회원번호
	private String mem_id; //회원아이디
	private Date croom_regdate; //챗봇시작 날짜
	
}
