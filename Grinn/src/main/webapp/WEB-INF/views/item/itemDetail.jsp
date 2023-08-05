<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/itemWrite.js"></script>
<!-- 게시글 상세 시작 -->
<div class="page-main">
	<c:if test="${item.item_status == 1}">
		<div class="result-display">
			<div class="align-center">
				본 상품은 판매 중지되었습니다.
				<input type="button" value="판매상품보기" onclick="location.href='itemList.do'">
			</div>
		</div>
	</c:if>
	<c:if test="${item.item_status == 2}">
	<div class="itemDetailPage">
		<!-- 사진 -->
		<div class="left">
			<img
				src="${pageContext.request.contextPath}/item/viewProfile.do?item_num=${item.item_num}"
				width="100%" height="400">
		</div>
		<div class="divider"></div>
		<div class="right">
			<!-- 브랜드, 이름, 설명, 사이즈, 최근 거래가, 구매/판매버튼, 관심상품 -->
			<div class="itemInfo">
				<div class="title_box">
					<p class="a">${item.item_brand}</p>
					<p class="b">${item.item_name}</p>
					<p class="c">${item.item_detail}</p>
				</div>
				<div class="details">
					<div>사이즈</div>
				</div>
				<div class="details">
					<div>최근 거래가</div>
				</div>
				<div>
					<div class="buttons">
						<button class="a" onclick="location.href='${pageContext.request.contextPath}/purchase/selectSize.do?item_num=${item.item_num}'">구매</button>
						<button class="b" onclick="location.href='${pageContext.request.contextPath}/sale/selectSize.do?item_num=${item.item_num}'">판매</button>
					</div><br> 
					<span class="output_fav" data-num="${item.item_num}" id="output-fav"> 
						<span>
						<img class="output_fav" data-num="${item.item_num}" 
							src="${pageContext.request.contextPath}/images/save_blank.png" width="15" height="15"> 
						<span>관심상품</span> 
						<span class="output_fcount" data-num="${item.item_num}"></span>
						</span>
					</span>
				</div>
			</div>
			<div>
				<h3>상품정보</h3>
				<div class="detail_wrap">
					<dl>
						<div class="detail_wrap_one">
							<dt>모델번호</dt>
							<dd>${item.item_model}</dd>
						</div>
						<div class="detail_wrap_two">
							<dt>출시일</dt>
							<dd>${item.item_date}</dd>
						</div>
						<div class="detail_wrap_two">
							<dt>발매가</dt>
							<dd><fmt:formatNumber>${item.item_price}</fmt:formatNumber>원</dd>
						</div>
						
					</dl>
				</div>
			</div>
		</div>
		</div>
	</c:if>
</div>