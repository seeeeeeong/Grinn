package kr.spring.penalty.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PenaltyVO {
	private int pe_num;
	private int mem_num;
	private int pe_service_number;
	private int pe_score;
	private int pe_type;
	private Date pe_date;
}
