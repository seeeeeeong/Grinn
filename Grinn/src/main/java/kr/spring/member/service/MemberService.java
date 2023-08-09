package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	// 회원가입
	public void insertMember(MemberVO member);
	// 회원아이디를 이용한 회원정보 체크
	public MemberVO selectCheckMember(String mem_id);
	// 회원번호를 이용한 회원정보 구하기
	public MemberVO selectMember(Integer mem_num);
	// 자동 로그인
	public void updateAu_id(String au_id, int mem_num);
	public MemberVO selectAu_id(String au_id);
	public void deleteAu_id(int mem_num);
	
	// 관리자 - 회원관리
	public int selectRowCount(Map<String, Object> map);
	public List<MemberVO> selectList(Map<String, Object> map);	
	public void updateByAdmin(MemberVO memberVO);
	
	//채팅 회원정보 검색 - 염유진
	public List<MemberVO> selectSearchMember(String id);
}
