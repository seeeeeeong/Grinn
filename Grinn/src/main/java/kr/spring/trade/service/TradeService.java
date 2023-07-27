package kr.spring.trade.service;

import java.util.List;

import kr.spring.itemsize.vo.ItemSizeVO;

public interface TradeService {

	// 아이템 정보와 사이즈 정보 가져오기
	public List<ItemSizeVO> selectGetItemSize(int item_num);
}
