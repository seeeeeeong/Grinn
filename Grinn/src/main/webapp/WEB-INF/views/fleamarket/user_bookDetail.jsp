<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 이용자 예약 내역 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/market.css">
<div class="page-main">
	<h2 class="detail-border">예약 내역</h2>
	<form:form modelAttribute="bookingVO" action="bookDetail.do" id="book_detail">
		<form:hidden path="book_num"/>
		<ul>
			<li class="detail-poster">
			<img src="${pageContext.request.contextPath}/fleamarket/imageView.do?market_num=${bookingVO.marketVO.market_num}&photo_type=1"
			width="250" height="300">
			</li>
			<li class="detail-market">
				<label><b>플리마켓명</b></label>
				${bookingVO.marketVO.market_title}
			</li>
			<li class="detail-market">
				<label><b>개최 기간</b></label>
				${bookingVO.marketVO.market_startDate} ~ ${bookingVO.marketVO.market_endDate}
			</li>
			<li class="detail-market">
				<label><b>장소</b></label>
				${bookingVO.marketVO.place_name}
			</li>
			<li>
				<label>예약 번호</label>
				${bookingVO.book_num}
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
				<label>예약일</label>
				${bookingVO.book_regDate}
			</li>
			<li>
				<label>예약 비용</label>
				<fmt:formatNumber>${bookingVO.marketVO.booth_fee}</fmt:formatNumber>
			</li>
			<li>
				<label>수령 방법</label>
				<span>현장수령</span>
			</li>
		</ul>	
		<div class="align-right">
			<form:button>예약 취소</form:button>
			<input type="button" value="예약 목록"
			 onclick="location.href='${pageContext.request.contextPath}/fleamarket/marketList.do'">
		</div>             
	</form:form>
</div>
<!-- 이용자 예약 내역 끝 -->