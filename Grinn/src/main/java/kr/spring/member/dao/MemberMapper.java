package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;

@Mapper
public interface MemberMapper {
	// 회원번호 생성
	@Select("SELECT member_seq.nextval FROM dual")
	public int selectMem_num();
	// 회원가입
	@Insert("INSERT INTO member (mem_num, mem_id, mem_nickname) VALUES (#{mem_num}, #{mem_id}, #{mem_nickname})")
	public void insertMember(MemberVO member);
	public void inserMember_detail(MemberVO member);
	// 회원아이디를 이용한 회원정보 체크
	public MemberVO selectCheckMember(String mem_id);
	// 회원번호를 이용한 회원정보 구하기
	public MemberVO selectMember(Integer mem_num);
	// 회원정보 수정
	public void updateMember(MemberVO member);
	public void updateMember_detail(MemberVO member);
	// 자동 로그인
	public void updateAu_id(String au_id, int mem_num);
	public MemberVO selectAu_id(String au_id);
	public void deleteAu_id(int mem_num);
	
	// 관리자 - 회원관리
	public int selectRowCount(Map<String, Object> map);
	public List<MemberVO> selectList(Map<String, Object> map);	
	public void updateByAdmin(MemberVO memberVO);
	
}
