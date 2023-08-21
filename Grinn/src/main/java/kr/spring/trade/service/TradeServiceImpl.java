package kr.spring.trade.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.item.vo.ItemVO;
import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.pbid.vo.PurchaseSizePriceVO;
import kr.spring.penalty.vo.PenaltyVO;
import kr.spring.sbid.vo.SaleBidVO;
import kr.spring.sbid.vo.SaleSizePriceVO;
import kr.spring.trade.dao.TradeMapper;
import kr.spring.trade.vo.TradeVO;

@Service
@Transactional
public class TradeServiceImpl implements TradeService{

	@Autowired
	TradeMapper tradeMapper;
	
	@Override
	public List<ItemSizeVO> selectGetItemSize(Integer item_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PurchaseBidVO> selectGetPurchaseBidByItem(Integer item_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SaleBidVO> selectGetSaleBidByItem(Integer item_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectMinSaleBid(Integer item_num,Integer item_sizenum) {
		return tradeMapper.selectMinSaleBid(item_num, item_sizenum);
	}

	@Override
	public int selectMaxPurchaseBid(Integer item_num,Integer item_sizenum) {
		return tradeMapper.selectMaxPurchaseBid(item_num, item_sizenum);
	}

	@Override
	public List<PurchaseSizePriceVO> selectPurchaseSizePrice(Integer item_num) {
		return tradeMapper.selectPurchaseSizePrice(item_num);
	}

	@Override
	public List<SaleSizePriceVO> selectSaleSizePrice(Integer item_num) {
		return tradeMapper.selectSaleSizePrice(item_num);
	}

	@Override
	public void insertPurchaseBid(PurchaseBidVO purchaseBidVO) {
		tradeMapper.insertPurchaseBid(purchaseBidVO);
	}

	@Override
	public void insertSaleBid(SaleBidVO saleBidVO) {
		tradeMapper.insertSaleBid(saleBidVO);
		
	}

	@Override
	public void deletePurchaseBid(Integer purchase_num) {
		tradeMapper.deletePurchaseBid(purchase_num);
	}

	@Override
	public void deleteSaleBid(Integer sale_num) {
		tradeMapper.deleteSaleBid(sale_num);
	}

	@Override
	public int selectGetPurchaseBidByItemAndSize(Integer item_num, Integer item_sizenum) {
		return tradeMapper.selectGetPurchaseBidByItemAndSize(item_num, item_sizenum);
	}

	@Override
	public int selectGetSaleBidByItemAndSize(Integer item_num, Integer item_sizenum) {
		return tradeMapper.selectGetSaleBidByItemAndSize(item_num, item_sizenum);
	}

	@Override
	public PurchaseBidVO selectPurchaseBidByUserNum(Integer mem_num,Integer item_num) {
		return tradeMapper.selectPurchaseBidByUserNum(mem_num,item_num);
	}

	@Override
	public SaleBidVO selectSaleBidByUserNum(Integer mem_num,Integer item_num) {
		return tradeMapper.selectSaleBidByUserNum(mem_num,item_num);
	}

	@Override
	public int selectSellerNum(Integer item_num, Integer item_sizenum, Integer sale_price) {
		return tradeMapper.selectSellerNum(item_num, item_sizenum, sale_price);
	}

	@Override
	public int selectBuyerNum(Integer item_num, Integer item_sizenum, Integer purchase_price) {
		return tradeMapper.selectBuyerNum(item_num, item_sizenum, purchase_price);
	}

	@Override
	public int selectTradeNum() {
		return tradeMapper.selectTradeNum();
	}

	@Override
	public void insertTrade(TradeVO trade) {
		tradeMapper.insertTrade(trade);
		tradeMapper.insertTradeDetail(trade);
		
	}

	@Override
	public int selectPurchaseBidNumber(Integer mem_num, Integer item_num, Integer purchase_price) {
		return tradeMapper.selectPurchaseBidNumber(mem_num, item_num, purchase_price);
	}

	@Override
	public int selectSaleBidNumber(Integer mem_num, Integer item_num, Integer sale_price) {
		return tradeMapper.selectSaleBidNumber(mem_num, item_num, sale_price);
	}

	@Override
	public List<TradeVO> selectTradePurchaseInfo(Map<String,Object> map) {
		return tradeMapper.selectTradePurchaseInfo(map);
	}
	
	@Override
	public List<TradeVO> selectTradeSaleInfo(Map<String,Object> map) {
		return tradeMapper.selectTradeSaleInfo(map);
	}

	@Override
	public List<PurchaseBidVO> selectPurchaseBidInfo(Map<String, Object> map) {
		return tradeMapper.selectPurchaseBidInfo(map);
	}

	@Override
	public List<SaleBidVO> selectSaleBidInfo(Map<String, Object> map) {
		return tradeMapper.selectSaleBidInfo(map);
	}

	@Override
	public int selectTradePurchaseCount(Integer mem_num) {
		return tradeMapper.selectTradePurchaseCount(mem_num);
	}
	
	@Override
	public int selectTradeSaleCount(Integer mem_num) {
		return tradeMapper.selectTradeSaleCount(mem_num);
	}

	@Override
	public int selectPurchaseBidCount(Integer mem_num) {
		return tradeMapper.selectPurchaseBidCount(mem_num);
	}

	@Override
	public int selectSaleBidCount(Integer mem_num) {
		return tradeMapper.selectSaleBidCount(mem_num);
	}

	@Override
	public int selectTradePurchaseQuitCount(Integer mem_num) {
		return tradeMapper.selectTradePurchaseQuitCount(mem_num);
	}

	@Override
	public int selectTradeSaleQuitCount(Integer mem_num) {
		return tradeMapper.selectTradeSaleQuitCount(mem_num);
	}

	@Override
	public void updateTradeStateToSend(Integer trade_num) {
		tradeMapper.updateTradeStateToSend(trade_num);
	}

	@Override
	public List<TradeVO> getTradeList(Map<String, Object> map) {
		return tradeMapper.getTradeList(map);
	}

	@Override
	public int getTradeListCount(Integer status) {
		return tradeMapper.getTradeListCount(status);
	}

	@Override
	public void updateTradeState(Integer trade_num, Integer trade_state) {
		tradeMapper.updateTradeState(trade_num, trade_state);
	}

	@Override
	public TradeVO getTradeDetail(Integer trade_num) {
		return tradeMapper.getTradeDetail(trade_num);
	}

	@Override
	public int adminGetPoint(Integer mem_num) {
		return tradeMapper.adminGetPoint(mem_num);
	}

	@Override
	public void executePayment(Integer total) {
		tradeMapper.executePayment(total);
	}

	@Override
	public void spendPoint(Integer mem_num, Integer total) {
		tradeMapper.spendPoint(mem_num, total);
	}

	@Override
	public void sendPointToSeller(Integer mem_num, Integer total) {
		tradeMapper.sendPointToSeller(mem_num, total);
	}

	@Override
	public TradeVO getTradeDetailForDeposit(Integer trade_num) {
		return tradeMapper.getTradeDetailForDeposit(trade_num);
	}

	@Override
	public void adminWithdraw(Integer total, Integer mem_num) {
		tradeMapper.adminWithdraw(total, mem_num);
	}

	@Override
	public PurchaseBidVO selectPurchaseBidForDirectBuy(Integer mem_num, Integer item_num, Integer item_sizenum) {
		return tradeMapper.selectPurchaseBidForDirectBuy(mem_num, item_num, item_sizenum);
	}

	@Override
	public SaleBidVO selectSaleBidForDirectSell(Integer mem_num, Integer item_num, Integer item_sizenum) {
		return tradeMapper.selectSaleBidForDirectSell(mem_num, item_num, item_sizenum);
	}

	@Override
	public void sendPointToBuyer(Integer mem_num, Integer total) {
		tradeMapper.sendPointToBuyer(mem_num, total);
	}

	@Override
	public void cancelExecutePayment(Integer total) {
		tradeMapper.cancelExecutePayment(total);
	}

	@Override
	public PurchaseBidVO selectPurchaseBidByPurchaseNum(Integer purchase_num) {
		return tradeMapper.selectPurchaseBidByPurchaseNum(purchase_num);
	}

	@Override
	public SaleBidVO selectSaleBidBySaleNum(Integer sale_num) {
		return tradeMapper.selectSaleBidBySaleNum(sale_num);
	}

	@Override
	public void adminInsertPenalty(PenaltyVO penalty) {
		tradeMapper.adminInsertPenalty(penalty);
	}

	@Override
	public List<ItemVO> mainGetItemList() {
		return tradeMapper.mainGetItemList();
	}

	@Override
	public List<ItemVO> mainGetItemListForRecommend(Integer item_gender) {
		return tradeMapper.mainGetItemListForRecommend(item_gender);
	}

	

}
