package kr.spring.trade.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TradeVO {
	private int trade_num;
	private int item_num;
	private int buyer_num;
	private int seller_num;
	private int trade_state;
	private Date trade_regDate;
	private int item_sizenum;
	private int trade_price;
	private String trade_zipcode;
	private String trade_address1;
	private String trade_address2;
}
