package kr.spring.sbid.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SaleBidVO {
	private int sale_num;
	private int mem_num;
	private int item_num;
	private int item_sizenum;
	private int sale_price;
	private Date sale_regDate;
	private Date sale_deadline;
}
