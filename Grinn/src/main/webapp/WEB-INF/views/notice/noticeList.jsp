<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<div id="page_nav">
		<jsp:include page="${pageContext.request.contextPath}/sidebarJsp/noticeSidebar.jsp"></jsp:include>	
	</div>
	<div id="page_body">
		<c:if test="${count <= 0}">
			<div class="result-display">표시할 게시물이 없습니다.</div>
		</c:if>
		<c:if test="${count > 0}">
			<h3>공지사항</h3>
			<table>
				<c:forEach var="notice" items="${list}">
					<tr>
						<td>${notice.no_title}</td>
					</tr>
				</c:forEach>
			</table>
			<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>