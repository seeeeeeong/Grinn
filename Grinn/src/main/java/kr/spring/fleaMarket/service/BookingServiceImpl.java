package kr.spring.fleaMarket.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.fleaMarket.dao.BookingMapper;
import kr.spring.fleaMarket.dao.MarketMapper;
import kr.spring.fleaMarket.vo.BookingVO;

@Service
@Transactional
public class BookingServiceImpl implements BookingService{
	@Autowired
	private BookingMapper bookingMapper;
	
	@Autowired
	private MarketMapper marketMapper;
	
	@Override
	public void insertBooking(BookingVO bookingVO) {
		bookingMapper.insertBooking(bookingVO);
		bookingMapper.bookBooth_count(bookingVO.getMarket_num());
	}

	@Override
	public int selectTotalByMem_num(Map<String, Object> map) {
		return bookingMapper.selectTotalByMem_num(map);
	}

	@Override
	public List<BookingVO> selectListBooking(Map<String, Object> map) {
		return bookingMapper.selectListBooking(map);
	}

	@Override
	public BookingVO selectBooking(Integer book_num) {
		return bookingMapper.selectBooking(book_num);
	}

	@Override
	public void deleteBooking(Integer book_num) {
		bookingMapper.deleteBooking(book_num);
		bookingMapper.rollbackBooth_count(book_num);
	}

	@Override
	public int selectCountBooking(Map<String, Object> map) {
		return bookingMapper.selectCountBooking(map);
	}

	@Override
	public void bookBooth_count(Integer market_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int selectMarketDate(Integer market_num) {
		return bookingMapper.selectMarketDate(market_num);
	}

	@Override
	public int selectBookingCountByMem_num(Map<String, Object> map) {
		return bookingMapper.selectBookingCountByMem_num(map);
	}

	@Override
	public List<BookingVO> selectListBookingByMem_num(Map<String, Object> map) {
		return bookingMapper.selectListBookingByMem_num(map);
	}

}
