package kr.spring.style.vo;

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
	private String com_regdate;
	private String com_mdate;
	private int mem_num;
	private int st_num;
	
	private String mem_id; //회원 아이디
	private String mem_photo; //프로필 사진
	
	public void setCom_regdate(String com_regdate) {
		this.com_regdate = DurationFromNow.getTimeDiffLabel(com_regdate);
	}
	public void setCom_mdate(String com_mdate) {
		this.com_mdate = DurationFromNow.getTimeDiffLabel(com_mdate);
	}
}
