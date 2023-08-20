<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/chatbot.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.min.js"></script>
<script type="text/javascript">
</script>
<!-- 챗봇 상세 -->
<div class="body_chatbot" id="body_chatbot">
	<!-- 챗봇 내용 시작 -->
	<div class="chatbot_content" id="chatbotDetail">
		<input type="hidden" name="croom_num" id="croom_num" value="${croom_num}">
		<ul class="list_talk">
			<!-- 문의날짜는 chatbot.js에서 -->
			<li class="log_my">
				<div class="inner_talk">
				<!-- inner_talk 시작 -> chatbot_message 그자체가 된다 -->
					<div class="talk_info">
						<div class="bubble">
						<p class="txt">문의내용넣을곳</p>
						<div id="chatbot_message"></div>
						</div>
						<div class="etc">
							<span class="desc">읽음 <!--읽었는지는 체크 안해도 되겠지?--></span>
							<span class="desc">오후 5:33 <!--채팅보낸시간 넣어줄거고--></span>
						</div>
					</div>
				<!-- inner_talk 끝 -->
				</div>
			</li>
		</ul>
		<!-- 입력창 -->
		<div class="talk_write">
			<div class="frame_msg">
				<!-- 내용 입력 -->
				<form method="post" id="c_detail_form">
					<div class="inner">
						<label for="msgInputArea" class="blind">채팅입력창</label>
						<input type="hidden" name="croom_num" id="croom_num" value="${param.croom_num}">
						<textarea id="msgInputArea" name="msgInputArea" placeholder="메시지를 입력하세요." rows="1" class="msg_input"></textarea>
					</div>
				
					<!-- 보내기 버튼 
					<div class="frame_attach">
						<button onclick="location.href='chatbotDetail.do'">
							<img src="${pageContext.request.contextPath}/images/how_to_send.jpg" width="50" class="sendBtn">
							<span class="blind">입력 완료</span>
						</button>
					</div>-->
				</form>
			</div>
		</div>
	</div>
	<!-- 챗봇 내용 끝 -->
</div>
<!-- 챗봇 상세 -->