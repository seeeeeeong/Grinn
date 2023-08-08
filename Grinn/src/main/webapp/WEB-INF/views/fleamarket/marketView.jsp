<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 플리마켓 상세 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/market-detail.js"></script>
<div class="page-main">
	<h2>${market.market_title}</h2>
	<div>
		<img src="imageView.do?market_num=${market.market_num}&photo_type=1" width="300" height="400">
	</div>
	<div class="market-detail">
		<form id="market_cart" method="post">
			<input type="hidden" name="market_num" value="${market.market_num}" id="market_num">
			<input type="hidden" name="booth_fee" value="${market.booth_fee}" id="booth_fee">
			<input type="hidden" name="booth_count" value="${market.booth_count}" id="booth_count">
			<ul>
				<li>비용 : <b><fmt:formatNumber value="${market.booth_fee}"/></b></li>
				<li>잔여 부스 : <span><fmt:formatNumber value="${market.booth_count}"/></span></li>
				<c:if test="${market.booth_count > 0}">
				<li>
					<label for="book_quantity">예약 수량</label>
					<input type="number" name="book_quantity" min="1" max="1" id="book_quantity" class="quantity-width">
				</li>
				<li>
					<span id="book_total_txt">총 예약 금액: 0원</span>
				</li>
				<li>
					<input type="submit" value="예약하기" onclick="location.href='booking.do?market_num=${market.market_num}'">
				</li>
				</c:if>
				<c:if test="${market.booth_count <= 0}">
				<li class="align-center">
					<span class="sold-out">매진</span>
				</li>
				</c:if>
			</ul>
		</form>
	</div>
	<hr size="1" noshade="noshade" width="100%">
	<p>
		${market.market_detail}
	</p>
</div>
<!-- 플리마켓 상세 끝 -->