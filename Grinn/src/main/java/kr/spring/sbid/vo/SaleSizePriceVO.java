package kr.spring.sbid.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SaleSizePriceVO {
	private int item_num;     // 아이템 고유 번호
	private int sale_price;   // 판매 입찰 가격 
	private String item_size; // 아이템 사이즈 데이터
}

