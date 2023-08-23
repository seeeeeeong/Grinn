<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/sys/header.css">
<style>
.custom-popup {
	display: none;
	position: fixed;
	top: 0;
	right: 0;
	width: 450px; /* 팝업의 폭을 조정하세요 */
	height: 100%;
	background-color: white;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	z-index: 9999; /* 팝업이 위에 오도록 설정 */
}

.popup-content {
	padding: 20px;
	height: calc(100vh - 40px); /* 팝업 내용의 높이를 뷰포트 높이에 맞게 조절 */
}

.notification-button {
	position: relative;
}

.close-button {
	position: absolute;
	left: -10px; /* X 버튼을 알림 버튼 왼쪽에 위치시키기 위한 값 */
	background: none;
	border: none; /* 테두리 제거 */
	font-size: 16px;
	color: #333; /* 원하는 색상으로 변경 */
	cursor: pointer;
}
</style>


<body>
	<script type="text/javascript">
    var popupVisible = false; // 팝업의 초기 상태

    // 페이지 로드 시 팝업을 숨기도록 설정
    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById('customPopup').style.display = 'none';
    });

    function togglePopup() {
        var loggedIn = ${!empty user};
        
        if (!loggedIn) {
            window.location.href = "${pageContext.request.contextPath}/member/login.do";
            return; // 로그인 페이지로 이동하고 함수 종료
        }

        if (popupVisible) {
            document.getElementById('customPopup').style.display = 'none';
        } else {
            document.getElementById('customPopup').style.display = 'block';
        }
        popupVisible = !popupVisible; // 팝업 상태를 변경
    }

    function closePopup() {
        document.getElementById('customPopup').style.display = 'none';
        popupVisible = false; // 팝업 상태를 닫힌 상태로 설정
    }
</script>




	<div id="layout">
		<div id="wrap" tabindex="0" class="layout_base lg wrap has_tap etc lg">
			<div class="board_line">
				<div class="header fixed">
					<div class="header_top">
						<div class="top_inner">
							<ul class="top_list">
								<li class="top_item"><c:if
										test="${!empty user && user.mem_auth == 9}">
										<a class="top_link"
											href="${pageContext.request.contextPath}/main/admin.do"><b>[관리자메인]</b></a>
									</c:if></li>
								<c:if test="${!empty user && user.mem_auth == 9}">
									<li class="top_item"><a class="top_link"
										href="${pageContext.request.contextPath}/admin/point.do">포인트내역</a>
									</li>
								</c:if>
								<c:if test="${user.mem_auth != 9}">
									<li class="top_item"><a class="top_link"
										href="${pageContext.request.contextPath}/notice/noticeList.do">고객센터</a>
									</li>
									<li class="top_item"><a class="top_link"
										href="${pageContext.request.contextPath}/user/myPage.do">MY페이지</a>
									</li>
									<li class="top_item"><a class="top_link"
										href="${pageContext.request.contextPath}/user/userFavoriteItems.do">관심상품</a>
									</li>


									<li class="top_item">
										<div class="notification-button">
											<a class="top_link" href="javascript:void(0);"
												onclick="togglePopup()">알림</a>
										</div>
									</li>

								</c:if>
								<li class="top_item" id="logout"><c:if
										test="${!empty user}">
										<a class="top_link"
											href="${pageContext.request.contextPath}/member/logout.do"><b>로그아웃</b></a>
									</c:if></li>
								<li class="top_item"><c:if test="${empty user}">
										<a class="top_link"
											href="${pageContext.request.contextPath}/member/login.do"><b>로그인</b></a>
									</c:if></li>
							</ul>
						</div>
					</div>
					<!--  -->




					<div class="header_main">
						<div class="main_inner">
							<div style="display: flex;">
								<h1>
									<a id="logo" class="logo"
										href="${pageContext.request.contextPath}/main/main.do">Grinn</a>
								</h1>
							</div>
							<div class="center"></div>
							<div class="right">
								<div class="gnb_area">
									<nav class="gnb">
										<ul class="gnb_list">
											<li class="gnb_item"><a class="gnb_link"
												href="${pageContext.request.contextPath}/main/main.do">HOME</a>
											</li>
											<li class="gnb_item"><a class="gnb_link"
												href="${pageContext.request.contextPath}/style/list.do">STYLE</a>
											</li>
											<li class="gnb_item"><a class="gnb_link"
												href="${pageContext.request.contextPath}/item/itemList.do">SHOP</a>
											</li>
											<li class="gnb_item"><a class="gnb_link"
												href="${pageContext.request.contextPath}/fleamarket/marketSelect.do">FLEA
													MARKET</a></li>
										</ul>
									</nav>
									<div class="search_btn_box">
										<input type="search">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="portal_target vue-portal-target">
						<nav class="tabs">
							<ul class="ul_tab home_tabs">
								<li class="li_tab"><a class="tab"
									href="${pageContext.request.contextPath}/main/main.do"> <span
										class="tab_name">추천</span>
								</a></li>
								<li class="li_tab"><a class="tab"
									href="${pageContext.request.contextPath}/main/main.do?item_gender=1">
										<span class="tab_name">남성</span>
								</a></li>
								<li class="li_tab"><a class="tab"
									href="${pageContext.request.contextPath}/main/main.do?item_gender=2">
										<span class="tab_name">여성</span>
								</a></li>
								<li class="li_tab"><a class="tab"
									href="${pageContext.request.contextPath}/main/main.do?item_gender=3">
										<span class="tab_name">럭셔리</span>
								</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 사용자 지정 팝업 -->
	<div id="customPopup" class="custom-popup">
		<div class="popup-content">
			<div class="notification-button">
				<button class="close-button" onclick="closePopup()">X</button>
				<a class="top_link" href="javascript:void(0);"
					onclick="togglePopup()"><h2>&nbsp;&nbsp;&nbsp;&nbsp;알림</h2></a>
			</div>
			<iframe src="${pageContext.request.contextPath}/user/alert.do"
				width="100%" height="100%" frameborder="0"></iframe>

		</div>
	</div>



</body>







