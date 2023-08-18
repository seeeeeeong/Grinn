<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 채팅방 목록 시작 -->
<div class="page-main">
	<h2>챗봇으로 문의하기 방 생성 chatbotCreate.do</h2>
	<form action="chatbotCreate.do" method="post" id="talk_form"><!-- talk_form 수정필요 -->
		<input type="hidden" name="members" id="user" data-id="${user.mem_id}" value="${user.mem_num}">
		
	</form>
</div>
<!-- 채팅방 목록 끝 -->










