<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 프로모션 상세 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/promotion.css">
<div class="page-main">
	<c:if test="${promotion.pro_hide == 1}">
	<div class="result-display">
		<div class="align-center">
			페이지를 찾을 수 없습니다.
			<br>
			<input type="button" value="메인" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>
	</c:if>
	<c:if test="${promotion.pro_hide == 2}">
	<h2 class="pro-title">${promotion.pro_name}</h2>
	<div class="pro-detail">
		<form id="pro_form" method="post">
			<input type="hidden" name="pro_num" value="${promotion.pro_num}" id="pro_num">
			<ul>
				<li class="pro-period">${promotion.pro_openDate} ~ ${promotion.pro_cloDate}</li>
				<li class="pro-ing">
				<c:if test="${promotion.pro_ing == 1}">
				<span>예정 프로모션</span>
				</c:if>
				<c:if test="${promotion.pro_ing == 2}">
				<span>진행 프로모션</span>
				</c:if>
				<c:if test="${promotion.pro_ing == 3}">
				<span>종료된 프로모션</span>
				</c:if>
				</li>
			</ul>
		</form>
	</div>
	<p>
		${promotion.pro_content}
	</p>
	</c:if>
</div>
<!-- 프로모션 상세 끝 -->