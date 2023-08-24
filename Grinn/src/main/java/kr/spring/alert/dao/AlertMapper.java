package kr.spring.alert.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.alert.vo.AlertVO;
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
	
	// 스타일 게시물 좋아요 누른 회원, 작성자 아이디, 스타일 번호
	@Select("select m.mem_num, m.mem_id, s.st_num from style_fav sf left join style s on s.st_num = sf.st_num left join member m on sf.mem_num = m.mem_num WHERE sf.st_num IN(select st_num from style where mem_num = #{mem_num})")
	public List<AlertVO> favInfo(Integer mem_num);
	
	// 스타일 게시물 댓글내용, 작성자 아이디, 스타일 번호
	@Select("select m.mem_num, sc.com_comment, m.mem_id, s.st_num from style_comment sc left join style s on s.st_num = sc.st_num left join member m on sc.mem_num = m.mem_num WHERE sc.st_num IN(select st_num from style where mem_num = #{mem_num})")
	public List<AlertVO> commentInfo(Integer mem_num);
	
	// 스타일 게시물 댓글 내용
	@Select("SELECT com_comment FROM style_comment WHERE st_num = #{st_num} AND mem_num = #{mem_num}")
	public List<String> comment(@Param(value="st_num") Integer st_num, @Param(value="mem_num") Integer mem_num);
	
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
	@Select("SELECT td.trade_state, td.trade_regDate, td.item_num, i.item_name FROM purchase_bid pb JOIN trade_detail td ON pb.item_num = td.item_num JOIN item i ON td.item_num = i.item_num WHERE pb.mem_num = #{mem_num}")
	public List<AlertVO> purchaseInfo(Integer mem_num);
	
	// 판매 정보
	@Select("SELECT td.trade_state, td.trade_regDate, td.item_num, i.item_name FROM sale_bid s JOIN trade_detail td ON s.item_num = td.item_num JOIN item i ON td.item_num = i.item_num WHERE s.mem_num = #{mem_num}")
	public List<AlertVO> saleInfo(Integer mem_num);
	
	// item_num에 해당하는 item 테이블의 정보 가져오기
	@Select("SELECT * FROM item WHERE item_num = #{item_num}")
	public List<ItemVO> selectItem(Integer item_num);
	
}
