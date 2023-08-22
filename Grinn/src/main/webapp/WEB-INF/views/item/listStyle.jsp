<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/itemStFav.js"></script>

<div class="page-main">
	<div class="styleListOn">
		<img src="${pageContext.request.contextPath}/item/viewProfile.do?item_num=${item.item_num}">
		<p>${item.item_name}</p>
		<c:if test="${item.sale == 0}">
		<span>판매 입찰이 없습니다</span>
	</c:if>
		<c:if test="${item.sale != 0}">
			<span><b><fmt:formatNumber value="${item.sale}" />원</b></span>
	</c:if>
	</div>
	<c:if test="${count==0}">
		<div class="result-display">
			<div class="align-center">
				게시된 Style이 없습니다.<br><br>
				<input type="button" value="상품페이지로 돌아가기" onclick="location.href='itemDetail.do?item_num=${item.item_num}'">
			</div>
		</div>
	</c:if>
	<c:if test="${count>0}">
	<div class="stoutput2">
	<c:forEach var="list" items="${list}">
		<div class="stylelist01">
			<a href="${pageContext.request.contextPath}/style/detail.do?st_num=${list.st_num}">
				<img src="${pageContext.request.contextPath}/style/viewPhoto1.do?st_num=${list.st_num}" class="stylept">
				<ul class="detail-style">
					<li>
						<img src="${pageContext.request.contextPath}/member/viewProfile.do?mem_num=${list.mem_num}" width="25" height="25" class="my-photo">
					</li>
					<li>${list.mem_id}</li>
				</ul>
				<div class="sub-style">
					<c:if test="${!empty list.st_phrase}">
						<p>${list.st_phrase}</p>
					</c:if>
				</div>
			</a>
			<div class="like-button">
				<img class="output_fav" data-num="${list.st_num}" src="${pageContext.request.contextPath}/images/no_like.png">
				<span class="output_fcount" data-num="${list.st_num}"></span>
			</div>
		</div>
	</c:forEach>
	</div>
	</c:if>
</div>