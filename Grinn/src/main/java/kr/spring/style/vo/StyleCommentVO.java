package kr.spring.style.vo;

import java.sql.Date;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StyleCommentVO {
	private int com_num;
	private String com_comment;
	private Date com_regdate;
	private Date com_mdate;
	private int mem_num;
	private int st_num;
	
	private String mem_id; //회원 아이디
	private String mem_photo; //프로필 사진

}
