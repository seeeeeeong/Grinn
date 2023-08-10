package kr.spring.fleaMarket.vo;

import java.sql.Date;

import org.hibernate.validator.constraints.Range;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BookingVO {
	private int book_num;
	private Date book_regDate;
	@Range(min=0, max=1)
	private int get_count;
	private int market_num;
	private int mem_num;
	
	private MarketVO marketVO;
}
