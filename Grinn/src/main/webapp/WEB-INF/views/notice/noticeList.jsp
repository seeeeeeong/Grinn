<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<div class="page-main">
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
			</table><br>
			<div class="align-center">${page}</div>
		</c:if>
	</div>
	<div class="page-clear"></div>
</div>