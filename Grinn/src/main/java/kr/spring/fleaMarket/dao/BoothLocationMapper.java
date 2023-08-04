package kr.spring.fleaMarket.dao;

import kr.spring.fleaMarket.vo.BoothLocationVO;

public interface BoothLocationMapper {
	public void insertBooth(BoothLocationVO boothLocationVO);
	public BoothLocationVO selectBooth(Integer location_num);
	public void updateBooth(BoothLocationVO boothLocationVO);
	public void deleteBooth(Integer location_num);
}