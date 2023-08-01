package kr.spring.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.item.vo.ItemVO;
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
	
	//회원정보 수정 - 프로필 정보 (프로필 이미지, 이메일, 전화번호, 프로필 이름, 소개, 주소록)
	@Update("UPDATE member_detail SET mem_photo=#{mem_photo}, mem_email=#{mem_email}, mem_phone=#{mem_phone}, mem_nickname=#{mem_nickname}, mem_int=#{mem_int}, mem_zipcode=#{mem_zipcode}, mem_address1=#{mem_address1}, mem_address2=#{mem_address2} WHERE mem_num=#{mem_num}")
	public void updateProfile(MemberVO member);	
	
	//비밀번호 수정 
	@Update("UPDATE member_detail SET mem_passwd=#{mem_passwd} WHERE mem_num=#{mem_num}")
	public void updatePassword(MemberVO member); 
	
	//구매 내역
	@Select("SELECT td.trade_num, item_photo1, item_name, s.item_size, td.trade_regdate, td.trade_state, " +
	        "item_brand, item_price " +
	        "FROM trade t " +
	        "JOIN trade_detail td ON t.trade_num = td.trade_num " +
	        "JOIN item ON td.item_num = item.item_num " +
	        "JOIN item_size s ON td.item_sizenum = s.item_sizenum " +
	        "WHERE t.buyer_num = #{mem_num}")
	public List<TradeVO> selectPurchasedItems(Integer mem_num);
	
	//판매 내역
	@Select("SELECT td.trade_num, i.item_photo1, i.item_name, s.item_size, td.trade_regdate, td.trade_state, " +
	        "i.item_brand, i.item_price " +
	        "FROM trade t " +
	        "JOIN item i ON t.item_num = i.item_num " +
	        "JOIN trade_detail td ON t.trade_num = td.trade_num " +
	        "JOIN item_size s ON td.item_sizenum = s.item_sizenum " +
	        "WHERE t.seller_num = #{mem_num}")
	public List<TradeVO> selectSoldItems(Integer mem_num);
	
	//관심 상품
	@Select("SELECT i.item_photo1, i.item_name, i.item_brand, i.item_price " +
	        "FROM item_fav f " +
	        "JOIN item i ON f.item_num = i.item_num " +
	        "WHERE f.mem_num = #{mem_num}")
	public List<ItemVO> selectFavoriteItems(Integer mem_num);
	
	//좋아요
	@Select("SELECT s.st_photo1, s.st_phrase, m.mem_photo, m.mem_nickname " +
	        "FROM style_fav sf " +
	        "JOIN member_detail m ON sf.mem_num = m.mem_num " +
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
