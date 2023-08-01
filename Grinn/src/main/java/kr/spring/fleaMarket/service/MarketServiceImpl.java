package kr.spring.fleaMarket.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.fleaMarket.dao.MarketMapper;
import kr.spring.fleaMarket.vo.MarketVO;

@Service
@Transactional
public class MarketServiceImpl implements MarketService{
	
	@Autowired
	MarketMapper marketMapper;

	@Override
	public List<MarketVO> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insertMarket(MarketVO market) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MarketVO selectMarket(Integer market_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateMarket(MarketVO market) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMarket(Integer market_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void updateMarketByAdmin(MarketVO marketVO) {
		// TODO Auto-generated method stub
		
	}
}
