package kr.spring.report.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StyleReportVO {
	private int rst_num;
	private int rep_type;
	private String rep_com;//추가 내용
	private int rep_hide;//게시물 공개 여부
	private int rep_status;//신고 접수 상황
	private Date rep_regdate;
	private int st_num;
	private int report_mem;//신고자
	private int reported_mem;//피신고자
}
