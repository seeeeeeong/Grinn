<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/category.js"></script>
<div class="page-main">
	<div class="container">
		<div id="page_nav">
			<ul>
				<li><a href="${pageContext.request.contextPath}/notice/noticeList.do">고객센터</a></li>
			</ul>
			<ul>
				<li><a href="${pageContext.request.contextPath}/notice/noticeList.do">공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/notice/noticefaq.do">자주묻는질문</a></li>
				<li><a href="${pageContext.request.contextPath}/notice/noticeAuth_policy.do">검수기준</a></li>
			</ul>
		</div>
		<div id="page_body">
			<h3 id="ha">검수기준</h3>
			<c:forEach var="notice" items="${list}">
				<table class="category"><br>
					<tr>
						<td><a href="${pageContext.request.contextPath}/notice/noticeAuth_policy.do/shoes.do">신발</a></td>
						<td><a href="${pageContext.request.contextPath}/notice/noticeAuth_policy.do">상의</a></td>
						<td><a href="${pageContext.request.contextPath}/notice/policyCategory/bottom.do">하의</a></td>
					</tr>
					<tr>
						<td id="acc">패션잡화</td>
						<td id="watch">프리미엄 시계</td>
						<td id="bag">프리미엄 가방</td>
					</tr>
				</table>
			</c:forEach>
		</div>
	</div>
</div>
