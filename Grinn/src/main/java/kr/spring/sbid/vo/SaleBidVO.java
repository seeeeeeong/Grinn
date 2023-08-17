package kr.spring.sbid.vo;

import java.io.IOException;
import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SaleBidVO {
	private int sale_num;
	private int mem_num;
	private int item_num;
	private int item_sizenum;
	private int sale_price;
	private Date sale_regDate;
	private Date sale_deadline;
	private String sale_zipcode;
	private String sale_address1;
	private String sale_address2;
	
	private String item_size;
	
	// 아이템 사진 및 아이템 정보
	private String item_brand; // 브랜드명
	private String item_name; // 상품이름
	private byte[] item_photo1; // 상품 사진1
	private String item_photo1name;// 상품사진1이름

	// 이미지를 byte[] 배열로 변환(blob처리)
	// (주의) 폼에서 파일 업로드 파라미터 네임은 반드시 upload로 지정해야함
	public void setUpload(MultipartFile upload) throws IOException {
		// MultipartFile -> byte[]
		setItem_photo1(upload.getBytes());
		// 파일이름
		setItem_photo1name(upload.getOriginalFilename());
	}
}
