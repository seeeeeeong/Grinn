package kr.spring.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.user.dao.UserMapper;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.trade.vo.TradeVO;

@Service
@Transactional
public class UserServiceImpl implements UserService{

	@Autowired
	private UserMapper userMapper;

	@Override
	public MemberVO selectMember(Integer mem_num) {
		return userMapper.selectMember(mem_num);
	}
	
	@Override
	public void deleteMember(Integer mem_num) {
		userMapper.deleteMember(mem_num);
		userMapper.deleteMember_detail(mem_num);
	}
	
	@Override
	public void updateProfile(MemberVO member) {
		userMapper.updateProfile(member);
	}

	@Override
	public void updatePassword(MemberVO member) {
		userMapper.updatePassword(member);
	}

	@Override
	public List<TradeVO> selectPurchasedItems(Integer mem_num) {
		return userMapper.selectPurchasedItems(mem_num);
	}
	
	@Override
	public List<TradeVO> selectSoldItems(Integer mem_num) {
		return userMapper.selectSoldItems(mem_num);
	}
	
	@Override
	public List<ItemVO> selectFavoriteItems(Integer mem_num) {
		return userMapper.selectFavoriteItems(mem_num);
	}
	
	@Override
	public List<MemberVO> selectLikedStyles(Integer mem_num) {
		return userMapper.selectLikedStyles(mem_num);
	}

	@Override
	public Integer getPenaltyTotalScore(Integer mem_num) {
		return userMapper.getPenaltyTotalScore(mem_num);
	}

	@Override
	public List<MemberVO> getPenaltyBoard(Integer mem_num) {
		return userMapper.getPenaltyBoard(mem_num);
	}

	@Override
	public List<MemberVO> getPenaltyTrade(Integer mem_num) {
		return userMapper.getPenaltyTrade(mem_num);
	}	
}