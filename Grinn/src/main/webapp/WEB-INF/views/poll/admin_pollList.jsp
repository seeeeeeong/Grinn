<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/polling.item.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/polling.css">
<form:form modelAttribute = "pollVO" action = "admin_pollList.do" id = "admin_pollList">

	<div class = "page-main">
		<div class = "poll_list">
			<c:if test = "${count == 0}">
				<div class = "result-display">표시할 게시물이 없습니다.</div>
			</c:if>
			<c:if test = "${count > 0}">
				<c:forEach var = "poll" items = "${list}">
					<div class = "poll-item">
						<!-- 1 -->
						<div class = "poll-itemone">
							<div class = "user-profile">
								<img class = "user-photo" src="${pageContext.request.contextPath}/member/viewProfile.do?mem_num=${poll.mem_num}">
								<div class = "user-profile-name">
									<span class = "mem-id"><b>${poll.mem_id}</b></span>
									<div class = "poll-date">
										<span class = "poll-sdate"><small>시작일 : ${poll.poll_date}</small></span>
										<span class = "poll-edate"><small>종료일 : ${poll.poll_deadline}</small></span>
									</div>
								</div>
							</div>
						</div>
						<!-- 2 -->
						<div class = "poll-content-detail">
							<div class = "poll-item-title">
								<input type="hidden" data-id="${poll.poll_num}" value="${poll.poll_num}"> 
								<div class = "poll-title">
									<span><b>${poll.poll_title}</b></span>
								</div>
							</div>
							<div class = "poll-item-content">
								<c:if test = "${!empty poll.poll_content}">
								<span class = "poll-content">${poll.poll_content}</span>
								</c:if>
							</div>
						</div>
						<div class = "align-right">
		      				<span id="delete_btn" style = "color:gray;">삭제</span>
							<script type="text/javascript">
								let delete_btn = document.getElementById('delete_btn');
								delete_btn.onclick=function(){
									let choice = confirm('글을 삭제하시겠습니까?');
									if(choice){
										location.replace('delete.do?poll_num=${poll.poll_num}');
									}
								};
							</script>
						</div>
					</div><%-- poll-item --%>
				</c:forEach>
			</c:if>
		</div><%-- poll_list --%>
		<div class = "align-center">${page}</div>
	</div><%-- page-main --%>
</form:form>


