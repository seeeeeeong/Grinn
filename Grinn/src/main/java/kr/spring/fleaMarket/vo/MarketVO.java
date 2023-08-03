package kr.spring.fleaMarket.vo;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"market_poster", "market_thumbNail"})
public class MarketVO {
	private int market_num;
	@NotEmpty
	private String market_title;
	private String market_detail;
	@NotEmpty
	private String market_startDate;
    @NotEmpty
	private String market_endDate;
	@NotEmpty
	private String place_name;
	private int market_type;
	@Range(min=1,max=999)
	private int booth_count;
	@Range(min=1,max=99)
	private int user_count;
	@Range(min=0,max=999999)
	private int booth_fee;
	private byte[] market_poster;
	private String market_posterName;
	private byte[] market_thumbNail;
	private String market_thumbNailName;
	private Date regDate;
	private Date updateDate;
	
	// 업로드 파일 처리
	public void setUpload1(MultipartFile upload1) throws Exception{
		// byte[]로 변환
		setMarket_poster(upload1.getBytes());
		// 포스터명 구하기
		setMarket_posterName(upload1.getOriginalFilename());
	}
	
	public void setUpload2(MultipartFile upload2) throws Exception{
		// byte[]로 변환
		setMarket_thumbNail(upload2.getBytes());
		// 썸네일명 구하기
		setMarket_thumbNailName(upload2.getOriginalFilename());
	}
}
