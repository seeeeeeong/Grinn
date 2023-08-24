package kr.spring.alert.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AlertVO {
	private int st_num;
	private String com_comment;
	
	private String mem_id;
	private int mem_num;
	
	private int trade_state;
	private Date trade_regDate;
	
	private int item_num;
	private String item_name;
}
