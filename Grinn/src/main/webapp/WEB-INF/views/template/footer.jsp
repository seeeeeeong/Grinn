<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/floating.css">
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/chatbot.js"></script> --%>
<div class = "footer">
	<div class = "footer_inner">
		<div class = "service_area">
			<div class = "customer_service">
				<strong class = "service_title">고객센터 0315-0825</strong>
				<div class = "service_time">
					<dl class = "time_box">
						<dt class = "time_term">운영시간 평일 09:00 - 18:00 (토∙일, 공휴일 휴무) 점심시간 평일 12:50 - 14:00</dt>
					</dl> 
				</div>
				<div class = "service_btn_box">
					<a href = "${pageContext.request.contextPath}/notice/noticefaq.do" class = "btn solid small">자주 묻는 질문</a>
				</div>
			</div>
			<div class = "footer_menu">
				<div class = "menu_box">
					<strong class = "menu_title">이용안내</strong>
					<div class = "menu_title_bottom">
					<ul class = "menu_list">
						<li class = "menu_item">
							<a href = "${pageContext.request.contextPath}/notice/noticeAuth_policy.do" class = "menu_link">검수 기준</a>
						</li>
						<li class = "menu_item">
							<a href = "" class = "menu_link">이용정책</a>
						</li>
						<li class = "menu_item">
							<a href = "" class = "menu_link">패널티 정책</a>
						</li>
						<li class = "menu_item">
							<a href = "" class = "menu_link">커뮤니티 가이드라인</a>
						</li>
					</ul>
					</div>
				</div>
				<div class = "menu_box">
					<strong class = "menu_title">고객지원</strong>
					<div class = "menu_title_bottom">
					<ul class = "menu_list">
						<li class = "menu_item">
							<a href = "${pageContext.request.contextPath}/notice/noticeList.do" class = "menu_link">공지사항</a>
						</li>
						<li class = "menu_item">
							<a href = "" class = "menu_link">서비스 소개</a>
						</li>
						<li class = "menu_item">
							<a href = "" class = "menu_link">스토어 안내</a>
						</li>
						<li class = "menu_item">
							<a href = "" class = "menu_link">판매자 방문접수</a>
						</li>
					</ul>
					</div>
				</div>
			</div>
		</div>
		
		
		
		
		
		
		
		
		
		

		<div class = "corporation_area">
				<a href = "">이용약관</a>
				&nbsp;
				<a href = ""><b>개인정보처리방침</b></a>
			<p>그린 주식회사∙대표 사조     사업자등록번호 : 570-82-82828     통신판매업 : 제 2023-서울강남C-0315호<br>
			사업장소재지 : 서울특별시 강남구 역삼1동 테헤란로 132, 8층     호스팅 서비스 : sist (주)</p>
		</div>
		<div class = "notice_area">
			<p class = "bold"><b>아이디어뱅크 채무지급보증 안내</b><br>
			당사는 고객님의 현금 결제 금액에 대해 아이디어뱅크와 채무지급보증 계약을 체결하여 안전거래를 보장하고 있습니다.</p>
			<p>그린(주)는 통신판매 중개자로서 통신판매의 당사자가 아닙니다. 본 상품은 개별판매자가 등록한 상품으로 상품, 상품정보, 거래에 관한 의무와 책임은 각 판매자에게 있습니다.<br>
			 단, 이용약관 및 정책, 기타 거래 체결 과정에서 고지하는 내용 등에 따라 검수하고 보증하는 내용에 대한 책임은 그린(주)에 있습니다.</p>
		</div>
	</div>
</div>

<!-- 투표 : 신윤서 -->
<div id = "floating">
	<button class = "btn_top" onclick = "location.href='${pageContext.request.contextPath}/poll/pollList.do'">
		<img class = "ico-top" src = "${pageContext.request.contextPath}/images/how_to_vote.png" width = "32" height = "32">
	</button>
</div>
<!-- 채팅 시작 -->
<div id = "floating">
	<button class = "btn_talk" onclick = "location.href='${pageContext.request.contextPath}/talk/talkList.do'">
		<img class = "ico-top" src = "${pageContext.request.contextPath}/images/how_to_talk.jpg" width = "32" height = "32">
	</button>
</div>
<!-- 채팅 끝  -->
<!-- 새창으로챗봇 시작 -->
<div id="floating">
	<input type="hidden" value="${croom_num}">
	<button class="btn_chatbot" id="btn_chatbot" onclick="open3()">
		<img src="${pageContext.request.contextPath}/images/how_to_chatbot.jpg"
			width="32" height="32">
	</button>
</div>
<script type="text/javascript">
function open3(){/* chatbotDetail.do -> chatbotList.do 변경예정 */
  window.open("${pageContext.request.contextPath}/chatbot/chatbotList.do", "_blank", "width=400, height=500");
}
</script>
<!-- 새창으로챗봇 끝  -->

<div class = "align-center">
	&copy; SpringPage
</div>