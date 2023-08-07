<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2>
	<a class = "logo" href = "${pageContext.request.contextPath}/main/main.do">Grinn</a>
</h2>
<div class="align-right">
	<a href="${pageContext.request.contextPath}/notice/noticeList.do">고객센터</a>

	<c:if test="${!empty user && user.mem_auth == 2}">
		<a href="${pageContext.request.contextPath}/user/myPage.do">MY페이지</a>
		<a href="${pageContext.request.contextPath}/user/userFavoriteItems.do">관심상품</a>
		<a href="${pageContext.request.contextPath}/alert/alert.do">알림</a>
	</c:if>
	
	<c:if test="${!empty user}">
		<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
	</c:if>
	
	<c:if test="${empty user}">
	<a href="${pageContext.request.contextPath}/member/registerUser.do">회원가입</a>
	<a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
	</c:if>
	<c:if test="${!empty user && user.mem_auth == 9}">
	<a href="${pageContext.request.contextPath}/main/admin.do"><b>[관리자메인]</b></a>
	</c:if>
</div>
<div class = "align-right">
	<a href = "${pageContext.request.contextPath}/main/main.do"><b>HOME</b></a>
	<a href = "${pageContext.request.contextPath}/style/list.do"><b>STYLE</b></a>
	<a href = "${pageContext.request.contextPath}/item/itemList.do"><b>SHOP</b></a>
	<a href = "${pageContext.request.contextPath}/fleamarket/marketSelect.do"><b>FLEA MARKET</b></a>
</div>























