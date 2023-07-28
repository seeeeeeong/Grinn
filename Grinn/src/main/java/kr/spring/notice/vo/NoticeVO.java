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
	private int no_status;//1.공지사항 2.자주묻는질문 3.검수기준 (not null)
	private int no_category;//1.이용정책 2.공통 3.구매 4.판매
}
