package kr.spring.penalty.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import kr.spring.penalty.vo.PenaltyVO;

public interface PenaltyService {
	// 페이지 목록
	public List<PenaltyVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	// 페널티 부여
	public void insertPenalty(PenaltyVO penaltyVO);
	// 페널티 조회
	public PenaltyVO selectPenalty(Integer pe_num);
	// 회원 번호별 합산된 페널티
	public int selectPenaltyByMem_num(Map<String, Object> map);
	// 페널티 수정 
	public void updatePenalty(PenaltyVO penaltyVO);
	
	// 사용자 - 전체 목록 수
	public int selectPenaltyCountByMem_num(Map<String, Object> map);
	// 사용자 - 전체 목록
	public List<PenaltyVO> selectListPenaltyByMem_num(Map<String, Object> map);
}
