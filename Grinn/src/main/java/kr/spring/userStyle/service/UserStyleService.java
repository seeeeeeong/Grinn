package kr.spring.userStyle.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleFavVO;
import kr.spring.style.vo.StyleVO;

public interface UserStyleService {
	 	
	//회원의 아이디, 프로필 사진, 닉네임, 프로필 이름, 한 줄 소개글 가져오기
	public MemberVO selectMember(Integer mem_num);
    
	//사용자가 작성한 스타일 게시물 총 개수 가져오기
    public int selectUserStyleCount(Integer mem_num);
    
    //사용자가 작성한 스타일게시물 사진, 내용 가져오기
    public List<StyleVO> selectStyle(Integer mem_num);
    
    //st_num에 해당하는 style 테이블의 정보 가져오기
    public StyleVO selectUserStyle(Integer st_num);
    
    //스타일 테이블의 mem_num에 해당하는 member_detail 테이블의 정보 가져오기
    public MemberVO selectStyleProfile(Integer mem_num);
    
	//좋아요
	public StyleFavVO selectFav(StyleFavVO fav);
	public int selectFavCount(Integer st_num);
	public void insertFav(StyleFavVO fav);
	public void deleteFav(Integer stfav_num);
	public void deleteFavByStNum(Integer st_num);
    
    //팔로우 
    public void insertFollow(Integer to_user, Integer from_user);

    //팔로우 취소
    public void deleteFollow(Integer to_user, Integer from_user);

    //팔로잉 여부 확인
    public boolean isFollowing(Integer to_user, Integer from_user);

    //팔로워 목록 조회
    public MemberVO selectFollower(Integer mem_num);
    
    //팔로잉 목록 조회
    public MemberVO selectFollowing(Integer mem_num);
    
    //팔로워 수 조회
    public int getFollowerCount(Integer to_user);

    //팔로잉 수 조회
    public int getFollowingCount(Integer to_user);
}
