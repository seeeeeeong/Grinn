package kr.spring.trade.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.pbid.vo.PurchaseSizePriceVO;
import kr.spring.sbid.vo.SaleBidVO;
import kr.spring.sbid.vo.SaleSizePriceVO;
import kr.spring.trade.vo.TradeVO;

public interface TradeService {

	/**
	 * ======================================================================================================================
	 * 입찰 관련 정보
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
	public int selectMinSaleBid(Integer item_num, Integer item_sizenum);

	// 즉시 판매를 위한 구매입찰 중 최대값
	public int selectMaxPurchaseBid(Integer item_num, Integer item_sizenum);

	// 아이템 정보와 사이즈 별 구매 입찰 정보 가져오기 ( 구매 입찰 가중 최대값 )
	public List<PurchaseSizePriceVO> selectPurchaseSizePrice(Integer item_num);

	// 아이템 정보와 사이즈 별 판매 입찰 정보 가져오기 ( 판매 입찰 가중 최소값 )
	public List<SaleSizePriceVO> selectSaleSizePrice(Integer item_num);

	// 사용자 번호로 구매 입찰 정보 조회
	public PurchaseBidVO selectPurchaseBidByUserNum(Integer mem_num, Integer item_num);

	// 사용자 번호로 판매 입찰 정보 조회
	public SaleBidVO selectSaleBidByUserNum(Integer mem_num, Integer item_num);

	// 즉시 구매를 위한 판매자 정보 조회
	public int selectSellerNum(Integer item_num, Integer item_sizenum, Integer sale_price);

	// 즉시 판매를 위한 구매자 정보 조회
	public int selectBuyerNum(Integer item_num, Integer item_sizenum, Integer purchase_price);

	// 구매 입찰 정보 등록
	public void insertPurchaseBid(PurchaseBidVO purchaseBidVO);

	// 판매 입찰 정보 등록
	public void insertSaleBid(SaleBidVO saleBidVO);
	
	// 구매 입찰 번호 조회
	public int selectPurchaseBidNumber(Integer mem_num, Integer item_num, Integer purchase_price);
		
	// 판매 입찰 번호 조회
	public int selectSaleBidNumber(Integer mem_num, Integer item_num, Integer sale_price);
		
	// 구매 입찰 정보 삭제
	public void deletePurchaseBid(Integer purchase_num);

	// 판매 입찰 정보 삭제
	public void deleteSaleBid(Integer sale_num);

	// 거래 정보 저장을 위한 거래 번호 생성
	public int selectTradeNum();

	// 거래 정보 저장
	public void insertTrade(TradeVO trade);
	
	// 마이페이지 거래 정보 조회
	public List<TradeVO> selectTradePurchaseInfo(Map<String,Object> map);
	public List<TradeVO> selectTradeSaleInfo(Map<String,Object> map);
	
	// 마이페이지 거래 전체 정보 개수
	public int selectTradePurchaseCount(Integer mem_num);
	public int selectTradePurchaseQuitCount(Integer mem_num);
	public int selectTradeSaleCount(Integer mem_num);
	public int selectTradeSaleQuitCount(Integer mem_num);
	
	// 마이페이지 구매입찰 정보 조회
	public List<PurchaseBidVO> selectPurchaseBidInfo(Map<String, Object> map);
	
	// 마이페이지 구매입찰 전체 개수
	public int selectPurchaseBidCount(Integer mem_num);
	
	// 마이페이지 판매입찰 정보 조회
	public List<SaleBidVO> selectSaleBidInfo(Map<String, Object> map);

	// 마이페이지 판매입찰 전체 개수
	public int selectSaleBidCount(Integer mem_num);	
	
	// 마이페이지 판매 거래 상태 수정
	public void updateTradeStateToSend(Integer trade_num);
	
	// 거래 정보 개수
	public int getTradeListCount();
	
	// 거래 정보 조회
	public List<TradeVO> getTradeList(Map<String, Object> map);
	
	// 거래 상세 정보 조회
	public TradeVO getTradeDetail(Integer trade_num);

	// 거래 상태 수정
	public void updateTradeState(Integer trade_num, Integer trade_state);
}
