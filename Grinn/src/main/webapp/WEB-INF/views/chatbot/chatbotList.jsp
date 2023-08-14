<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 채팅방 목록 시작 -->
<div class="page-main">
	<h2>채팅리스트</h2>
	<div class="align-right">
		<input type="button" value="챗봇문의 생성" onclick="location.href='chatbotRoomWrite.do'">
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 채팅방이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<c:forEach var="chatbot" items="${list}">
		<tr>
			<td>
				<a href="chatbotDetail.do?croom_num=${chatbot.croom_num}">
					<br>
					<span>${fn:substring(talk.talkVO.message,0,45)}</span>
				</a>
			</td>
			<td>
				${chatbot.chatbotVO.croom_regdate}
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>	
</div>
<!-- 채팅방 목록 끝 -->










