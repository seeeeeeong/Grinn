package kr.spring.trade.service;

import java.util.List;

import kr.spring.itemsize.vo.ItemSizeVO;
import kr.spring.pbid.vo.PurchaseBidVO;
import kr.spring.pbid.vo.PurchaseSizePriceVO;
import kr.spring.sbid.vo.SaleBidVO;
import kr.spring.sbid.vo.SaleSizePriceVO;

public class TradeServiceImpl implements TradeService{

	@Override
	public List<ItemSizeVO> selectGetItemSize(int item_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PurchaseBidVO> selectGetPurchaseBidByItem(int item_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SaleBidVO> selectGetSaleBidByItem(int item_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectMinPurchaseBid(int item_num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int selectMaxSaleBid(int item_num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<PurchaseSizePriceVO> selectPurchaseSizePrice(int item_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SaleSizePriceVO> selectSaleSizePrice(int item_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertPurchaseBid(PurchaseBidVO purchaseBidVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertSaleBid(SaleBidVO saleBidVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletePurchaseBid(int purchase_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteSaleBid(int sale_num) {
		// TODO Auto-generated method stub
		
	}

}
