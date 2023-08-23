package kr.spring.alert.service;

import java.util.List;

import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleVO;

public interface AlertService {
	
	// 스타일 테이블의 정보 구하기
	public List<StyleVO> selectStyleInfo(Integer mem_num);
	
	// 스타일 게시물 좋아요 한 회원의 id,mem_num
	public List<MemberVO> favId(Integer st_num);
	
	// 스타일 게시물 댓글 작성자 id, mem_num
	public List<MemberVO> commentId(Integer st_num);
	
	// 스타일 게시물 댓글 내용
	public List<String> comment(Integer st_num);
	
	// 프로필 이미지
	public MemberVO profilePhoto(Integer mem_num);	

	// 팔로우 한 회원 id, mem_num
	public List<MemberVO> followId(Integer mem_num);
	
	// 팔로우 한 회원 프로필 이미지
	public MemberVO followPhoto(Integer mem_num);
}
