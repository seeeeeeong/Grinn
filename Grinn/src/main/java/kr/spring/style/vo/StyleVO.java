package kr.spring.style.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StyleVO {
	private int st_num;
	private String st_phrase;
	private String st_photo1n;
	private String st_photo2n;
	private String st_photo3n;
	private String st_photo4n;
	private Date st_regdate;
	private Date st_mdate;
	private int mem_num;
	private int item_num1;
	private int item_num2;
	private int item_num3;
}