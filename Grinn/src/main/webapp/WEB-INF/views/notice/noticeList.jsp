<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<div class="page-main">
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
		<c:if test="${count <= 0}">
			<div class="result-display">표시할 게시물이 없습니다.</div>
		</c:if>
		<c:if test="${count > 0}">
			<h3 id="ha">공지사항</h3>
			<table>
				<c:forEach var="notice" items="${list}">
					<tr>
						<td id="notice_title"><a href="detail.do?no_num=${notice.no_num}">${notice.no_title}</a></td>
					</tr>
				</c:forEach>
			</table>
			<div class="align-center">${page}</div>
		</c:if>
		<c:if test="${mem_num==29}">
			<div>
				<input type="button" value="공지사항 등록" onclick="location.href='${pageContext.request.contextPath}/notice/write.do'">
			</div>
		</c:if>
	</div>
</div>