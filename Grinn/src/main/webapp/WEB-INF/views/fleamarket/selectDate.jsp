<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 일자 선택 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/booking.js"></script>
<style>
/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
.ui-datepicker-trigger{cursor: pointer;}
/*datepicer input 롤오버 시 손가락 모양 표시*/
.hasDatepicker{cursor: pointer;}
</style>

<div class="page-main">
	<h2>예약 날짜 선택</h2>
<%-- <input type="text" id="datepicker"> --%>
	<form id="select_date" method="post">
		<input type="hidden" name="market_startDate" value="${market.market_startDate}" id="market_startDate"/>
		<input type="hidden" name="market_endDate" value="${market.market_endDate}" id="market_endDate"/>
		<input type="hidden" name="booth_count" value="${market.booth_count}" id="booth_count"/>
		<ul>
			<li>
				<input type="text" id="datepicker">
			</li>
			<li>
				<label for="book_count">예약 부스 수</label>
				<input type="number" name="book_count" min="1" max="1" id="book_count">
			</li>
			<li>
				<span>총 예약 수량 : 1개</span>
			</li>

			<li>
				<c:if test="${market.booth_fee == 0}"><span>무료</span></c:if>
				<c:if test="${market.booth_fee > 0}">
				<fmt:formatNumber value="${market.booth_fee}"/>원
				</c:if>
			</li>
			<li>
				<span id="booth_total_txt">총 예약 금액 : 0원</span>
			</li>
		</ul>
		<div class="align-right">
			<input type="submit" id="book_btn" value="예약하기">
		</div>
	</form>
</div>
