<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel = "stylesheet" type = "text/css" href = "${pageContext.request.contextPath}/css/sys/header.css">
<body>
<div id = "layout">
	<div id = "wrap" tabindex = "0" class = "layout_base lg wrap has_tap etc lg">
	<div></div>
		<div class = "header fixed">
			<div class = "header_top">
				<div class = "top_inner">
					<ul class = "top_list">
						<c:if test="${user.mem_auth != 9}">
						<li class = "top_item">
							<a class = "top_link" href="${pageContext.request.contextPath}/notice/noticeList.do">고객센터</a>
						</li>
						<li class = "top_item">
							<a class = "top_link" href="${pageContext.request.contextPath}/user/myPage.do">MY페이지</a>
						</li>
						<li class = "top_item">
							<a class = "top_link" href="${pageContext.request.contextPath}/item/fav.do">관심상품</a>
						</li>
						<li class = "top_item">
							<a class = "top_link" href="${pageContext.request.contextPath}/alert/alert.do">알림</a>
						</li>
						</c:if>
						<li class = "top_item">
							<c:if test="${!empty user}">
							<a class = "top_link" href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
							</c:if>
						</li>
						<li class = "top_item">
							<c:if test="${empty user}">
							<!-- 로그인 안에 회원가입 넣기 -->
							<a class = "top_link" href="${pageContext.request.contextPath}/member/login.do">로그인</a>
							</c:if>
						</li>
						<li class = "top_item">
							<c:if test="${!empty user && user.mem_auth == 9}">
							<a class = "top_link" href="${pageContext.request.contextPath}/main/admin.do"><b>[관리자메인]</b></a>
							</c:if>
						</li>
					</ul>
				</div>
			</div>
			<!-- end of header_top -->
			
			
			
			
			<div class = "header_main">
				<div class = "main_inner"><!--  -->
					<h1>
						<a id = "logo" class = "logo" href = "${pageContext.request.contextPath}/main/main.do">Grinn</a>
					</h1>
					<div class = "center"></div>
					<div class = "right">
						<div class = "gnb_area">
							<nav class = "gnb">
								<ul class = "gnb_list">
									<li class = "gnb_item">
										<a class = "gnb_link" href = "${pageContext.request.contextPath}/main/main.do">HOME</a>
									</li>
									<li class = "gnb_item">
										<a class = "gnb_link" href = "${pageContext.request.contextPath}/style/list.do">STYLE</a>
									</li>
									<li class = "gnb_item">
										<a class = "gnb_link" href = "${pageContext.request.contextPath}/item/itemList.do">SHOP</a>
									</li>
									<li class = "gnb_item">
										<a class = "gnb_link" href = "${pageContext.request.contextPath}/fleamarket/marketSelect.do">FLEA MARKET</a>
									</li>
								</ul>
							</nav>
							<div class = "search_btn_box">
								<input type = "search" value = "검색">
							</div>
						</div>
					</div>
				</div>
			</div> <!-- end of header_main -->
			
			
			
			
			
			<div class = "portal_target vue-portal-target">
				<nav class = "tabs">
					<ul class = "ul_tab">
						<li class = "li_tab">
							<a class = "tab" href = "">
								<span class = "tab_name">추천</span>
							</a>
						</li>
						<li class = "li_tab">
							<a class = "tab" href = "">
								<span class = "tab_name">남성</span>
							</a>
						</li>
						<li class = "li_tab">
							<a class = "tab" href = "">
								<span class = "tab_name">여성</span>
							</a>
						</li>
						<li class = "li_tab">
							<a class = "tab" href = "luxury">
								<span class = "tab_name">럭셔리</span>
							</a>
						</li>
					</ul>
				</nav>
			</div> <!-- end of header_category -->
		</div><!-- end of header fixed -->
	</div><!-- id = "wrap" -->
	
	
	
	
	
	
	
	
	
	
	<div class = "container">
		<div style = "display:none;"></div>
		<div class = "home">
			<div class = "main_banner">
				<div class = "banner_slide">
					<div class = "banner_slide_light">
						<div>
							<div class = "banner">
								<div class = "banner_item">
									<div class = "item_inner">
										<div class = "img-box"></div>
									</div>
								</div>
							</div>
						</div>
						<span class = "arrow-prev"></span>
						<span class = "arrow-next"></span>
						<div class = "pagination">
							<span class = "bullet"></span>
							<span class = "bullet"></span>
							<span class = "bullet"></span>
						</div>
					</div>
				</div>
				<div class = "collection">
					<div class = "collection_items">
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">그린드로우</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">7월 이벤트</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">SUMMER 이벤트</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">신상품</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">남성 추천</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">여성 추천</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>








