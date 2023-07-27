package kr.spring.itemsize.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ItemSizeVO {
	// 아이템 정보와 사이즈 정보를 가지는 VO 객체
	// 아이템 정보
	private int item_num;
	private String item_brand;
	private String item_name;
	private String item_detail;
	private Date item_date;
	private int item_price;
	private String item_photo1;
	private String item_photo1name;
	private int item_cate;
	private int item_status;
	
	// 사이즈 정보
	private int item_sizenum;
	private String item_size;
}
