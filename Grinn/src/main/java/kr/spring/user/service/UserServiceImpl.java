package kr.spring.user.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.user.dao.UserMapper;
import kr.spring.item.vo.ItemFavVO;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleFavVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.trade.vo.TradeVO;

@Service
@Transactional
public class UserServiceImpl implements UserService {

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
	public void updatePassword(MemberVO member) {
		userMapper.updatePassword(member);
	}

	@Override
	public List<ItemVO> selectFavoriteItems(Integer mem_num) {
		return userMapper.selectFavoriteItems(mem_num);
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

	@Override
	public void updateEmail(MemberVO member) {
		userMapper.updateEmail(member);
	}

	@Override
	public void updatePhoneNumber(MemberVO member) {
		userMapper.updatePhoneNumber(member);
	}

	@Override
	public void addShippingAddress(MemberVO member) {
		userMapper.addShippingAddress(member);
	}

	@Override
	public void updateShippingAddress(MemberVO member) {
		userMapper.updateShippingAddress(member);
	}

	@Override
	public void deleteShippingAddress(int mem_num) {
		userMapper.deleteShippingAddress(mem_num);
	}

	@Override
	public void addNickname(MemberVO member) {
		userMapper.addNickname(member);
	}

	@Override
	public void updateNickname(MemberVO member) {
		userMapper.updateNickname(member);
	}

	@Override
	public void addIntroduction(MemberVO member) {
		userMapper.addIntroduction(member);
	}

	@Override
	public void updateInt(MemberVO member) {
		userMapper.updateInt(member);
	}

	@Override
	public void updateProfile(MemberVO member) {
		userMapper.updateProfile(member);
	}

	@Override
	public ItemVO selectItem(Integer item_num) {
		return userMapper.selectItem(item_num);
	}

	@Override
	public List<StyleVO> selectLikedStyles(Integer mem_num) {
		return userMapper.selectLikedStyles(mem_num);
	}

	@Override
	public StyleVO selectStyle(Integer st_num) {
		return userMapper.selectStyle(st_num);
	}

	@Override
	public int purchasedCount(Integer mem_num) {
		return userMapper.purchasedCount(mem_num);
	}

	@Override
	public int ongoingCount(Integer mem_num) {
		return userMapper.ongoingCount(mem_num);
	}

	@Override
	public int completedCount(Integer mem_num) {
		return userMapper.completedCount(mem_num);
	}

	@Override
	public List<ItemVO> purchasedItems(Integer mem_num) {
		return userMapper.purchasedItems(mem_num);
	}

	@Override
	public List<Date> purchasedDate(Integer mem_num) {
		return userMapper.purchasedDate(mem_num);
	}

	@Override
	public List<Integer> purchasedState(Integer mem_num) {
		return userMapper.purchasedState(mem_num);
	}

	@Override
	public int saledCount(Integer mem_num) {
		return userMapper.saledCount(mem_num);
	}

	@Override
	public int saledOngoingCount(Integer mem_num) {
		return userMapper.saledOngoingCount(mem_num);
	}

	@Override
	public int saledCompletedCount(Integer mem_num) {
		return userMapper.saledCompletedCount(mem_num);
	}

	@Override
	public List<ItemVO> saledItems(Integer mem_num) {
		return userMapper.saledItems(mem_num);
	}

	@Override
	public List<Date> saledDate(Integer mem_num) {
		return userMapper.saledDate(mem_num);
	}

	@Override
	public List<Integer> saledState(Integer mem_num) {
		return userMapper.saledState(mem_num);
	}

	@Override
	public int selectFavoriteItemsCount(Integer mem_num) {
		return userMapper.selectFavoriteItemsCount(mem_num);
	}

	@Override
	public MemberVO selectProfile(Integer st_num) {
		return userMapper.selectProfile(st_num);
	}

	@Override
	public String selectProfileId(Integer st_num) {
		return userMapper.selectProfileId(st_num);
	}

	@Override
	public StyleFavVO selectFav(StyleFavVO fav) {
		return userMapper.selectFav(fav);
	}

	@Override
	public void insertFav(StyleFavVO fav) {
		userMapper.insertFav(fav);
	}

	@Override
	public void deleteFav(Integer stfav_num) {
		userMapper.deleteFav(stfav_num);
	}

	@Override
	public void deleteFavByStNum(Integer st_num) {
		userMapper.deleteFavByStNum(st_num);
	}

	@Override
	public int selectFavCount(Integer st_num) {
		return userMapper.selectFavCount(st_num);
	}

	@Override
	public void deleteProfile(Integer mem_num) {
		userMapper.deleteProfile(mem_num);
	}

}