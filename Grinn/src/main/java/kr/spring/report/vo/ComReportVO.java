package kr.spring.report.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ComReportVO {
	private int rcom_num;
	private int rep_type;
	private String rep_com;//추가 내용
	private int rep_hide;//댓글 공개 여부
	private int rep_status;//신고 접수 상황
	private Date rep_regdate;
	private int com_num;
	private int report_mem;//신고자
	private int reported_mem;//피신고자
	
	private String report_id;//신고자 ID
	private String reported_id;//피신고자 ID
}
