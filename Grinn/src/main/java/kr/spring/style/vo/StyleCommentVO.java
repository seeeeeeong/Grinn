package kr.spring.style.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"mem_photo"})
public class StyleCommentVO {
	private int com_num;
	private String com_comment;
	private Date com_regdate;
	private Date com_mdate;
	private int mem_num;
	private int st_num;
	
	private String mem_id; //회원 아이디
	private byte[] mem_photo;//프로필 사진
	private String mem_photo_name; //프로필 사진명

}
