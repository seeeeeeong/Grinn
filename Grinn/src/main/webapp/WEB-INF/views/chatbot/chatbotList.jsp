<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 채팅방 목록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<div class="body_chatbot" id="body_chatbot">
	<h2>ChatBot</h2>
 	<div class="btn_list">
		<input type="button" value="챗봇문의 생성" onclick="location.href='chatbotCreate.do'" class="btn_auth">
	</div>
	<c:if test="${count == 0}">
		<div class="display-none">이전 문의가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<b>이전 문의 내역</b>
		<c:forEach var="chatbot" items="${list}">
		<tr>
			<td style="width:80%">
				<a href="chatbotDetail.do?croom_num=${chatbot.croom_num}">
					<br>
					<span>${fn:substring(chatbot.chatbotVO.message,0,45)}</span>
				</a>
			</td>
			<td style="width:20%">
				 ${chatbot.chatbotVO.croom_regdate}
			</td>
		</tr>
		</c:forEach>
	</table>
	<%-- <div class="align-center">${page}</div> --%>
	</c:if>
</div>
<!-- 채팅방 목록 끝 -->