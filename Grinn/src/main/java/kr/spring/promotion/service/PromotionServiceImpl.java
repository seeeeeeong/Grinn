package kr.spring.promotion.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.promotion.vo.PromotionVO;

@Service
@Transactional
public class PromotionServiceImpl implements PromotionService{

	@Override
	public List<PromotionVO> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insertPromotion(PromotionVO promotion) {
		// TODO Auto-generated method stub
		
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
