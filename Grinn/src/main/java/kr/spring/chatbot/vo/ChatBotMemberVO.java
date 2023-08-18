package kr.spring.chatbot.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatBotMemberVO {
	private int croom_num;
	private int mem_num;
	private Date member_date;
	
	private String mem_id;
}
