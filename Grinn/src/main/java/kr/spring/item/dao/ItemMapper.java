package kr.spring.item.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.item.vo.ItemVO;

@Mapper
public interface ItemMapper {
	
	//부모글
		public List<ItemVO> selectList(Map<String, Object> map);
		public int selectRowCount(Map<String,Object> map);
		
		public void insertItem(ItemVO item);
		@Select("SELECT * FROM item WHERE item_num=#{item_num}")
		public ItemVO selectItem(Integer item_num);
		public void updateItem(ItemVO item);
		public void deleteItem(Integer item_num);
		
		//관심상품
	
	//리뷰(댓글과 비슷하지 않을까?)
}
