<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/polling.item.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/polling.css">
<form:form modelAttribute = "pollVO" action = "pollList.do" id = "poll_list">

	<div class = "page-main">
	<%-- 
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>투표수</option>
			</select>
		</div>
	--%>
		<script type="text/javascript">
			$(function(){
				$('#order').change(function(){
					location.href='&order='+$('#order').val();
				});
			});
		</script>
		<div class = "align-right">
			<c:if test="${!empty user}">
				<input type = "button" value = "투표등록" onclick = "location.href='pollWrite.do'" class = "insert-poll">
			</c:if>
		</div>
		
		
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
								<a href="${pageContext.request.contextPath}/user/userStyle.do?mem_num=${poll.mem_num}">
									<img class = "user-photo" src="${pageContext.request.contextPath}/member/viewProfile.do?mem_num=${poll.mem_num}">
								</a>
								<div class = "user-profile-name">
									<a href="${pageContext.request.contextPath}/user/userStyle.do?mem_num=${poll.mem_num}">
										<span class = "mem-id"><b>${poll.mem_id}</b></span>
									</a>
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
									<a href = "${pageContext.request.contextPath}/poll/pollView.do?poll_num=${poll.poll_num}">
										<span><b>${poll.poll_title}</b></span>
									</a>
								</div>
							</div>
							<div class = "poll-item-content">
								<c:if test = "${!empty poll.poll_content}">
								<span class = "poll-content">${poll.poll_content}</span>
								</c:if>
							</div>
						</div>
						</div><%-- poll-item3 --%>
				</c:forEach>
			</c:if>
		</div><%-- poll_list --%>
		<div class = "align-center">${page}</div>
	</div><%-- page-main --%>
</form:form>


