package kr.spring.userStyle.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleFavVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.userStyle.dao.UserStyleMapper;

@Service
@Transactional
public class UserStyleServiceImpl implements UserStyleService{
	
	@Autowired
	private UserStyleMapper userStyleMapper;

	@Override
	public MemberVO selectMember(Integer mem_num) {
		return userStyleMapper.selectMember(mem_num);
	}
	
	@Override
	public int selectUserStyleCount(Integer mem_num) {
		return userStyleMapper.selectUserStyleCount(mem_num);
	}

	@Override
	public List<StyleVO> selectStyle(Integer mem_num) {
		return userStyleMapper.selectStyle(mem_num);
	}

	@Override
	public StyleVO selectUserStyle(Integer st_num) {
		return userStyleMapper.selectUserStyle(st_num);
	}

	@Override
	public void insertFollow(Integer toUser, Integer fromUser) {
		userStyleMapper.insertFollow(toUser, fromUser);		
	}

	@Override
	public void deleteFollow(Integer toUser, Integer fromUser) {
		userStyleMapper.deleteFollow(toUser, fromUser);		
	}

	@Override
	public int checkFollow(Integer toUser, Integer fromUser) {
		return userStyleMapper.checkFollow(toUser, fromUser);
	}

	@Override
	public List<Integer> getFollowers(Integer toUser) {
		return userStyleMapper.getFollowers(toUser);
	}

	@Override
	public List<Integer> getFollowings(Integer fromUser) {
		return userStyleMapper.getFollowings(fromUser);
	}

	@Override
	public int getFollowerCount(Integer toUser) {
		return userStyleMapper.getFollowerCount(toUser);
	}

	@Override
	public int getFollowingCount(Integer fromUser) {
		return userStyleMapper.getFollowerCount(fromUser);
	}

	@Override
	public MemberVO selectStyleProfile(Integer mem_num) {
		return userStyleMapper.selectStyleProfile(mem_num);
	}

	@Override
	public StyleFavVO selectFav(StyleFavVO fav) {
		return userStyleMapper.selectFav(fav);
	}

	@Override
	public int selectFavCount(Integer st_num) {
		return userStyleMapper.selectFavCount(st_num);
	}

	@Override
	public void insertFav(StyleFavVO fav) {
		userStyleMapper.insertFav(fav);
	}

	@Override
	public void deleteFav(Integer stfav_num) {
		userStyleMapper.deleteFav(stfav_num);
	}

	@Override
	public void deleteFavByStNum(Integer st_num) {
		userStyleMapper.deleteFavByStNum(st_num);
	}

}
