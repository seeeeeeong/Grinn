<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/main.css">
<!-- 내용 시작 -->
<div class="page-main">
	main 화면입니다.
	<div class = "container">
		<div style = "display:none;"></div>
		<div class = "home">
			<div class = "home_card_list">
				<div class = "banner_slide">
					<div class = "flicking-viewport">
						<div class = "flicking-camera">
							<!-- banner -->
							<div class = "banner">
								<div class = "banner_item">
									<div class = "item_inner">
										<div class = "img-box">
											<img alt = "banner" class = "banner_img">
										</div>
									</div>
								</div>
							</div>
							<!-- banner -->
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
							<div class = "item_img">
								<img class = "item_img_bg" src = "${pageContext.request.contextPath}/images/grinndraw.png">
							</div>
							<p class = "item_title">그린 드로우</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img">
								<img class = "item_img_bg" src = "${pageContext.request.contextPath}/images/event_sony.jpeg">
							</div>
							<p class = "item_title">8월 이벤트</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img">
								<img class = "item_img_bg" src = "${pageContext.request.contextPath}/images/summer.jpeg">
							</div>
							<p class = "item_title">SUMMER 이벤트</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img">
								<img class = "item_img_bg" src = "${pageContext.request.contextPath}/images/new.png">
							</div>
							<p class = "item_title">신상품</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img">
								<img class = "item_img_bg" src = "${pageContext.request.contextPath}/images/male.png">
							</div>
							<p class = "item_title">남성 추천</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img">
								<img class = "item_img_bg" src = "${pageContext.request.contextPath}/images/female.png">
							</div>
							<p class = "item_title">여성 추천</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
</div>
<!-- 내용 끝 -->















