package kr.spring.chatbot.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatBotVO {
	private int croom_num;
	private int mem_num;
	private String mem_id;
	private Date croom_regdate;
}
