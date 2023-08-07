package kr.spring.fleaMarket.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BookingVO {
	private int book_num;
	private Date book_regDate;
	private int market_num;
	private int mem_num;
	
	private MarketVO marketVO;
}
