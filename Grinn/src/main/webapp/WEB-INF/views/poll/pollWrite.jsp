<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/searchItem.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/poll.css">
<style>
	.poll_deadline {
		padding-top: 10px;
	}
</style>
<div class = "page-main">
	<form:form modelAttribute = "pollVO" action = "pollWrite.do" id = "poll_write">
	<input type="hidden" name="items" id="user" data-id="${user.mem_id}" value="${user.mem_num}"> 
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li class="floating-label"><b>투표 제목</b>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<form:input path="poll_title"/>
				<form:errors path="poll_title" cssClass="error-color"/>      
			</li>
			<li class="floating-label"><b>투표 내용</b>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<form:input path = "poll_content"/>     
			</li>
			<li>
				<li class="floating-label"><b>투표 항목 검색</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type = "text" id = "item_search" autocomplete = "off">
				<ul id = "search_area"></ul>
				<div id = "poll_item"></div>
			</li>
			<li>
				<form:label path="poll_deadline" id = "poll_deadline"><b>마감일</b></form:label>
				<form:input path="poll_deadline" type="date"/>
				<form:errors path="poll_deadline" cssClass="error-color"/>
			</li>
		</ul>
		<div class = "divdiv">
			<div class = "content-poll">
				<form:button class="submit-poll" onclick = "location.href='${pageContext.request.contextPath}/poll/selectItem.do">투표 등록하기</form:button>
				<form:button class="list-poll" onclick = "location.href='${pageContext.request.contextPath}/poll/pollList.do">목록</form:button>
			</div>    
		</div>	         
	</form:form>
</div>