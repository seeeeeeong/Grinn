package kr.spring.trade.service;

import java.util.List;

import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.pbid.vo.PurchaseSizePriceVO;
import kr.spring.sbid.vo.SaleBidVO;
import kr.spring.sbid.vo.SaleSizePriceVO;

public interface TradeService {

	/**
	 * ======================================================================================================================
	 * 												입찰 관련 정보
	 * ======================================================================================================================
	 **/
	// 아이템 정보와 사이즈 정보 가져오기
	public List<ItemSizeVO> selectGetItemSize(Integer item_num);
	// 아이템 정보로 등록되어 있는 구매 입찰 정보 가져오기
	public List<PurchaseBidVO> selectGetPurchaseBidByItem(Integer item_num);
	// 아이템 정보로 등록되어 있는 판매 입찰 정보 가져오기
	public List<SaleBidVO> selectGetSaleBidByItem(Integer item_num);
	// 아이템 정보와 사이즈 정보로 등록되어 있는 구매 입찰 정보의 개수 가져오기 (입찰 정보가 등록되어 있는지 파악하기 위함)
	public int selectGetPurchaseBidByItemAndSize(Integer item_num, Integer item_sizenum);
	// 아이템 정보와 사이즈 정보로 등록되어 있는 판매 입찰 정보의 개수 가져오기 (입찰 정보가 등록되어 있는지 파악하기 위함)
	public int selectGetSaleBidByItemAndSize(Integer item_num, Integer item_sizenum);
	// 즉시 구매를 위한 판매입찰 중 최소값
	public int selectMinSaleBid(Integer item_num,Integer item_sizenum);
	// 즉시 판매를 위한 구매입찰 중 최대값
	public int selectMaxPurchaseBid(Integer item_num,Integer item_sizenum);
	// 아이템 정보와 사이즈 별 구매 입찰 정보 가져오기 ( 구매 입찰 가중 최대값 )
	public List<PurchaseSizePriceVO> selectPurchaseSizePrice(Integer item_num);
	// 아이템 정보와 사이즈 별 판매 입찰 정보 가져오기 ( 판매 입찰 가중 최소값 )
	public List<SaleSizePriceVO> selectSaleSizePrice(Integer item_num);
	// 구매 입찰 정보 등록
	public void insertPurchaseBid(PurchaseBidVO purchaseBidVO);
	// 판매 입찰 정보 등록 
	public void insertSaleBid(SaleBidVO saleBidVO);
	// 구매 입찰 정보 삭제
	public void deletePurchaseBid(Integer purchase_num);
	// 판매 입찰 정보 삭제
	public void deleteSaleBid(Integer sale_num);
	
}
