package kr.spring.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.user.dao.UserMapper;
import kr.spring.item.vo.ItemVO;
import kr.spring.itemsize.vo.ItemSizeVO;
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
	public void updatePassword(MemberVO member) {
		userMapper.updatePassword(member);
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
	public List<TradeVO> selectPurchasedTrades(Integer mem_num) {
		return userMapper.selectPurchasedTrades(mem_num);
	}

	@Override
	public List<TradeVO> selectSoldTrades(Integer mem_num) {
		return userMapper.selectSoldTrades(mem_num);
	}

	@Override
	public List<ItemVO> selectPurchasedItems(Integer mem_num) {
		return userMapper.selectPurchasedItems(mem_num);
	}

	@Override
	public List<ItemVO> selectSoldItems(Integer mem_num) {
		return userMapper.selectSoldItems(mem_num);
	}

	@Override
	public List<ItemSizeVO> selectPurchasedItemSize(Integer mem_num) {
		return userMapper.selectPurchasedItemSize(mem_num);
	}

	@Override
	public List<ItemSizeVO> selectSoldItemSize(Integer mem_num) {
		return userMapper.selectSoldItemSize(mem_num);
	}
}