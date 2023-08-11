package kr.spring.chatbot.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatBotAnswerVO {
	private int an_num; //답변번호
	private String an_intent; //질문의 의도 -> 키워드
	private String an_answer; //답변
}
