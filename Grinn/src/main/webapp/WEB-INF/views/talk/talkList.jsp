<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/message.js"></script>   
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<script type="text/javascript">
	$(document).ready(function(){
		if(${talkroom_num} == 0){
			$('#chatDetail_main').css('display','none');
		}
		
		$('#detail_btn').each(function(){
			$(this).click(function(){
				$('#chatDetail_main').css('display','block');
			});
		});
		
		/* let detail_btn = document.getElementById('detail_btn');
		let chatDetail_main = document.getElementById('chatDetail_main');
		detail_btn.onclick = function(){
			chatDetail_main.style.display = 'block';
		}; */
	});
	
</script>
<!-- 채팅방 목록 시작 -->
<div class="page-main">
	<c:if test="${count == 0}">
		<div class="display-none">표시할 채팅방이 없습니다.</div>
		<div class="btn_list">
			<input type="button" value="채팅방 생성" onclick="location.href='talkRoomWrite.do'" class="btn_auth">
		</div>
	</c:if>
		
	<div class="chatList_main">
		<h2>채팅리스트</h2>
		<c:if test="${count > 0}">
		<table class="striped-table">
			<c:forEach var="talk" items="${list}">
			<tr>
				<td>
					<a href="talkList.do?talkroom_num=${talk.talkroom_num}" id="detail_btn">
						<b>${talk.talkMemberVO.room_name} <c:if test="${talk.room_cnt > 0}">(${talk.room_cnt})</c:if></b>
						<br>
						<span>${fn:substring(talk.talkVO.message,0,45)}</span>
					</a>
				</td>
				<td>
					<c:if test="${!empty talk.talkVO.chat_date}">${talk.talkVO.chat_date}</c:if>
					<c:if test="${empty talk.talkVO.chat_date}">${talk.talkroom_date}</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
		<div class="btn_list">
			<input type="button" value="채팅방 생성" onclick="location.href='talkRoomWrite.do'" class="btn_auth">
		</div>
		<div class="align-center">${page}</div>
		</c:if>
	</div>
	<!-- 채팅방 목록 끝 -->
	<!-- 채팅방 디테일 시작 -->
	<div class="chatDetail_main" id="chatDetail_main">
		<div id="talkDetail">
		<input type="hidden" name="talkroom_num" id="talkroom_num" value="${talkroom_num}">
		<div class="btn_list">
			<h2 id="chatroom_title">
				<span id="chatroom_name">${room_name}</span>
				<input type="button" value="채팅방이름 변경" id="change_name" class="btn_auth">
			</h2>
			<input type="button" value="멤버추가" id="opener" class="btn_auth">
			<input type="button" value="방탈출" id="delete_talkroom" class="btn_auth">
			<input type="button" value="목록"  class="btn_auth" onclick="location.href='talkList.do'">
		</div>
		<p class="align-right">
			채팅 멤버 :
			<span id="chat_member">${chatMember}</span>
			<span id="chat_mcount">(${chatCount}명)</span>
		</p>
			<!-- 메세지내용 -->
			<div id="chatting_message"></div>
			<form method="post" id="detail_form">
				<input type="hidden" name="talkroom_num" id="talkroom_num"
				               value="${param.talkroom_num}">
				<ul>
					<li>
						<label for="message">내용</label>
						<textarea rows="5" cols="60"
						  name="message" id="message"></textarea>
					</li>
				</ul> 
				<div class="align-right" id="message_btn">
					<input type="submit" value="전송"> 
				</div>              
			</form>
			<!-- 멤버 추가 다이얼로그 시작 -->
			<div id="dialog">
				<form id="new_form">
					<input type="hidden" name="talkroom_num" value="${param.talkroom_num}">
					<ul>
						<li>
							<label for="member_search">추가할 회원</label>
							<input type="text" id="member_search" autocomplete="off">
							<ul id="search_area"></ul>
							<div id="talk_member"></div>
						</li>
					</ul>
					<div class="align-center">
						<input type="submit" value="전송">
					</div>
				</form>
			</div>
			<!-- 멤버 추가 다이얼로그 끝 -->
		</div>
	</div>
	<!-- 채팅방 디테일 끝 -->
</div>
<div class="page_clear"></div>









