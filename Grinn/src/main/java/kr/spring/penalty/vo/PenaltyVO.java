package kr.spring.penalty.vo;

import java.sql.Date;

import org.hibernate.validator.constraints.Range;

import kr.spring.member.vo.MemberVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PenaltyVO {
	private int pe_num;
	private int mem_num;
	@Range(min=1, max=3)
	private int pe_service_type; // 페널티 유형(1:게시판, 2:거래)
	@Range(min=0, max=100)
	private int pe_score;
	@Range(min=1, max=9)
	private int pe_type; // 부여 사유(1~3:게시글, 4~6:댓글, 7~9:거래)
	private Date pe_date;
	
	private MemberVO memberVO;
}
