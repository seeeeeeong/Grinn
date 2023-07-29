package kr.spring.trade.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.pbid.vo.PurchaseSizePriceVO;
import kr.spring.sbid.vo.SaleBidVO;
import kr.spring.sbid.vo.SaleSizePriceVO;

@Mapper
public interface TradeMapper {
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
	@Select("SELECT COUNT(*) FROM purchase_bid WHERE item_num=#{item_num} AND item_sizenum=#{item_sizenum}")
	public int selectGetPurchaseBidByItemAndSize(@Param(value="item_num") Integer item_num, @Param(value="item_sizenum") Integer item_sizenum);
	// 아이템 정보와 사이즈 정보로 등록되어 있는 판매 입찰 정보의 개수 가져오기 (입찰 정보가 등록되어 있는지 파악하기 위함)
	@Select("SELECT COUNT(*) FROM sale_bid WHERE item_num=#{item_num} AND item_sizenum=#{item_sizenum}")
	public int selectGetSaleBidByItemAndSize(@Param(value="item_num") Integer item_num, @Param(value="item_sizenum") Integer item_sizenum);
	// 즉시 구매를 위한 판매입찰 중 최소값
	@Select("SELECT MIN(sale_price) FROM sale_bid WHERE item_num=#{item_num} AND item_sizenum=#{item_sizenum}")
	public int selectMinSaleBid(@Param(value="item_num") Integer item_num, @Param(value="item_sizenum") Integer item_sizenum);
	// 즉시 판매를 위한 구매입찰 중 최대값
	@Select("SELECT MAX(purchase_price) FROM purchase_bid WHERE item_num=#{item_num} AND item_sizenum=#{item_sizenum}")
	public int selectMaxPurchaseBid(@Param(value="item_num") Integer item_num, @Param(value="item_sizenum") Integer item_sizenum);
	// 아이템 정보와 사이즈 별 구매 입찰 정보 가져오기 ( 구매 입찰 가중 최대값 )
	public List<PurchaseSizePriceVO> selectPurchaseSizePrice(Integer item_num);
	// 아이템 정보와 사이즈 별 판매 입찰 정보 가져오기 ( 판매 입찰 가중 최소값 )
	public List<SaleSizePriceVO> selectSaleSizePrice(Integer item_num);
	// 구매 입찰 정보 등록
	public void insertPurchaseBid(PurchaseBidVO purchaseBidVO);
	// 판매 입찰 정보 등록 
	public void insertSaleBid(SaleBidVO saleBidVO);
	// 구매 입찰 정보 삭제
	public void deletePurchaseBid(int purchase_num);
	// 판매 입찰 정보 삭제
	public void deleteSaleBid(int sale_num);
}
