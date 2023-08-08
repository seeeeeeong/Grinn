package kr.spring.promotion.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.promotion.vo.PromotionVO;

@Mapper
public interface PromotionMapper {
	public List<PromotionVO> selectList(Map<String, Object>map);
	public int selectRowCount(Map<String, Object> map);
	public void insertPromotion(PromotionVO promotion);
	public PromotionVO selectPromotion(Integer pro_num);
	public void updatePromotion(PromotionVO promotion);
	public void deletePromotion(Integer pro_num);
}
