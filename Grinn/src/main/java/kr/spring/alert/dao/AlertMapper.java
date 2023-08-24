package kr.spring.alert.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.trade.vo.TradeVO;

@Mapper
public interface AlertMapper {

	// 스타일 테이블의 정보 구하기
	@Select("SELECT * FROM style WHERE mem_num=#{mem_num} AND st_hide = 0")
	public List<StyleVO> selectStyleInfo(Integer mem_num);
	
	// 스타일 게시물 좋아요 한 회원의 id,mem_num
	@Select("SELECT m.mem_id, m.mem_num FROM style_fav sf JOIN member m ON sf.mem_num = m.mem_num WHERE sf.st_num = #{st_num}")
	public List<MemberVO> favId(Integer st_num);
	
	// 스타일 게시물 댓글 작성자 id, mem_num
	@Select("SELECT m.mem_id, m.mem_num FROM style_comment sc JOIN member m ON sc.mem_num = m.mem_num WHERE sc.st_num = #{st_num}")
	public List<MemberVO> commentId(Integer st_num);
	
	// 스타일 게시물 댓글 내용
	@Select("SELECT com_comment,st_num FROM style_comment WHERE st_num = #{st_num}")
	public List<String> comment(Integer st_num);
	
	// 프로필 이미지
	@Select("SELECT * FROM member_detail WHERE mem_num = #{mem_num}")
	public MemberVO profilePhoto(Integer mem_num);	

	// 팔로우 한 회원 id, mem_num
	@Select("SELECT m.mem_id, m.mem_num FROM follow f JOIN member m ON f.from_user = m.mem_num WHERE f.to_user = #{mem_num}")
	public List<MemberVO> followId(Integer mem_num);
	
	// 팔로우 한 회원 프로필 이미지
	@Select("SELECT md.mem_photo, md.mem_photo_name FROM follow f JOIN member_detail md ON f.from_user = md.mem_num WHERE f.to_user = #{mem_num}")
	public MemberVO followPhoto(Integer mem_num);	

	// 구매 정보
	@Select("SELECT trade_detail.* FROM purchase_bid JOIN trade_detail ON purchase_bid.item_num = trade_detail.item_num WHERE purchase_bid.mem_num = #{mem_num}")
	public List<TradeVO> purchaseInfo(Integer mem_num);
	
	// 판매 정보
	@Select("SELECT trade_detail.* FROM sale_bid JOIN trade_detail ON sale_bid.item_num = trade_detail.item_num WHERE sale_bid.mem_num = #{mem_num}")
	public List<TradeVO> saleInfo(Integer mem_num);
	
	// item_num에 해당하는 item 테이블의 정보 가져오기
	@Select("SELECT * FROM item WHERE item_num = #{item_num}")
	public List<ItemVO> selectItem(Integer item_num);
	
}
