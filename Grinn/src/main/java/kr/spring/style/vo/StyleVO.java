package kr.spring.style.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"st_photo1", "st_photo2", "st_photo3", "st_photo4"})
public class StyleVO {
	private int st_num;
	private String st_phrase;
	@NotEmpty
	private String st_photo1n;
	private String st_photo2n;
	private String st_photo3n;
	private String st_photo4n;
	private byte[] st_photo1;
	private byte[] st_photo2;
	private byte[] st_photo3;
	private byte[] st_photo4;
	private Date st_regdate;
	private Date st_mdate;
	private int mem_num;
	private int item_num1;
	private int item_num2;
	private int item_num3;
	private String mem_id;
	private byte[] mem_photo;
	private String mem_photo_name;
	private String item_photo1name;
	private String item_name;
	private int st_hide;
	
	//좋아요
	private int fav_cnt;
		
	public void setUpload1(MultipartFile upload1) throws IOException{
		//MultipartFile -> byte[]
		setSt_photo1(upload1.getBytes());
		//파일이름
		setSt_photo1n(upload1.getOriginalFilename());
	}
	
	public void setUpload2(MultipartFile upload2) throws IOException{
		//MultipartFile -> byte[]
		setSt_photo2(upload2.getBytes());
		//파일이름
		setSt_photo2n(upload2.getOriginalFilename());
	}
	
	public void setUpload3(MultipartFile upload3) throws IOException{
		//MultipartFile -> byte[]
		setSt_photo3(upload3.getBytes());
		//파일이름
		setSt_photo3n(upload3.getOriginalFilename());
	}
	
	public void setUpload4(MultipartFile upload4) throws IOException{
		//MultipartFile -> byte[]
		setSt_photo4(upload4.getBytes());
		//파일이름
		setSt_photo4n(upload4.getOriginalFilename());
	}
	
	
	
}