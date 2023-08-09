package kr.spring.promotion.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.promotion.vo.PromotionVO;

@Mapper
public interface PromotionMapper {
	public List<PromotionVO> selectList(Map<String, Object>map);
	public int selectRowCount(Map<String, Object> map);
	public void insertPromotion(PromotionVO promotion);
	@Select("SELECT * FROM promotion WHERE pro_num = #{pro_num}")
	public PromotionVO selectPromotion(Integer pro_num);
	public void updatePromotion(PromotionVO promotion);
	@Delete("DELETE FROM promotion WHERE pro_num = #{pro_num}")
	public void deletePromotion(Integer pro_num);
}
