package kr.spring.item.vo;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString(exclude = {"item_photo1","item_photo2"})
@Setter
@Getter
public class ItemVO {
	private int item_num; //상품번호
	private String item_brand; //브랜드명
	private String item_name; //상품이름
	private String item_detail; //상품설명
	private String item_model; //상품모델명
	private String item_date; //상품출시일
	private String item_price; //상품정가
	private byte[] item_photo1; //상품 사진1
	private String item_photo1name;//상품사진1이름
	private byte[] item_photo2; //상품 사진2
	private String item_photo2name;//상품사진2이름
	private String item_keyword1; //상품검색키워드1
	private String item_keyword2; //상품검색키워드2
	private String item_keyword3; //상품검색키워드3
	private int item_cate; //상품분류
	private int item_gender; //성별
	private int item_status; //상품판매가능여부
	
	private int re_cnt; //댓글 개수
	private int fav_cnt; //좋아요 개수
	
	//이미지를 byte[] 배열로 변환(blob처리)
	//(주의) 폼에서 파일 업로드 파라미터 네임은 반드시 upload로 지정해야함
	public void setUpload(MultipartFile upload)throws IOException{
		//MultipartFile -> byte[]
		setItem_photo1(upload.getBytes());
		//파일이름
		setItem_photo1name(upload.getOriginalFilename());
	}
	
}
