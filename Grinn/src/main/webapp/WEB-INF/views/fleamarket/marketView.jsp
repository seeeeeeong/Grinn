<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 플리마켓 상세 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/market.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/market-detail.js"></script>
<div class="page-main">
	<h2 class="flea-info">플리마켓 상세</h2>
	<div class="market-image">
		<img src="imageView.do?market_num=${market.market_num}&photo_type=1" width="350" height="430">
	</div>
	<div class="market-detail">
		<form id="market_cart" method="post">
			<input type="hidden" name="market_num" value="${market.market_num}" id="market_num">
			<input type="hidden" name="booth_fee" value="${market.booth_fee}" id="booth_fee">
			<input type="hidden" name="booth_count" value="${market.booth_count}" id="booth_count">
			<ul>
				<li class="flea-title">${market.market_title}</li>
				<li class="flea-date align-right">${market.market_startDate} ~ ${market.market_endDate}</li>
				<li class="flea-detail">
					<p>영업 일정</p>
					<p class="flea-detail-comment1">오전 10시 ~ 오후 8시</p>
				</li>
				<li class="flea-detail">
					<p>플리마켓 입장 마감</p>
					<p class="flea-detail-comment2">종료 30분 전까지</p>	
				</li>
				<li class="flea-detail">
					<p>참가 비용</p>
					<p class="flea-detail-comment3">하단 내용 참조</p>
				</li>
				<c:if test="${market.booth_count > 0}">
				<li class="flea-book page_clear align-right">
					<input type="button" class="flea-book-btn" value="예약하기" onclick="location.href='booking.do?market_num=${market.market_num}'">
				</li>
				</c:if>
				<c:if test="${market.booth_count <= 0}">
				<li class="align-right">
					<span class="sold-out">매진</span>
				</li>
				</c:if>
			</ul>
		</form>
	</div>
	<div class="market-section">
	<h2 class="flea-info">상세정보</h2>
	</div>
	<hr size="1" noshade="noshade" width="100%">
	<p>
		${market.market_detail}
	</p>
</div>
<!-- 플리마켓 상세 끝 -->