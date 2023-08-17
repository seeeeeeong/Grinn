package kr.spring.fleaMarket.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.fleaMarket.vo.BookingVO;

@Mapper
public interface BookingMapper {
	// 플리마켓 날짜 추출
	@Select("SELECT market_startDate, market_endDate FROM market WHERE market_num = #{market_num}")
	public int selectMarketDate(Integer market_num);
	// 예약 중복여부 확인
	@Select("SELECT COUNT(*) FROM booking WHERE mem_num = ${mem_num}")
	public int checkalreadyBooked(Integer book_num);
	// 예약 등록
	public void insertBooking(BookingVO bookingVO);
	// 회원 번호별 예약 액수
	public int selectTotalByMem_num(Map<String, Object> map); 
	// 사용자 - 예약 목록
	public int selectBookingCountByMem_num(Map<String, Object> map);
	public List<BookingVO> selectListBookingByMem_num(Map<String, Object> map);
	// 관리자 - 예약 목록
	public List<BookingVO> selectListBooking(Map<String, Object> map);
	public int selectCountBooking(Map<String, Object> map);
	// 관리자/이용자 - 예약 상세
	@Select("SELECT * FROM booking WHERE book_num = #{book_num}")
	public BookingVO selectBooking(Integer book_num);
	// 예약 완료로 인한 booth_count 변동
	@Update("UPDATE market SET booth_count=booth_count-#{get_count} WHERE market_num=#{market_num}")
	public void bookBooth_count(Integer market_num);
	// 예약 삭제
	@Delete("DELETE FROM booking WHERE book_num=#{book_num}")
	public void deleteBooking(Integer book_num);
	// 예약 삭제에 따른 booth_count 증가
	@Update("UPDATE market SET booth_count=booth_count+#{get_count} WHERE market_num=#{market_num}")
	public void rollbackBooth_count(Integer market_num);
}
