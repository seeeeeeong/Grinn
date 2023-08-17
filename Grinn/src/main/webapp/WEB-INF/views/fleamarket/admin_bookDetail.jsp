<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 관리자 예약 내역 시작 -->
<div class="page-main">
	<h2>예약 내역 - 관리자</h2>
	<form:form modelAttribute="bookingVO" action="detailBooking.do" id="book_detail">
		<form:hidden path="book_num"/>
		<ul>
			<li>
				<label>예약 번호</label>
				${bookingVO.book_num}
			</li>
			<li>
				<label>플리마켓명</label>
				${marketVO.market_title}
			</li>
			<li>
				<label>희망 시작일</label>
				${bookingVO.book_date1}
			</li>
			<li>
				<label>희망 종료일</label>
				${bookingVO.book_date2}
			</li>
			<li>
				<label>예약자 ID</label>
				${memberVO.mem_id}
			</li>
			<li>
				<label>장소</label>
				${market_VO.place_name}
			</li>
			<li>
				<label>예약일</label>
				${bookingVO.book_regDate}
			</li>
			<li>
				<label>예약 비용</label>
				${marketVO.booth_fee}
			</li>
			<li>
				<label>수령 방법</label>
				<span>현장수령</span>
			</li>
		</ul>	
		<div class="align-center">
			<form:button class="default-btn">주문 수정</form:button>
			<input type="button" value="예약 목록" class="default-btn"
			 onclick="location.href='${pageContext.request.contextPath}/fleamarket/admin_resList.do'">
		</div>             
	</form:form>
</div>
<!-- 관리자 예약 내역 끝 -->