package kr.spring.fleaMarket.service;

import java.util.List;
import java.util.Map;

import kr.spring.fleaMarket.vo.BookingVO;

public interface BookingService {
	// 예약 등록
	public void insertBooking(BookingVO book);
	// 회원 번호별 예약 액수
	public int selectTotalByMem_num(Map<String, Object> map); 
	// 예약 목록
	public List<BookingVO> selectListBooking(Map<String, Object> map);
	// 예약 상세
	public BookingVO selectBooking(BookingVO book);
	// 예약 수정
	public void updateBooking(BookingVO book);
	// 예약 삭제
	public void deleteBooking(Integer book_num);
}