<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel = "stylesheet" type = "text/css" href = "${pageContext.request.contextPath}/css/sys/header.css">
<head></head>
<body>
<div>
	<div>
		<div class = "header fixed">
			<div class = "header_top">
				<div class = "top_inner"><!--  -->
					<ul class = "top_list"><!--  -->
						<li class = "top_item"><!--  -->
							<a href="${pageContext.request.contextPath}/notice/noticeList.do">고객센터</a>
						</li>
						<li class = "top_item">
							<a href="${pageContext.request.contextPath}/item/fav.do">관심상품</a>
						</li>
						<li class = "top_item">
							<a href="${pageContext.request.contextPath}/alert/alert.do">알림</a>
						</li>
						<li>
							<c:if test="${empty user}">
							<a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
							</c:if>
						</li>
					</ul>
				</div>
			</div>
			<!-- end of header_top -->
			<div class = "header_main">
				<div class = "main_inner"><!--  -->
					<h1>
						<a class = "logo" href = "${pageContext.request.contextPath}/main/main.do">Grinn</a>
					</h1>
					<div class = "center"></div>
					<div class = "right">
						<div class = "gnb_area">
							<nav class = "gnb">
								<ul class = "gnb_list">
									<li class = "gnb_item">
										<a href = "${pageContext.request.contextPath}/main/main.do"><b>HOME</b></a>
									</li>
									<li class = "gnb_item">
										<a href = "${pageContext.request.contextPath}/style/list.do"><b>STYLE</b></a>
									</li>
									<li class = "gnb_item">
										<a href = "${pageContext.request.contextPath}/item/itemList.do"><b>SHOP</b></a>
									</li>
									<li class = "gnb_item">
										<a href = "${pageContext.request.contextPath}/fleamarket/list.do"><b>FLEA MARKET</b></a>
									</li>
								</ul>
							</nav>
							<div class = "">
								<input type = "search" value = "검색">
							</div>
						</div>
					</div>
				</div>
			</div> <!-- end of header_main -->
			<div class = "header_category">
			
			</div> <!-- end of header_category -->
		</div>
	</div>
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








