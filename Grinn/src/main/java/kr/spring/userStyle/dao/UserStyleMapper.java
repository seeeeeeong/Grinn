package kr.spring.userStyle.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;

public interface UserStyleMapper {
    //회원의 프로필 사진, 프로필 이름, 한 줄 소개글 가져오기
    @Select("SELECT mem_photo, mem_nickname, mem_int FROM member_detail WHERE mem_num = #{mem_num}")
    public MemberVO selectMember(Integer mem_num);
    
    //팔로우 기능
    
    //회원을 팔로우하는 사람들의 수 가져오기
    @Select("SELECT COUNT(*) FROM follow WHERE to_user = #{mem_num}")
    public int getFollowerCount(Integer mem_num);

    //회원이 팔로우하고 있는 사람들의 수 가져오기
    @Select("SELECT COUNT(*) FROM follow WHERE from_user = #{mem_num}")
    public int getFollowingCount(Integer mem_num);

    //회원이 팔로우하는 사람들의 목록 가져오기
    @Select("SELECT * FROM member WHERE mem_num IN (SELECT from_user FROM follow WHERE to_user = #{mem_num})")
    public List<MemberVO> getFollowingList(Integer mem_num);    
}
