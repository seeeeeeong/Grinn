package kr.spring.item.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.item.dao.ItemMapper;
import kr.spring.item.vo.ItemFavVO;
import kr.spring.item.vo.ItemReviewVO;
import kr.spring.item.vo.ItemVO;

@Service
@Transactional
public class ItemServiceImpl implements ItemService{

	
	@Autowired
	private ItemMapper itemMapper;
	
	@Override
	public List<ItemVO> selectList(Map<String, Object> map) {
		return itemMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return itemMapper.selectRowCount(map);
	}

	@Override
	public void insertItem(ItemVO item) {
		itemMapper.insertItem(item);
	}

	@Override
	public ItemVO selectItem(Integer item_num) {
		return itemMapper.selectItem(item_num);
	}

	@Override
	public void updateItem(ItemVO item) {
		itemMapper.updateItem(item);
	}

	@Override
	public void deleteItem(Integer item_num) {
		itemMapper.deleteItem(item_num);
	}

	//==관심상품(좋아요)==
	@Override
	public ItemFavVO selectFav(ItemFavVO fav) {
		return itemMapper.selectFav(fav);
	}

	@Override
	public int selectFavCount(Integer item_num) {
		return itemMapper.selectFavCount(item_num);
	}

	@Override
	public void insertFav(ItemFavVO fav) {
		itemMapper.insertFav(fav);
	}

	@Override
	public void deleteFav(Integer item_favNum) {
		itemMapper.deleteFav(item_favNum);
	}

	@Override
	public List<ItemReviewVO> selectListReview(Map<String, Object> map) {
		return itemMapper.selectListReview(map);
	}

	@Override
	public int selectRowCountReview(Map<String, Object> map) {
		return itemMapper.selectRowCountReview(map);
	}

	@Override
	public ItemReviewVO selectReview(Integer review_num) {
		return itemMapper.selectReview(review_num);
	}

	@Override
	public void insertReview(ItemReviewVO itemReview) {
		itemMapper.insertReview(itemReview);
	}

	@Override
	public void updateReview(ItemReviewVO itemReview) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReiew(Integer review_num) {
		// TODO Auto-generated method stub
		
	}

}
