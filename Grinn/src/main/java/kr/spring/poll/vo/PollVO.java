package kr.spring.poll.vo;


//댓글 등록일 type을 Date -> String으로 변환
import java.util.Date;

import javax.validation.constraints.NotEmpty;


import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude={"mem_photo", "item_photo1"})
public class PollVO {
	private int poll_num; // 투표글 번호
	@NotEmpty
	private String poll_title; // 투표글 제목
	private String poll_content; // 투표글 내용
	private int poll_item1; // 투표 항목1(상품번호)
	private int poll_item2; // 투표 항목2(상품번호)
	private int poll_item3; // 투표 항목3(상품번호)
	private int poll_item4; // 투표 항목4(상품번호)
	
	private String poll_date; // 투표글 등록일
	@NotEmpty
	private String poll_deadline; // 투표글 마감일
	private int poll_status; // 투표 상태(0: 마감, 1: 진행중)
	private int poll_hit; // 투표글 조회수
	private String poll_ip; // ip 주소
	private int mem_num; // 회원 번호
	
	private byte[] mem_photo; // 회원 프로필 사진
	private String mem_photo_name; // 회원 프로필 사진명
	private String mem_id; // 회원 아이디
	private String mem_nickname; // 회원 프로필 이름
	
	// 투표 항목으로 불러올 상품 정보
	private byte[] item_photo1; // 상품 사진
	private String item_photo1name; // 상품 사진명
	private String item_brand; // 상품 브랜드
	private String item_name; // 상품명
	
	private String poll_items;
}

















