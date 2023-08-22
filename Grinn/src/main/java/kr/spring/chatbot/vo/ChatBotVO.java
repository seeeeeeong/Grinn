package kr.spring.chatbot.vo;

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
	
	private ChatBotAnswerVO answerVO; //챗봇답변
	private String keyword; //답변에 필요한 키워드
	private String answer; //답변
	//키워드에 답변 intent를 저장하려고 하고있음;
	public void setKeyword(String keyword) {
		if(message.contains(keyword)) {
			this.keyword = keyword;
		}
	}
}
