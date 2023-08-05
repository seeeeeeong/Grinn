package kr.spring.member.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	private int mem_num;
	@Pattern(regexp="^[A-Za-z0-9]{4,12}$")
	private String mem_id;
	private String mem_nickname;
	private int mem_auth;
	private String auto; 
	private String au_id;
	@NotEmpty
	private String mem_name;
	@Pattern(regexp="^[A-Za-z0-9]{4,12}$")
	private String mem_passwd;
	@NotEmpty
	private String mem_phone;
	@Email
	@NotEmpty
	private String mem_email;
	private String mem_zipcode;
	private String mem_address1;
	private String mem_address2;
	private byte[] mem_photo;
	private String mem_photo_name;
	private String mem_int;
	private Date mem_date;
	private Date mem_mdate;
	private int mem_point;
	
	// 비밀번호 일치 여부(Controller)
	public boolean isCheckedPassword(String userPasswd) {
		if(mem_auth > 1 && mem_passwd.equals(userPasswd)) {
			return true;
		}
		return false;
	}
	
	//=======이미지를 byte[]로 변환(BLOB 처리)=======//
	//(주의) 폼에서 파일 업로드 파라미터네임은 반드시 upload로 지정해야 함
	public void setUpload(MultipartFile upload)throws IOException{
		//MultipartFile -> byte[]
		setMem_photo(upload.getBytes());
		//파일 이름
		setMem_photo_name(upload.getOriginalFilename());
	}
}
