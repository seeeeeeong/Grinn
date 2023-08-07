package kr.spring.user.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.item.vo.ItemVO;
import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.trade.vo.TradeVO;

public interface UserService {
	//회원정보를 이용한 회원정보 구하기
	public MemberVO selectMember(Integer mem_num);	

	//프로필 이미지 업데이트
	public void updateProfile(MemberVO member);	
	
	//회원탈퇴
	public void deleteMember(Integer mem_num);

	//이메일 변경
	public void updateEmail(MemberVO member);

	//전화번호 변경
	public void updatePhoneNumber(MemberVO member);

	//배송지 추가
	public void addShippingAddress(MemberVO member);

	//배송지 변경
	public void updateShippingAddress(MemberVO member);

	//배송지 삭제
	public void deleteShippingAddress(int mem_num);

	//닉네임 추가
	public void addNickname(MemberVO member);

	//닉네임 변경
	public void updateNickname(MemberVO member); 
	
	//소개글 추가
	public void addIntroduction(MemberVO member);

	//소개글 변경
	public void updateInt(MemberVO member);
	
	//비밀번호 변경
	public void updatePassword(MemberVO member); 
	
	//구매내역 - trade
	public List<TradeVO> selectPurchasedTrades(Integer mem_num);
	
	//구매내역 - Item
	public List<ItemVO> selectPurchasedItems(Integer mem_num);
	
	//구매 내역 - Size
	public List<ItemSizeVO> selectPurchasedItemSize(Integer mem_num);
	
	//판매 내역 - Trade
	public List<TradeVO> selectSoldTrades(Integer mem_num);

	//판매 내역 - Item
	public List<ItemVO> selectSoldItems(Integer mem_num);
	
	//판매 내역 - Size
	public List<ItemSizeVO> selectSoldItemSize(Integer mem_num);
	   
    //item_num에 해당하는 item 테이블의 정보 가져오기
    public ItemVO selectItem(Integer item_num);
    	
	//관심 상품
	public List<ItemVO> selectFavoriteItems(Integer mem_num);
	
	//좋아요한 게시물 정보 가져오기
	public List<StyleVO> selectLikedStyles(Integer mem_num);
	
	//좋아요한 게시물의 st_num에 해당하는 style 테이블의 정보 가져오기
	public StyleVO selectStyle(Integer st_num);	
	
	//좋아요한 게시물의 작성자 ID 가져오기
	public List<String> selectStyleId(Integer mem_num);
	
    //패널티 통합 점수
    public Integer getPenaltyTotalScore(Integer mem_num);

    //게시판 페널티
    public List<MemberVO> getPenaltyBoard(Integer mem_num);

    //거래 페널티
    public List<MemberVO> getPenaltyTrade(Integer mem_num);
    
}
