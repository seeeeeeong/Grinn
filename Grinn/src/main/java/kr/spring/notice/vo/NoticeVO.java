package kr.spring.notice.vo;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeVO {
	private int no_num;
	private int mem_num;
	@NotEmpty
	private String no_title;
	@NotEmpty
	private String no_content;
	private Date no_regdate;
	private Date no_modifydate;
	private int no_status;//1.공지사항 2.자주묻는질문 3.검수기준 (not null)
	private int no_category;//1.이용정책 2.공통 3.구매 4.판매 - 자주묻는질문
	private int no_policy;//1.신발 2.상의 3.하의 4.패션잡화 5.프리미엄시계 6.프리미엄가방 - 검수기준
	
	private int mem_auth;
}
