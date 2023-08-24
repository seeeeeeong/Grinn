package kr.spring.poll.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VoterVO {
	private int voter_num; // 투표 정보 번호
	private Date polling_date; // 투표일
	private int poll_num; // 투표글 번호
	private int pollsub_num; // 투표 번호
	private int mem_num; // 회원 번호
}
