package kr.spring.user.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.trade.vo.TradeVO;

public interface UserService {
	//회원정보를 이용한 회원정보 구하기
	public MemberVO selectMember(Integer mem_num);	
		
	//회원탈퇴
	public void deleteMember(Integer mem_num);	
	
	//회원정보 수정 - 프로필 정보 (프로필 이미지, 이메일, 전화번호, 프로필 이름, 소개, 주소록)
	public void updateProfile(MemberVO member);	
	
	//비밀번호 수정 
	public void updatePassword(MemberVO member); 
	
	//구매 내역
	public List<TradeVO> selectPurchasedItems(Integer mem_num);
	
	//판매 내역
	public List<TradeVO> selectSoldItems(Integer mem_num);
	
	//관심 상품
	public List<ItemVO> selectFavoriteItems(Integer mem_num);
	
	//좋아요
	public List<MemberVO> selectLikedStyles(Integer mem_num);
	
    //패널티 통합 점수
    public Integer getPenaltyTotalScore(Integer mem_num);

    //게시판 페널티
    public List<MemberVO> getPenaltyBoard(Integer mem_num);

    //거래 페널티
    public List<MemberVO> getPenaltyTrade(Integer mem_num);	
}
