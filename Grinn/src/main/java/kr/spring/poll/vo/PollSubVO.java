package kr.spring.poll.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PollSubVO {
	private int pollsub_num; // 투표 번호
	private String answer; // 투표 항목
	private int poll_acount; // 투표수
	private int poll_num; // 투표글 번호
	private int polling_status; // 0: 미선택, 1: 선택
	
	private int mem_num;
}
