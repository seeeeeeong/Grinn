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
<style>
/*input 롤오버 시 커서 표시*/
.hasDatepicker{cursor: pointer;}
</style>

<div class="page-main">
	<h2>예약 날짜 선택</h2>
	<div>
	</div>
	<form id="select_date" action="completeDate.do" method="post">
		<input type="hidden" name="market_num" value="${market.market_num}" id="market_num"/>
		<input type="hidden" name="market_startDate" value="${market.market_startDate}" id="market_startDate"/>
		<input type="hidden" name="market_endDate" value="${market.market_endDate}" id="market_endDate"/>
		<input type="hidden" name="booth_count" value="${market.booth_count}" id="booth_count"/>
		<ul class="date-form">
			<li>예약 플리마켓: ${market.market_title}</li>
			<li>운영 일정: ${market.market_startDate} ~ ${market.market_endDate}</li>
			<li class="choose-date">
				<label for="from-to">예약 일정</label>
				<input type="text" id="from-to" autocomplete="off"> ~ <input type="text" id="from-to2" autocomplete="off">
			</li>
			<li>
				<label for="get_count">예약 부스 수</label>
				<input type="number" name="get_count" min="0" max="1" id="get_count">
			</li>
			<li>
				<span>총 예약 수량 : 0개</span>
			</li>
			<li>
				<label>남은 부스 수</label>
				/ ${market.booth_count}
			</li>
			<li>
				<label for="booth_fee">플리마켓 비용</label>
				<c:if test="${market.booth_fee == 0}"><span>무료</span></c:if>
				<c:if test="${market.booth_fee > 0}">
				<%-- <fmt:formatNumber value="${market.booth_fee}" id="booth_fee"/>원--%>
				</c:if>
			</li>
			<li>
				<span id="booth_total_txt">총 예약 금액 : 0원</span>
			</li>
		</ul>
		<div class="align-right">
			<input type="button" value="목록" onclick="location.href='boothList.do'">
			<input type="submit" id="book_btn" value="예약하기">
		</div>
	</form>
</div>
