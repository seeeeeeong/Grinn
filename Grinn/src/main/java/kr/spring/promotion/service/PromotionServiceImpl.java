package kr.spring.promotion.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.promotion.dao.PromotionMapper;
import kr.spring.promotion.vo.PromotionVO;

@Service
@Transactional
public class PromotionServiceImpl implements PromotionService{
	@Autowired
	private PromotionMapper promotionMapper;
		
	@Override
	public List<PromotionVO> selectList(Map<String, Object> map) {
		return promotionMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return promotionMapper.selectRowCount(map);
	}

	@Override
	public void insertPromotion(PromotionVO promotionVO) {
		promotionMapper.insertPromotion(promotionVO);
	}

	@Override
	public PromotionVO selectPromotion(Integer pro_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updatePromotion(PromotionVO promotion) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletePromotion(Integer pro_num) {
		// TODO Auto-generated method stub
		
	}

}
