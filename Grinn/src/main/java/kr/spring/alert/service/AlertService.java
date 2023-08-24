package kr.spring.alert.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kr.spring.alert.vo.AlertVO;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.trade.vo.TradeVO;

public interface AlertService {
	

	
	// 스타일 게시물 좋아요 누른 회원, 작성자 아이디, 스타일 번호
	public List<AlertVO> favInfo(Integer mem_num);
	
	// 스타일 게시물 댓글내용, 작성자 아이디, 스타일 번호
	public List<AlertVO> commentInfo(Integer mem_num);
	

	// 프로필 이미지
	public MemberVO profilePhoto(Integer mem_num);	


	// 팔로우 한 회원 id, mem_num
	public List<MemberVO> followId(Integer mem_num);
	
	// 팔로우 한 회원 프로필 이미지
	public MemberVO followPhoto(Integer mem_num);
	
	// 구매 정보
	public List<AlertVO> purchaseInfo(Integer mem_num);
	
	// 판매 정보
	public List<AlertVO> saleInfo(Integer mem_num);

}
