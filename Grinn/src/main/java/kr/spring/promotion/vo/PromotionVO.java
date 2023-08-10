package kr.spring.promotion.vo;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"pro_photo1"})
public class PromotionVO {
	private int pro_num;
	@NotEmpty
	private String pro_name;
	@NotEmpty
	private String pro_content;
	private byte[] pro_photo1;
	private String pro_photoName1;
	private Date pro_regDate;
	@NotEmpty
	private String pro_openDate;
	@NotEmpty
	private String pro_cloDate;
	@Range(min=1, max=3)
	private int pro_ing;
	@Range(min=1, max=2)
	private int pro_hide;
	
	// 업로드 파일 처리
	public void setUpload1(MultipartFile upload1) throws Exception{
		// byte[]로 변환
		setPro_photo1(upload1.getBytes());
		// 사진명 구하기
		setPro_photoName1(upload1.getOriginalFilename());
	}
}
