package kr.spring.fleaMarket.vo;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"market_poster", "market_thumbNail"})
public class MarketVO {
	private int market_num;
	@NotEmpty
	private String market_title;
	private String market_detail;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date market_startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date market_endDate;
	@NotEmpty
	private String place_name;
	private int market_type;
	private int booth_count;
	private int user_count;
	private int booth_fee;
	private byte[] market_poster;
	private String market_posterName;
	private byte[] market_thumbNail;
	private String market_thumbNailName;
	private Date regDate;
	private Date updateDate;
}
