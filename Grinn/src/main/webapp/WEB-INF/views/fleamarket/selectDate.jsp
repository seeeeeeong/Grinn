<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 일자 선택 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/booking.js"></script>
<div class="page-main">
	<h2>예약 날짜 선택</h2>
	<div>
		<input type="text" id="picker">
	</div>
	<div>
		<form>
			<div class="align-right">
				<input type="submit" id="book_btn" value="예약하기">
			</div>
		</form>
	</div>
</div>
<!-- 일자 선택 끝-->