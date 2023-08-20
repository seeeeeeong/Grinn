<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 채팅방 목록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<div class="body_chatbot">
	<h2 id="ha">문의를 시작하시겠습니까?</h2>
	<form action="chatbotCreate.do" class="talk_form" method="post" id="talk_form"><!-- talk_form 수정필요 -->
		<input type="hidden" name="members" id="user" data-id="${user.mem_id}" value="${user.mem_num}">
		<div class="btn_list">
			<input type="submit" value="시작하기" class="btn_auth">
		</div>
	</form>
</div>
<!-- 채팅방 목록 끝 -->










