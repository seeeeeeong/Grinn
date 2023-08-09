package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;

@Mapper
public interface MemberMapper {
	// 회원번호 생성
	@Select("SELECT member_seq.nextval FROM dual")
	public int selectMem_num();
	// 회원가입
	@Insert("INSERT INTO member (mem_num, mem_id) VALUES (#{mem_num}, #{mem_id})")
	public void insertMember(MemberVO member);
	public void insertMember_detail(MemberVO member);
	// 회원아이디를 이용한 회원정보 체크
	public MemberVO selectCheckMember(String mem_id);
	// 회원번호를 이용한 회원정보 구하기
	@Select("SELECT * FROM member m JOIN member_detail d ON m.mem_num = d.mem_num WHERE m.mem_num=#{mem_num}")
	public MemberVO selectMember(Integer mem_num);
	// 자동 로그인
	@Update("UPDATE member_detail SET au_id=#{au_id} WHERE mem_num=#{mem_num}")
	public void updateAu_id(String au_id, int mem_num);
	@Select("SELECT m.mem_num, m.mem_id, m.mem_auth, d.au_id, d.mem_passwd, d.mem_email FROM member m JOIN member_detail d ON m.mem_num = d.mem_num WHERE d.au_id=#{au_id}")
	public MemberVO selectAu_id(String au_id);
	@Update("UPDATE member_detail SET au_id='' WHERE mem_num=#{mem_num}")
	public void deleteAu_id(int mem_num);
	
	// 관리자 - 회원관리
	public int selectRowCount(Map<String, Object> map);
	public List<MemberVO> selectList(Map<String, Object> map);	
	@Update("UPDATE SET member SET mem_auth=#{mem_auth} WHERE mem_num=#{mem_num}")
	public void updateByAdmin(MemberVO memberVO);

	//채팅 회원정보 검색 - 염유진
	@Select("SELECT mem_num,mem_id,mem_nickname FROM member WHERE mem_auth>= 2 AND mem_id LIKE '%' || #{mem_id} || '%'")
	public List<MemberVO> selectSearchMember(String id);
}