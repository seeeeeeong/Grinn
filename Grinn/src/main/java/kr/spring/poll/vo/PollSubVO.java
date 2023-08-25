package kr.spring.poll.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PollSubVO {
	private int pollsub_num; // 투표 번호
	private int item_num; // 상품 번호
	private int poll_num; // 투표글 번호
	public int mem_num; // 회원번호
	
	private int poll_count; //
}
