package kr.spring.user.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.item.vo.ItemFavVO;
import kr.spring.item.vo.ItemVO;
import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.sbid.vo.SaleBidVO;
import kr.spring.style.vo.StyleFavVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.trade.vo.TradeVO;

public interface UserService {
	//회원정보를 이용한 회원정보 구하기
	public MemberVO selectMember(Integer mem_num);	

	//프로필 이미지 업데이트
	public void updateProfile(MemberVO member);	
	//이미지 삭제
	public void deleteProfile(Integer mem_num);
	//이미지 존재 여부 확인
	public boolean checkProfileImage(Integer mem_num);
	
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

	//구매입찰 count
	public int purchasedCount(Integer mem_num);
	
	//구매입찰 trade_state : 2,3,4,6
	public int ongoingCount(Integer mem_num);
	
	//구매입찰 trade_state : 5
	public int  completedCount(Integer mem_num);
	
	//구매입찰 사진, 아이템 이름
	public List<ItemVO> purchasedItems(Integer mem_num);
	
	//구매날짜
	public List<Date> purchasedDate(Integer mem_num);
	
	//구매상태(거래 상태)
	public List<Integer> purchasedState(Integer mem_num);	
	
	//판매입찰 count
	public int saledCount(Integer mem_num);
	
	//판매입찰 trade_state : 2,3,4,6
	public int saledOngoingCount(Integer mem_num);
	
	//판매입찰 trade_state : 5
	public int  saledCompletedCount(Integer mem_num);
	
	//판매 상품
	public List<ItemVO> saledItems(Integer mem_num);
	
	//판매날짜
	public List<Date> saledDate(Integer mem_num);
	
	//판매상태(거래 상태)	
	public List<Integer> saledState(Integer mem_num);
	
    //item_num에 해당하는 item 테이블의 정보 가져오기
    public ItemVO selectItem(Integer item_num);
    	
	//관심 상품
	public List<ItemVO> selectFavoriteItems(Integer mem_num);
	
	//관심상품 전체 개수
	public int selectFavoriteItemsCount(Integer mem_num);
	
	//좋아요한 게시물 정보 가져오기
	public List<StyleVO> selectLikedStyles(Integer mem_num);
	
	//좋아요한 게시물의 st_num에 해당하는 style 테이블의 정보 가져오기
	public StyleVO selectStyle(Integer st_num);	
	
	//좋아요한 게시물 작성자의 프로필 사진
	public MemberVO selectProfile(Integer st_num);
	
	//좋아요한 게시물 작성자의 아이디
	public String selectProfileId(Integer st_num);
	
	//좋아요 기능
	public StyleFavVO selectFav(StyleFavVO fav);
	
	//좋아요 개수
	public int selectFavCount(Integer st_num);
	
	//좋아요
	public void insertFav(StyleFavVO fav);
		
	//좋아요 취소
	public void deleteFav(Integer stfav_num);
	public void deleteFavByStNum(Integer st_num);
	
    //패널티 통합 점수
    public Integer getPenaltyTotalScore(Integer mem_num);

    //게시판 페널티
    public List<MemberVO> getPenaltyBoard(Integer mem_num);

    //거래 페널티
    public List<MemberVO> getPenaltyTrade(Integer mem_num);
    
}
