package kr.spring.pbid.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PurchaseSizePriceVO {
	private int item_num;       // 아이템 고유 번호
	private int purchase_price; // 구매 입찰 가격
	private String item_size;   // 아이템 사이즈 데이터
}
