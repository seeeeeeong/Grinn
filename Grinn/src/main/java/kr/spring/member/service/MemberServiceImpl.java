package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public void insertMember(MemberVO member) {
		member.setMem_num(memberMapper.selectMem_num());
		member.setMem_zipcode("");
		member.setMem_address1("");
		member.setMem_address2("");
		member.setMem_photo("");
		memberMapper.insertMember(member);
		memberMapper.insertMember_detail(member);
		
	}

	@Override
	public MemberVO selectCheckMember(String mem_id) {
		return memberMapper.selectCheckMember(mem_id);
	}

	@Override
	public MemberVO selectMember(Integer mem_num) {
		return memberMapper.selectMember(mem_num);
	}

	@Override
	public void updateAu_id(String au_id, int mem_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemberVO selectAu_id(String au_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteAu_id(int mem_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MemberVO> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateByAdmin(MemberVO memberVO) {
		// TODO Auto-generated method stub
		
	}

}
