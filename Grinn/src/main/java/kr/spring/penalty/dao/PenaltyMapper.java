package kr.spring.penalty.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.penalty.vo.PenaltyVO;

@Mapper
public interface PenaltyMapper {
	// 페이지 목록
	public List<PenaltyVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	// 페널티 부여
	public void insertPenalty(PenaltyVO penaltyVO);
	// 페널티 조회 - 관리자
	//@Select("SELECT * FROM penalty WHERE pe_num=#{pe_num}")
	public PenaltyVO selectPenalty(Integer pe_num);
	// 회원 번호별 합산된 페널티 - 이용자
	public int selectPenaltyByMem_num(Map<String, Object> map);
	// 페널티 수정 - 관리자
	@Update("UPDATE penalty SET pe_service_type=#{pe_service_type}, pe_score=#{pe_score}, pe_type=#{pe_type} WHERE pe_num=#{pe_num}")
	public void updatePenalty(PenaltyVO penaltyVO);
}
