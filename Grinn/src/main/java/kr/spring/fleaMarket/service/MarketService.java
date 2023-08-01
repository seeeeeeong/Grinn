package kr.spring.fleaMarket.service;

import java.util.List;
import java.util.Map;

import kr.spring.fleaMarket.vo.MarketVO;

public interface MarketService {
	// 목록 리스트
	public List<MarketVO> selectList(Map<String, Object> map);
	public int selectCount(Map<String, Object> map);
	// 플리마켓 등록
	public void insertMarket(MarketVO market);
	// 플리마켓 조회
	public MarketVO selectMarket(Integer market_num);
	// 플리마켓 수정
	public void updateMarket(MarketVO market);
	// 플리마켓 삭제
	public void deleteMarket(Integer market_num);
	
	// 플리마켓 관리 - 관리자
	public int selectRowCount(Map<String, Object> map);
	public void updateMarketByAdmin(MarketVO marketVO);
}
