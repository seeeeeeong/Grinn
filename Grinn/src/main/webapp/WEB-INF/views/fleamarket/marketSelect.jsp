<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 내용 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/market.css">
<div class="page-main">
	<div class="selectMarket-wrap">
		<div class="user-wrap">
			<div class="market-img">
				<a href="${pageContext.request.contextPath}/fleamarket/boothList.do"><img src="../image_bundle/stalls.jpg"></a>
			</div>
			<p>
				<span class="market-font">
				<b>플리마켓 부스 예약</b>
				</span>
			</p>
		</div>
		<div class="user-wrap">
			<div class="market-img">
				<a href="${pageContext.request.contextPath}/fleamarket/marketList.do"><img src="../image_bundle/bazaars.jpg"></a>
			</div>
			<p>
				<span class="market-font">
				<b>예약 내역 조회</b>
				</span>
			</p>
		</div>		
	</div>
</div>
<!-- 내용 끝 -->