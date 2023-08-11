<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 일자 선택 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/market.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/booking.js"></script>
<div class="page-main">
	<h2>예약 할인 선택</h2>
	<form id="select_date" action="completeDate.do" method="post">
		<input type="hidden" name="market_num" value="${market.market_num}" id="market_num"/>
		<input type="hidden" name="market_startDate" value="${market.market_startDate}" id="market_startDate"/>
		<input type="hidden" name="market_endDate" value="${market.market_endDate}" id="market_endDate"/>
		<input type="hidden" name="booth_count" value="${market.booth_count}" id="booth_count"/>
		<input type="hidden" name="booth_fee" value="${market.booth_fee}" id="booth_fee"/>
		<ul class="date-form">
			<li>예약 플리마켓 ${market.market_title}</li>
			<li>운영 일정 ${market.market_startDate} ~ ${market.market_endDate}</li>
			<li>선택한 일정 ${market.book_date1} ~ ${market_book_date2}</li>
			<li>예약한 수 ${market.get_count}</li>
			<li>
				<label for="booth_fee">플리마켓 비용</label>
				<c:if test="${market.booth_fee == 0}"><span>무료</span></c:if>
				<c:if test="${market.booth_fee > 0}">
				<fmt:formatNumber value="${market.booth_fee}"/>원
				</c:if>
			</li>
			<li>
				<span id="booth_total_txt">총 예약 금액  0원</span>
			</li>
		</ul>
		<div class="align-right">
			<input type="button" value="이전으로" onclick="location.href='selectDate.do'">
			<input type="submit" id="book_btn" value="예약하기">
		</div>
	</form>
</div>
