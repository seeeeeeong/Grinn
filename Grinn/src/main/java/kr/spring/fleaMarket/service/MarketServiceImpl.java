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
		return marketMapper.selectList(map);
	}

	@Override
	public int selectCount(Map<String, Object> map) {
		return marketMapper.selectCount(map);
	}

	@Override
	public void insertMarket(MarketVO marketVO) {
		marketMapper.insertMarket(marketVO);
	}

	@Override
	public MarketVO selectMarket(Integer market_num) {
		return marketMapper.selectMarket(market_num);
	}

	@Override
	public void updateMarket(MarketVO market) {
		marketMapper.updateMarket(market);
	}

	@Override
	public void deleteMarket(Integer market_num) {
		marketMapper.deleteMarket(market_num);
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
