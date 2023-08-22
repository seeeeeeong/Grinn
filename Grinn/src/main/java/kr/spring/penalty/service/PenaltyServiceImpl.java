package kr.spring.penalty.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.penalty.dao.PenaltyMapper;
import kr.spring.penalty.vo.PenaltyVO;

@Service
@Transactional
public class PenaltyServiceImpl implements PenaltyService{
	@Autowired
	private PenaltyMapper penaltyMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public List<PenaltyVO> selectList(Map<String, Object> map) {
		return penaltyMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return penaltyMapper.selectRowCount(map);
	}

	@Override
	public void insertPenalty(PenaltyVO penaltyVO) {
		penaltyMapper.insertPenalty(penaltyVO);
		memberMapper.selectMember(penaltyVO.getMem_num());
	}

	@Override
	public PenaltyVO selectPenalty(Integer pe_num) {
		return penaltyMapper.selectPenalty(pe_num);
	}

	@Override
	public int selectPenaltyByMem_num(Map<String, Object> map) {
		return penaltyMapper.selectPenaltyByMem_num(map);
	}

	@Override
	public void updatePenalty(PenaltyVO penaltyVO) {
		penaltyMapper.updatePenalty(penaltyVO);
	}

	@Override
	public int selectPenaltyCountByMem_num(Map<String, Object> map) {
		return penaltyMapper.selectPenaltyCountByMem_num(map);
	}

	@Override
	public List<PenaltyVO> selectListPenaltyByMem_num(Map<String, Object> map) {
		return penaltyMapper.selectListPenaltyByMem_num(map);
	}

}
