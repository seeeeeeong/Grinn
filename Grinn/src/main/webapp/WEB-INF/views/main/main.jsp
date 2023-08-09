<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/swiper.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<div class = "body">
	<div class="swiper-container mySwiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<img src = "${pageContext.request.contextPath}/images/promotion1.jpeg">
			</div>
			<div class="swiper-slide">
				<img src = "${pageContext.request.contextPath}/images/promotion2.jpeg">
			</div>
			<div class="swiper-slide">
				<img src = "${pageContext.request.contextPath}/images/promotion3.jpeg">
			</div>
			<div class="swiper-slide">
				<img src = "${pageContext.request.contextPath}/images/promotion4.jpeg">
			</div>
		</div>
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
		<div class="swiper-pagination"></div>
	</div>
	<script>
		var swiper = new Swiper(".mySwiper", {
			spaceBetween: 30,
			centeredSlides: true,
			autoplay: {
				delay: 3000,
				disableOnInteraction: false,
			},
			pagination: {
				el: ".swiper-pagination",
				clickable: true,
			},
			navigation: {
				nextEl: ".swiper-button-next",
				prevEl: ".swiper-button-prev",
			},
		});
	</script>
</div>
<div class="page-main">
	<div class = "container">
		<div style = "display:none;"></div>
		<div class = "home">
			<div class = "home_card_list">
				
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















