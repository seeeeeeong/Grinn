package kr.spring.poll.vo;

// 댓글 등록일 type을 Date -> String으로 변환
//import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"mem_photo"})
public class PollReplyVO {
	private int re_num; // 댓글 번호
	private String re_content; // 댓글 내용
	private String re_date; // 댓글 등록일
	private String re_mdate; // 댓글 수정일
	private String re_ip; // ip 주소
	private int mem_num; // 회원 번호
	private int poll_num; // 투표글 번호
	
	private byte[] mem_photo; // 회원 프로필 사진
	private String mem_photo_name; // 회원 프로필 사진명
	private String mem_id; // 회원 아이디
	private String mem_nickname; // 회원 프로필 이름
	
	public void setUpload(MultipartFile upload) throws Exception{
		setMem_photo(upload.getBytes());
		setMem_photo_name(upload.getOriginalFilename());
	}
	
	public void setRe_date(String re_date) {
		this.re_date = DurationFromNow.getTimeDiffLabel(re_date);
	}
	public void setRe_mdate(String re_mdate) {
		this.re_mdate = DurationFromNow.getTimeDiffLabel(re_mdate);
	}
}








