package kr.spring.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.item.vo.ItemVO;
import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.trade.vo.TradeVO;

@Mapper
public interface UserMapper {
	
	//회원정보를 이용한 회원정보 구하기
	@Select("SELECT * FROM member m JOIN member_detail d " + "ON m.mem_num=d.mem_num WHERE m.mem_num=#{mem_num}")
	public MemberVO selectMember(Integer mem_num);	
		
	//회원탈퇴
	@Update("UPDATE member SET mem_auth=0 WHERE mem_num=#{mem_num}")
	public void deleteMember(Integer mem_num);
	@Delete("DELETE FROM member_detail WHERE mem_num=#{mem_num}")
	public void deleteMember_detail(Integer mem_num);	

	//이메일 변경
	@Update("UPDATE member_detail SET mem_email=#{mem_email} WHERE mem_num=#{mem_num}")
	public void updateEmail(MemberVO member);

	//전화번호 변경
	@Update("UPDATE member_detail SET mem_phone=#{mem_phone} WHERE mem_num=#{mem_num}")
	public void updatePhoneNumber(MemberVO member);

	//배송지 추가
	@Insert("INSERT INTO member_detail (mem_num, mem_zipcode, mem_address1, mem_address2) VALUES (#{mem_num}, #{mem_zipcode}, #{mem_address1}, #{mem_address2})")
	public void addShippingAddress(MemberVO member);

	//배송지 변경
	@Update("UPDATE member_detail SET mem_zipcode=#{mem_zipcode}, mem_address1=#{mem_address1}, mem_address2=#{mem_address2} WHERE mem_num=#{mem_num}")
	public void updateShippingAddress(MemberVO member);

	//배송지 삭제
	@Update("UPDATE member_detail SET mem_zipcode=NULL, mem_address1=NULL, mem_address2=NULL WHERE mem_num=#{mem_num}")
	public void deleteShippingAddress(int mem_num);

	//닉네임 추가
	@Update("UPDATE member SET mem_nickname=#{mem_nickname} WHERE mem_num=#{mem_num}")
	public void addNickname(MemberVO member);

	//닉네임 변경
	@Update("UPDATE member SET mem_nickname=#{mem_nickname} WHERE mem_num=#{mem_num}")
	public void updateNickname(MemberVO member); 
	
	//소개글 추가
	@Update("UPDATE member_detail SET mem_int=#{mem_int} WHERE mem_num=#{mem_num}")
	public void addIntroduction(MemberVO member);

	//소개글 변경
	@Update("UPDATE member_detail SET mem_int=#{mem_int} WHERE mem_num=#{mem_num}")
	public void updateInt(MemberVO member); 
	
	//비밀번호 변경
	@Update("UPDATE member_detail SET mem_passwd=#{mem_passwd} WHERE mem_num=#{mem_num}")
	public void updatePassword(MemberVO member); 
		
	//구매내역 - trade
	@Select("SELECT td.trade_num, td.trade_regDate, td.trade_state " +
	        "FROM trade t " +
	        "JOIN trade_detail td ON t.trade_num = td.trade_num " +
	        "WHERE t.buyer_num = #{mem_num}")
	public List<TradeVO> selectPurchasedTrades(Integer mem_num);
	
	//구매내역 - Item
	@Select("SELECT i.item_photo1, i.item_name, i.item_brand, i.item_price " +
	        "FROM trade t " +
	        "JOIN trade_detail td ON t.trade_num = td.trade_num " +
	        "JOIN item i ON td.item_num = i.item_num " +
	        "JOIN item_size s ON td.item_sizenum = s.item_sizenum " +
	        "WHERE t.buyer_num = #{mem_num}")
	public List<ItemVO> selectPurchasedItems(Integer mem_num);
		
	//구매내역 - Size
	@Select("SELECT s.item_size FROM item i " +
	        "JOIN trade t ON i.item_num = t.item_num " +
	        "JOIN trade_detail td ON t.trade_num = td.trade_num " +
	        "JOIN item_size s ON td.item_sizenum = s.item_sizenum " +
	        "WHERE t.buyer_num = #{mem_num}")
	public List<ItemSizeVO> selectPurchasedItemSize(Integer mem_num);
	
	//판매 내역 - Trade
	@Select("SELECT td.trade_num, td.trade_regDate, td.trade_state " +
	        "FROM trade t " +
	        "JOIN trade_detail td ON t.trade_num = td.trade_num " +
	        "WHERE t.seller_num = #{mem_num}")
	public List<TradeVO> selectSoldTrades(Integer mem_num);

	//판매 내역 - Item
	@Select("SELECT i.item_photo1, i.item_name, i.item_brand, i.item_price " +
	        "FROM trade t " +
	        "JOIN item i ON t.item_num = i.item_num " +
	        "JOIN trade_detail td ON t.trade_num = td.trade_num " +
	        "JOIN item_size s ON td.item_sizenum = s.item_sizenum " +
	        "WHERE t.seller_num = #{mem_num}")
	public List<ItemVO> selectSoldItems(Integer mem_num);
	
	//판매내역 - Size
	@Select("SELECT s.item_size FROM item i " +
	        "JOIN trade t ON i.item_num = t.item_num " +
	        "JOIN trade_detail td ON t.trade_num = td.trade_num " +
	        "JOIN item_size s ON td.item_sizenum = s.item_sizenum " +
	        "WHERE t.seller_num = #{mem_num}")
	public List<ItemSizeVO> selectSoldItemSize(Integer mem_num);
	
	//관심 상품
	@Select("SELECT i.item_photo1, i.item_name, i.item_brand, i.item_price " +
	        "FROM item_fav f " +
	        "JOIN item i ON f.item_num = i.item_num " +
	        "WHERE f.mem_num = #{mem_num}")
	public List<ItemVO> selectFavoriteItems(Integer mem_num);
	
	//좋아요
	@Select("SELECT s.st_photo1, s.st_phrase, md.mem_photo, m.mem_nickname " +
	        "FROM style_fav sf " +
	        "JOIN member m ON sf.mem_num = m.mem_num " +
	        "JOIN member_detail md ON sf.mem_num = md.mem_num " +
	        "JOIN style s ON sf.st_num = s.st_num " +
	        "WHERE sf.mem_num = #{mem_num}")
	public List<MemberVO> selectLikedStyles(Integer mem_num);
	
    //패널티 통합 점수
    @Select("SELECT pe_total FROM penalty WHERE mem_num = #{mem_num}")
    public Integer getPenaltyTotalScore(Integer mem_num);

    //게시판 페널티
    @Select("SELECT * FROM penalty_board WHERE mem_num = #{mem_num}")
    public List<MemberVO> getPenaltyBoard(Integer mem_num);

    //거래 페널티
    @Select("SELECT * FROM penalty_trade WHERE mem_num = #{mem_num}")
    public List<MemberVO> getPenaltyTrade(Integer mem_num);
    

}
