package kr.spring.item.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class ItemstVO {
	private int st_num;
	private String st_phrase;
	private String mem_id;
	private int item_num1;
	private int item_num2;
	private int item_num3;
	private int mem_num;
}
