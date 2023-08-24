<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<!-- 채팅방 생성 시작 --> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/message.js"></script>   
<div class="page_main">
	<h2 id="ha">채팅방 생성</h2>
	<form action="talkRoomWrite.do" method="post" id="talk_form" class="talkroomForm">
	    <input type="hidden" name="members" id="user" data-id="${user.mem_id}" value="${user.mem_num}">                           
		<ul>
			<li>
				<label for="basic_name">채팅방 이름</label>
				<input type="hidden" name="basic_name" id="basic_name">
				<span id="name_span"></span>
				<input type="checkbox" checked id="name_checked">(자동생성)
			</li><p>
			<li>
				<label>채팅회원검색</label>
				<input type="text" id="member_search" autocomplete="off">
				<ul id="search_area"></ul>
				<div id="talk_member"></div>
			</li>
		</ul>
		<div class="btn_list">
			<input type="submit" value="채팅방 개설" class="btn_auth">
			<input type="button" class="btn_auth" value="목록" onclick="location.href='talkList.do'">
		</div>
	</form>
</div>
<!-- 채팅방 생성 끝 -->










