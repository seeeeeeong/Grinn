package kr.spring.trade.service;

import java.util.List;

import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.sbid.vo.SaleBidVO;

public interface TradeService {

	/**
	 * ======================================================================================================================
	 * 												입찰 관련 정보
	 * ======================================================================================================================
	 **/
	// 아이템 정보와 사이즈 정보 가져오기
	public List<ItemSizeVO> selectGetItemSize(int item_num);
	// 아이템 정보로 등록되어 있는 구매 입찰 정보 가져오기
	public List<PurchaseBidVO> selectGetPurchaseBidByItem(int item_num);
	// 아이템 정보로 등록되어 있는 판매 입찰 정보 가져오기
	public List<SaleBidVO> selectGetSaleBidByItem(int item_num);
	// 즉시 구매를 위한 판매입찰 
	// 구매 입찰 정보 등록
	public void insertPurchaseBid(PurchaseBidVO purchaseBidVO);
	// 판매 입찰 정보 등록 
	public void insertSaleBid(SaleBidVO saleBidVO);
	// 구매 입찰 정보 삭제
	public void deletePurchaseBid(int purchase_num);
	// 판매 입찰 정보 삭제
	public void deleteSaleBid(int sale_num);
	
}
