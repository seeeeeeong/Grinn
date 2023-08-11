package kr.spring.item.service;

import java.util.List;
import java.util.Map;

import kr.spring.item.vo.ItemFavVO;
import kr.spring.item.vo.ItemReviewVO;
import kr.spring.item.vo.ItemVO;
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.sbid.vo.SaleBidVO;

public interface ItemService {
	
	//부모글
	public List<ItemVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertItem(ItemVO item);
	public ItemVO selectItem(Integer item_num);
	public Integer minSale(Integer item_num);
	public Integer maxPurchase(Integer item_num);
	public Integer latelyTrade(Integer item_num);
	public void updateItem(ItemVO item);
	public void deleteItem(Integer item_num);
	
	//==관심상품==
	public ItemFavVO selectFav(ItemFavVO fav);
	public int selectFavCount(Integer item_num);
	public void insertFav(ItemFavVO fav);
	public void deleteFav(Integer item_favNum);
	
	// 리뷰
	public List<ItemReviewVO> selectListReview(Map<String, Object> map);
	public int selectRowCountReview(Map<String, Object> map);
	public ItemReviewVO selectReview(Integer review_num);
	public void insertReview(ItemReviewVO itemReview);
	public void updateReview(ItemReviewVO itemReview);
	public void deleteReiew(Integer review_num);
}