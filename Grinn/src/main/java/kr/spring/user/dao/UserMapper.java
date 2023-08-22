package kr.spring.user.dao;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.item.vo.ItemFavVO;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleFavVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.trade.vo.TradeVO;

@Mapper
public interface UserMapper {

	// 회원정보를 이용한 회원정보 구하기
	@Select("SELECT * FROM member m JOIN member_detail d ON m.mem_num=d.mem_num WHERE m.mem_num=#{mem_num}")
	public MemberVO selectMember(Integer mem_num);

	// 프로필 이미지 업데이트
	@Update("UPDATE member_detail SET mem_photo=#{mem_photo},mem_photo_name=#{mem_photo_name} WHERE mem_num=#{mem_num}")
	public void updateProfile(MemberVO member);

	// 이미지 삭제
	@Delete("UPDATE member_detail SET mem_photo=null, mem_photo_name=null WHERE mem_num=#{mem_num}")
	public void deleteProfile(Integer mem_num);

	// 회원탈퇴
	@Update("UPDATE member SET mem_auth=0 WHERE mem_num=#{mem_num}")
	public void deleteMember(Integer mem_num);

	@Delete("DELETE FROM member_detail WHERE mem_num=#{mem_num}")
	public void deleteMember_detail(Integer mem_num);

	// 이메일 변경
	@Update("UPDATE member_detail SET mem_email=#{mem_email} WHERE mem_num=#{mem_num}")
	public void updateEmail(MemberVO member);

	// 전화번호 변경
	@Update("UPDATE member_detail SET mem_phone=#{mem_phone} WHERE mem_num=#{mem_num}")
	public void updatePhoneNumber(MemberVO member);

	// 배송지 추가
	@Insert("INSERT INTO member_detail (mem_num, mem_zipcode, mem_address1, mem_address2) VALUES (#{mem_num}, #{mem_zipcode}, #{mem_address1}, #{mem_address2})")
	public void addShippingAddress(MemberVO member);

	// 배송지 변경
	@Update("UPDATE member_detail SET mem_zipcode=#{mem_zipcode}, mem_address1=#{mem_address1}, mem_address2=#{mem_address2} WHERE mem_num=#{mem_num}")
	public void updateShippingAddress(MemberVO member);

	// 배송지 삭제
	@Update("UPDATE member_detail SET mem_zipcode=NULL, mem_address1=NULL, mem_address2=NULL WHERE mem_num=#{mem_num}")
	public void deleteShippingAddress(int mem_num);

	// 닉네임 추가
	@Update("UPDATE member SET mem_nickname=#{mem_nickname} WHERE mem_num=#{mem_num}")
	public void addNickname(MemberVO member);

	// 닉네임 변경
	@Update("UPDATE member SET mem_nickname=#{mem_nickname} WHERE mem_num=#{mem_num}")
	public void updateNickname(MemberVO member);

	// 소개글 추가
	@Update("UPDATE member_detail SET mem_int=#{mem_int} WHERE mem_num=#{mem_num}")
	public void addIntroduction(MemberVO member);

	// 소개글 변경
	@Update("UPDATE member_detail SET mem_int=#{mem_int} WHERE mem_num=#{mem_num}")
	public void updateInt(MemberVO member);

	// 비밀번호 변경
	@Update("UPDATE member_detail SET mem_passwd=#{mem_passwd} WHERE mem_num=#{mem_num}")
	public void updatePassword(MemberVO member);

	// 구매입찰 count
	@Select("SELECT count(*) AS purchased_count FROM purchase_bid WHERE mem_num = #{mem_num}")
	public int purchasedCount(Integer mem_num);

	// 구매입찰 trade_state : 2,3,4,6
	@Select("SELECT count(*) AS ongoing_count FROM purchase_bid pb JOIN trade_detail td ON pb.item_num = td.item_num WHERE pb.mem_num = #{mem_num} AND td.trade_state IN (2, 3, 4, 6)")
	public int ongoingCount(Integer mem_num);

	// 구매입찰 trade_state : 5
	@Select("SELECT count(*) AS completed_count FROM purchase_bid pb JOIN trade_detail td ON pb.item_num = td.item_num WHERE pb.mem_num = #{mem_num} AND td.trade_state = 5")
	public int completedCount(Integer mem_num);

	// 구매 상품
	@Select("SELECT i.item_num, i.item_name FROM purchase_bid pb JOIN item i ON pb.item_num = i.item_num WHERE pb.mem_num = #{mem_num}")
	public List<ItemVO> purchasedItems(Integer mem_num);

	// 구매날짜
	@Select("SELECT td.trade_regdate FROM purchase_bid pb JOIN trade_detail td ON pb.item_num = td.item_num WHERE pb.mem_num = #{mem_num}")
	public List<Date> purchasedDate(Integer mem_num);

	// 구매상태(거래 상태)
	@Select("SELECT td.trade_state FROM purchase_bid pb JOIN trade_detail td ON pb.item_num = td.item_num WHERE pb.mem_num = #{mem_num}")
	public List<Integer> purchasedState(Integer mem_num);

	// 판매입찰 count
	@Select("SELECT count(*) AS saled_count FROM sale_bid WHERE mem_num = #{mem_num}")
	public int saledCount(Integer mem_num);

	// 판매입찰 trade_state : 2,3,4,6
	@Select("SELECT count(*) AS ongoing_count FROM sale_bid sb JOIN trade_detail td ON sb.item_num = td.item_num WHERE sb.mem_num = #{mem_num} AND td.trade_state IN (2, 3, 4, 6)")
	public int saledOngoingCount(Integer mem_num);

	// 판매입찰 trade_state : 5
	@Select("SELECT count(*) AS completed_count FROM sale_bid sb JOIN trade_detail td ON sb.item_num = td.item_num WHERE sb.mem_num = #{mem_num} AND td.trade_state = 5")
	public int saledCompletedCount(Integer mem_num);

	// 판매 상품
	@Select("SELECT i.item_num, i.item_name FROM sale_bid sb JOIN item i ON sb.item_num = i.item_num WHERE sb.mem_num = #{mem_num}")
	public List<ItemVO> saledItems(Integer mem_num);

	// 판매날짜
	@Select("SELECT sb.sale_regdate FROM sale_bid sb JOIN trade_detail td ON sb.item_num = td.item_num WHERE sb.mem_num = #{mem_num}")
	public List<Date> saledDate(Integer mem_num);

	// 판매상태(거래 상태)
	@Select("SELECT td.trade_state FROM sale_bid sb JOIN trade_detail td ON sb.item_num = td.item_num WHERE sb.mem_num = #{mem_num}")
	public List<Integer> saledState(Integer mem_num);

	// 관심상품 전체 개수
	@Select("SELECT COUNT(*) FROM item_fav WHERE mem_num = #{mem_num}")
	public int selectFavoriteItemsCount(Integer mem_num);

	// 관심상품
	@Select("SELECT i.item_num ,i.item_name, i.item_brand, i.item_price " + "FROM item_fav f "
			+ "JOIN item i ON f.item_num = i.item_num " + "WHERE f.mem_num = #{mem_num}")
	public List<ItemVO> selectFavoriteItems(Integer mem_num);

	// item_num에 해당하는 item 테이블의 정보 가져오기
	@Select("SELECT * FROM item WHERE item_num = #{item_num}")
	public ItemVO selectItem(Integer item_num);

	// 좋아요한 게시물 정보 가져오기
	@Select("SELECT s.st_num, s.st_phrase, s.mem_num FROM style s JOIN style_fav sf ON s.st_num = sf.st_num WHERE sf.mem_num = #{mem_num}")
	public List<StyleVO> selectLikedStyles(Integer mem_num);

	// 좋아요한 게시물의 st_num에 해당하는 style 테이블의 정보 가져오기
	@Select("SELECT * FROM style WHERE st_num = #{st_num}")
	public StyleVO selectStyle(Integer st_num);

	// 좋아요한 게시물 작성자의 프로필 사진
	@Select("SELECT sd.mem_photo, sd.mem_photo_name FROM style s JOIN member_detail sd ON s.mem_num = sd.mem_num WHERE s.st_num = #{st_num}")
	public MemberVO selectProfile(Integer st_num);

	// 좋아요한 게시물 작성자의 아이디
	@Select("SELECT m.mem_id FROM style s JOIN member m ON s.mem_num = m.mem_num WHERE s.st_num = #{st_num}")
	public String selectProfileId(Integer st_num);

	// 좋아요 기능
	@Select("SELECT * FROM style_fav WHERE st_num=#{st_num} AND mem_num=#{mem_num}")
	public StyleFavVO selectFav(StyleFavVO fav);

	// 좋아요 개수
	@Select("SELECT COUNT(*) FROM style_fav WHERE st_num=#{st_num}")
	public int selectFavCount(Integer st_num);

	// 좋아요
	@Insert("INSERT INTO style_fav (stfav_num,mem_num,st_num) VALUES (style_fav_seq.nextval,#{mem_num},#{st_num})")
	public void insertFav(StyleFavVO fav);

	// 좋아요 취소
	@Delete("DELETE FROM style_fav WHERE stfav_num=#{stfav_num}")
	public void deleteFav(Integer stfav_num);

	@Delete("DELETE FROM style_fav WHERE st_num=#{st_num}")
	public void deleteFavByStNum(Integer st_num);

	// 패널티 통합 점수
	@Select("SELECT SUM(pe_score) FROM penalty WHERE mem_num = #{mem_num}")
	public Integer getPenaltyTotalScore(Integer mem_num);

	// 게시판 페널티
	//@Select("SELECT * FROM penalty_board WHERE mem_num = #{mem_num}")
	//public List<MemberVO> getPenaltyBoard(Integer mem_num);

	// 거래 페널티
	//@Select("SELECT * FROM penalty_trade WHERE mem_num = #{mem_num}")
	//public List<MemberVO> getPenaltyTrade(Integer mem_num);

}
