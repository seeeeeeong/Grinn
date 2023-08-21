package kr.spring.item.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ItemTradeVO {
	private String item_size;
	private int sale_price;
	private int sale_cnt;
	private int purchase_price;
	private int purchase_cnt;
	private int item_num;
	
}
