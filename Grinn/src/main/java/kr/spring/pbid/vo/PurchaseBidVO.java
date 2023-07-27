package kr.spring.pbid.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PurchaseBidVO {
	private int purchase_num;
	private int mem_num;
	private int item_num;
	private int item_sizenum;
	private int purchase_price;
	private Date purchase_regDate;
	private Date purchase_deadline;
}
