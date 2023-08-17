package kr.spring.trade.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.pbid.vo.PurchaseSizePriceVO;
import kr.spring.sbid.vo.SaleBidVO;
import kr.spring.sbid.vo.SaleSizePriceVO;
import kr.spring.trade.vo.TradeVO;

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
	@Select("SELECT COUNT(*) FROM purchase_bid WHERE item_num=#{item_num} AND item_sizenum=#{item_sizenum} AND purchase_deadline >= SYSDATE")
	public int selectGetPurchaseBidByItemAndSize(@Param(value="item_num") Integer item_num, @Param(value="item_sizenum") Integer item_sizenum);
	// 아이템 정보와 사이즈 정보로 등록되어 있는 판매 입찰 정보의 개수 가져오기 (입찰 정보가 등록되어 있는지 파악하기 위함)
	@Select("SELECT COUNT(*) FROM sale_bid WHERE item_num=#{item_num} AND item_sizenum=#{item_sizenum} AND sale_deadline >= SYSDATE")
	public int selectGetSaleBidByItemAndSize(@Param(value="item_num") Integer item_num, @Param(value="item_sizenum") Integer item_sizenum);
	// 즉시 구매를 위한 판매입찰 중 최소값
	@Select("SELECT MIN(sale_price) FROM sale_bid WHERE item_num=#{item_num} AND item_sizenum=#{item_sizenum} AND sale_deadline >= SYSDATE")
	public int selectMinSaleBid(@Param(value="item_num") Integer item_num, @Param(value="item_sizenum") Integer item_sizenum);
	// 즉시 판매를 위한 구매입찰 중 최대값
	@Select("SELECT MAX(purchase_price) FROM purchase_bid WHERE item_num=#{item_num} AND item_sizenum=#{item_sizenum} AND purchase_deadline >= SYSDATE")
	public int selectMaxPurchaseBid(@Param(value="item_num") Integer item_num, @Param(value="item_sizenum") Integer item_sizenum);
	// 아이템 정보와 사이즈 별 구매 입찰 정보 가져오기 ( 구매 입찰 가중 최대값 )
	public List<PurchaseSizePriceVO> selectPurchaseSizePrice(Integer item_num);
	// 아이템 정보와 사이즈 별 판매 입찰 정보 가져오기 ( 판매 입찰 가중 최소값 )
	public List<SaleSizePriceVO> selectSaleSizePrice(Integer item_num);
	// 사용자 번호로 구매 입찰 정보 조회
	@Select("SELECT * FROM purchase_bid WHERE mem_num=#{mem_num} AND item_num=#{item_num} AND purchase_deadline >= SYSDATE")
	public PurchaseBidVO selectPurchaseBidByUserNum(@Param(value="mem_num") Integer mem_num,@Param(value="item_num")Integer item_num);
	// 사용자 번호로 판매 입찰 정보 조회
	@Select("SELECT * FROM sale_bid WHERE mem_num=#{mem_num} AND item_num=#{item_num} AND sale_deadline >= SYSDATE")
	public SaleBidVO selectSaleBidByUserNum(@Param(value="mem_num") Integer mem_num,@Param(value="item_num")Integer item_num);
	// 즉시 구매시 등록된 입찰 정보를 삭제하기 위한 구매입찰 정보 조회
	@Select("SELECT * FROM purchase_bid WHERE mem_num=#{mem_num} AND item_num=#{item_num} AND item_sizenum=#{item_sizenum} AND purchase_deadline >= SYSDATE")
	public PurchaseBidVO selectPurchaseBidForDirectBuy(@Param(value="mem_num")Integer mem_num,@Param(value="item_num")Integer item_num,@Param(value="item_sizenum")Integer item_sizenum);
	// 즉시 판매시 등록된 입찰 정보를 확인하기 위한 판매입찰 정보 조회
	@Select("SELECT * FROM sale_bid WHERE mem_num=#{mem_num} AND item_num=#{item_num} AND item_sizenum=#{item_sizenum} AND sale_deadline >= SYSDATE")
	public SaleBidVO selectSaleBidForDirectSell(@Param(value="mem_num")Integer mem_num,@Param(value="item_num")Integer item_num,@Param(value="item_sizenum")Integer item_sizenum);
	
	// 즉시 구매를 위한 판매자 정보 조회
	@Select("SELECT mem_num FROM ("
			+ "SELECT mem_num FROM sale_bid "
			+ "WHERE item_num=#{item_num} AND item_sizenum=#{item_sizenum} AND sale_price=#{sale_price} AND sale_deadline >= SYSDATE"
			+ " ORDER BY sale_regDate ASC) WHERE ROWNUM <= 1")
	public int selectSellerNum(@Param(value="item_num") Integer item_num,@Param(value="item_sizenum") Integer item_sizenum,@Param(value="sale_price") Integer sale_price);
	// 즉시 판매를 위한 구매자 정보 조회
	@Select("SELECT mem_num FROM ("
			+ "SELECT mem_num FROM purchase_bid "
			+ "WHERE item_num=#{item_num} AND item_sizenum=#{item_sizenum} AND purchase_price=#{purchase_price} AND purchase_deadline >= SYSDATE"
			+ " ORDER BY purchase_regDate ASC) WHERE ROWNUM <= 1")
	public int selectBuyerNum(@Param(value="item_num") Integer item_num,@Param(value="item_sizenum") Integer item_sizenum, @Param(value="purchase_price") Integer purchase_price);
	// 구매 입찰 정보 등록
	@Insert("INSERT INTO purchase_bid (purchase_num,mem_num,item_num,item_sizenum,purchase_price,purchase_regDate,purchase_deadline,purchase_zipcode,purchase_address1,purchase_address2) "
			+ "VALUES (purchase_bid_seq.nextval,#{mem_num},#{item_num},#{item_sizenum},#{purchase_price},SYSDATE,#{purchase_deadline},#{purchase_zipcode},#{purchase_address1},#{purchase_address2})")
	public void insertPurchaseBid(PurchaseBidVO purchaseBidVO);
	// 판매 입찰 정보 등록 
	@Insert("INSERT INTO sale_bid (sale_num,mem_num,item_num,item_sizenum,sale_price,sale_regDate,sale_deadline,sale_zipcode,sale_address1,sale_address2) "
			+ "VALUES (sale_bid_seq.nextval,#{mem_num},#{item_num},#{item_sizenum},#{sale_price},SYSDATE,#{sale_deadline},#{sale_zipcode},#{sale_address1},#{sale_address2})")
	public void insertSaleBid(SaleBidVO saleBidVO);
	// 구매 입찰 번호 조회
	@Select("SELECT purchase_num FROM purchase_bid WHERE mem_num=#{mem_num} AND item_num=#{item_num} AND purchase_price=#{purchase_price}")
	public int selectPurchaseBidNumber(@Param(value="mem_num") Integer mem_num, @Param(value="item_num") Integer item_num, @Param(value="purchase_price") Integer purchase_price);
	// 판매 입찰 번호 조회
	@Select("SELECT sale_num FROM sale_bid WHERE mem_num=#{mem_num} AND item_num=#{item_num} AND sale_price=#{sale_price}")
	public int selectSaleBidNumber(@Param(value="mem_num") Integer mem_num, @Param(value="item_num") Integer item_num, @Param(value="sale_price") Integer sale_price);
	// 구매 입찰 정보 조회
	@Select("SELECT * FROM purchase_bid WHERE purchase_num=#{purchase_num}")
	public PurchaseBidVO selectPurchaseBidByPurchaseNum(Integer purchase_num);
	// 판매 입찰 정보 조회
	@Select("SELECT * FROM sale_bid WHERE sale_num=#{sale_num}")
	public SaleBidVO selectSaleBidBySaleNum(Integer sale_num);
	// 구매 입찰 정보 삭제
	@Delete("DELETE FROM purchase_bid WHERE purchase_num=#{purchase_num}")
	public void deletePurchaseBid(Integer purchase_num);
	// 판매 입찰 정보 삭제
	@Delete("DELETE FROM sale_bid WHERE sale_num=#{sale_num}")
	public void deleteSaleBid(Integer sale_num);
	
	/**
	 * ======================================================================================================================
	 * 												거래 관련 정보
	 * ======================================================================================================================
	 **/
	// 거래 정보 저장을 위한 거래 번호 생성
	@Select("SELECT trade_seq.nextval FROM dual")
	public int selectTradeNum();
	// 거래 정보 저장
	@Insert("INSERT INTO trade (trade_num,item_num,buyer_num,seller_num) VALUES (#{trade_num},#{item_num},#{buyer_num},#{seller_num})")
	public void insertTrade(TradeVO trade);
	@Insert("INSERT INTO trade_detail (trade_num,item_num,item_sizenum,trade_price,trade_rcvZipcode,trade_rcvAddress1,trade_rcvAddress2,trade_sendZipcode,trade_sendAddress1,trade_sendAddress2) "
			+ "VALUES (#{trade_num},#{item_num},#{item_sizenum},#{trade_price},#{trade_rcvZipcode},#{trade_rcvAddress1},#{trade_rcvAddress2},#{trade_sendZipcode},#{trade_sendAddress1},#{trade_sendAddress2})")
	public void insertTradeDetail(TradeVO trade);
	
	// 구매 입찰, 즉시 구매 버튼 클릭 시 관리자에게 포인트 전송
	@Update("UPDATE member_detail SET mem_point = NVL(mem_point,0) + #{total} WHERE mem_num=29")
	public void executePayment(Integer total);
	// 구매시 포인트 전송시 내 포인트 차감
	@Update("UPDATE member_detail SET mem_point = NVL(mem_point,0) - #{total} WHERE mem_num=#{mem_num}")
	public void spendPoint(@Param(value="mem_num")Integer mem_num, @Param(value="total")Integer total);
	// 거래 성공후 거래 상태가 배송중으로 변경되면 판매자에게 포인트 입금
	@Update("UPDATE member_detail SET mem_point = NVL(mem_point,0) + #{total} WHERE mem_num=#{mem_num}")
	public void sendPointToSeller(@Param(value="mem_num")Integer mem_num, @Param(value="total")Integer total);
	// 즉시 구매시 등록된 구매입찰이 존재할 경우 사용자 포인트 반환
	@Update("UPDATE member_detail SET mem_point = NVL(mem_point,0) + #{total} WHERE mem_num=#{mem_num}")
	public void sendPointToBuyer(@Param(value="mem_num")Integer mem_num, @Param(value="total")Integer total);
	// 즉시 구매시 등록된 구매입찰이 존재할 경우 관리자 포인트 차감
	@Update("UPDATE member_detail SET mem_point = NVL(mem_point,0) - #{total} WHERE mem_num=29")
	public void cancelExecutePayment(Integer total);
	/**
	 * ======================================================================================================================
	 * 												마이페이지 관련 정보
	 * ======================================================================================================================
	 **/
	// 마이페이지 거래 정보 조회
	public List<TradeVO> selectTradePurchaseInfo(Map<String,Object> map);
	public List<TradeVO> selectTradeSaleInfo(Map<String,Object> map);
	// 마이페이지 구매 거래 전체 정보 개수
	@Select("SELECT COUNT(*) FROM trade t JOIN trade_detail d ON t.trade_num=d.trade_num WHERE buyer_num=#{mem_num} AND d.trade_state<>5")
	public int selectTradePurchaseCount(Integer mem_num);
	@Select("SELECT COUNT(*) FROM trade t JOIN trade_detail d ON t.trade_num=d.trade_num WHERE t.buyer_num=#{mem_num} AND d.trade_state=5")
	public int selectTradePurchaseQuitCount(Integer mem_num);
	@Select("SELECT COUNT(*) FROM trade t JOIN trade_detail d ON t.trade_num=d.trade_num WHERE seller_num=#{mem_num} AND d.trade_state<>5")
	public int selectTradeSaleCount(Integer mem_num);
	@Select("SELECT COUNT(*) FROM trade t JOIN trade_detail d ON t.trade_num=d.trade_num WHERE t.seller_num=#{mem_num} AND d.trade_state=5")
	public int selectTradeSaleQuitCount(Integer mem_num);
	// 마이페이지 구매입찰 정보 조회
	public List<PurchaseBidVO> selectPurchaseBidInfo(Map<String, Object> map);
	// 마이페이지 구매입찰 전체 개수
	@Select("SELECT COUNT(*) FROM purchase_bid WHERE mem_num=#{mem_num}")
	public int selectPurchaseBidCount(Integer mem_num);
	// 마이페이지 판매입찰 정보 조회
	public List<SaleBidVO> selectSaleBidInfo(Map<String, Object> map);
	// 마이페이지 판매입찰 전체 개수
	@Select("SELECT COUNT(*) FROM sale_bid WHERE mem_num=#{mem_num}")
	public int selectSaleBidCount(Integer mem_num);
	// 마이페이지 판매 거래 상태 수정
	@Update("UPDATE trade_detail SET trade_state=3 WHERE trade_num=#{trade_num}")
	public void updateTradeStateToSend(Integer trade_num);
	
	/**
	 * ======================================================================================================================
	 * 												관리자 관련 정보
	 * ======================================================================================================================
	 **/
	// 거래 정보 개수
	@Select("SELECT COUNT(*) FROM trade t LEFT JOIN trade_detail d ON t.trade_num=d.trade_num")
	public int getTradeListCount();
	// 거래 정보 조회
	public List<TradeVO> getTradeList(Map<String, Object> map);
	// 거래 상세 정보 조회
	public TradeVO getTradeDetail(Integer trade_num);
	// 거래 상태 수정
	@Update("UPDATE trade_detail SET trade_state=#{trade_state} WHERE trade_num=#{trade_num}")
	public void updateTradeState(@Param(value="trade_num") Integer trade_num, @Param(value="trade_state") Integer trade_state);
	// 관리자 포인트 조회 (29)
	@Select("SELECT NVL(mem_point, 0) FROM member_detail WHERE mem_num=#{mem_num}")
	public int adminGetPoint(Integer mem_num);
	// 관리자 포인트 차감(29)
	@Update("UPDATE member_detail SET mem_point=mem_point-#{total} WHERE mem_num=#{mem_num}")
	public void adminWithdraw(@Param(value="total")Integer total, @Param(value="mem_num")Integer mem_num);
	// 판매자에게 거래가 입금을 위한 데이터 조회
	@Select("SELECT t.trade_num, t.item_num, t.seller_num, d.trade_price FROM trade t left join trade_detail d on t.trade_num=d.trade_num WHERE t.trade_num=#{trade_num}")
	public TradeVO getTradeDetailForDeposit(Integer trade_num);
}
