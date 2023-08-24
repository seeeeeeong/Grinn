package kr.spring.poll.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PollReportVO {
	private int report_num; // 투표 신고 번호
	private int reporter_num; // 신고자 회원 번호
	private int targeter_num; // 신고당한 회원 번호
	private int report_reason; // 신고 사유 (0: 불법적인 게시글 내용, 1: 청소년에게 유해한 내용, 2: 욕설/혐오/차별적 표현, 3: 개인정보 노출 게시글)
	private int report_comment; // 신고 상세사유
	private int report_status; // 신고 처리 상태 (0: 처리, 1: 미처리)
	private int report_hide; // 신고 투표글 처리 상태 (0: 비공개, 1: 공개)
	private Date report_date; // 신고일
	private int poll_num; // 신고할 투표글 번호
}
