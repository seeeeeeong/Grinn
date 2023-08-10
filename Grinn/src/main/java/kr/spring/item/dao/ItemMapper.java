package kr.spring.item.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.item.vo.ItemFavVO;
import kr.spring.item.vo.ItemReviewVO;
import kr.spring.item.vo.ItemVO;

@Mapper
public interface ItemMapper {
	
	//부모글
	public List<ItemVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//글작성
	public void insertItem(ItemVO item);
	//글상세
	@Select("SELECT * FROM item WHERE item_num=#{item_num}")
	public ItemVO selectItem(Integer item_num);
	public void updateItem(ItemVO item);
	@Delete("DELETE FROM item WHERE item_num=#{item_num}")
	public void deleteItem(Integer item_num);
	
	//==관심상품==
	@Select("SELECT * FROM item_fav WHERE item_num=#{item_num} AND mem_num=#{mem_num}")
	public ItemFavVO selectFav(ItemFavVO fav);
	@Select("SELECT COUNT(*) FROM item_fav WHERE item_num=#{item_num}")
	public int selectFavCount(Integer item_num);
	@Insert("INSERT INTO item_fav(item_favnum, item_num,mem_num) VALUES (itemfav_seq.nextval,#{item_num},#{mem_num})")
	public void insertFav(ItemFavVO fav);
	@Delete("DELETE FROM item_fav WHERE item_favnum=#{item_favnum}")
	public void deleteFav(Integer item_favNum);
	@Delete("DELETE FROM item_fav WHERE item_num=${item_num}")
	public void deleteFavByItemNum(Integer item_num);
	
	//리뷰
	public List<ItemReviewVO> selectListReview(Map<String, Object> map);
	@Select("SELECT COUNT(*) FROM review JOIN member USING(mem_num) WHERE item_num=#{item_num}")
	public int selectRowCountReview(Map<String,Object> map);
	@Select("SELECT * FROM review WHERE review_num=#{review_num}")
	public ItemReviewVO selectReview(Integer review_num);
	public void insertReview(ItemReviewVO itemReview);
	public void updateReview(ItemReviewVO itemReview);
	@Delete("DELETE FROM review WHERE review_num=#{review_num}")
	public void deleteReiew(Integer review_num);
	//부모글 삭제시 댓글이 존재하면 부모글 삭제전 댓글 삭제
	public void deleteReviewByItemNum(Integer review_num);
}