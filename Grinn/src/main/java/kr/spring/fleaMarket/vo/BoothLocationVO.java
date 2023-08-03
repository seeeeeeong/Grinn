package kr.spring.fleaMarket.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoothLocationVO {
	private int location_num;
	private int market_num;
	private int[] location_row;
	private int[] location_column;
	private int booth_comp;
	private Date location_regDate;
	private Date location_updateDate;
}
