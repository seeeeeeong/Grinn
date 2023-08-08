package kr.spring.promotion.vo;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PromotionVO {
	private int pro_num;
	@NotEmpty
	private String pro_name;
	@NotEmpty
	private String pro_content;
	private byte[] photo1;
	private String photo_name1;
	private Date pro_regDate;
	@NotEmpty
	private String pro_openDate;
	@NotEmpty
	private String pro_cloDate;
	private int pro_ing;
	private int pro_hide;
			
}
