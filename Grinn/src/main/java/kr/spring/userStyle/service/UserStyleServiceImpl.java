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
	public int getFollowerCount(Integer to_user) {
		return userStyleMapper.getFollowerCount(to_user);
	}

	@Override
	public int getFollowingCount(Integer to_user) {
		return userStyleMapper.getFollowingCount(to_user);
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

	@Override
	public void insertFollow(Integer to_user, Integer from_user) {
		if(!isFollowing(to_user, from_user)) {
		userStyleMapper.insertFollow(to_user, from_user);
		}
	}		

	@Override
	public void deleteFollow(Integer to_user, Integer from_user) {
		if(isFollowing(to_user, from_user)) {
		userStyleMapper.deleteFollow(to_user, from_user);
		}
	}		

	@Override
	public boolean isFollowing(Integer to_user, Integer from_user) {
		int count = userStyleMapper.isFollowing(to_user, from_user);
        return count > 0;
	}

	@Override
	public MemberVO selectFollower(Integer mem_num) {
		return userStyleMapper.selectFollower(mem_num);
	}

	@Override
	public MemberVO selectFollowing(Integer mem_num) {
		return userStyleMapper.selectFollowing(mem_num);
	}

}
