package kr.spring.notice.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeVO {
	private int no_num;
	private int mem_num;
	private String no_title;
	private String not_content;
	private Date no_regdate;
	private Date no_modifydate;
	private int no_status;
	private int no_category;
	
}
