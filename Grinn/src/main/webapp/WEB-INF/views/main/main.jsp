<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_swiper.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<div class = "body">
	<div class="swiper-container mySwiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide" style="width:100%;">
				<img src = "${pageContext.request.contextPath}/images/promotion1.jpeg">
			</div>
			<div class="swiper-slide" style="width:100%;">
				<img src = "${pageContext.request.contextPath}/images/promotion2.jpeg">
			</div>
			<div class="swiper-slide" style="width:100%;">
				<img src = "${pageContext.request.contextPath}/images/promotion3.jpeg">
			</div>
			<div class="swiper-slide" style="width:100%;">
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
	<div class="page-main">
		<div class="container">
			<div style="display: none;"></div>
			<div class="home">
				<div class="home_card_list">
					<div class="collection">
						<div class="collection_items">
							<div class="collection_item">
								<div class="item_img">
									<img class="item_img_bg"
										src="${pageContext.request.contextPath}/images/grinndraw.png">
								</div>
								<p class="item_title">그린 드로우</p>
							</div>
							<c:forEach var="promotion" items="${promotionList}" varStatus="status">
								<div class="collection_item">
									<div class="item_img">
										<a href="${pageContext.request.contextPath}/promotion/detail.do?pro_num=${promotion.pro_num}">
											<img class="item_img_bg"
												src="${pageContext.request.contextPath}/images/event${status.index+1}.png">
										</a>
									</div>
									<p class="item_title">${promotion.pro_name}</p>
								</div>
							</c:forEach>
							<div class="collection_item">
								<div class="item_img">
									<a href="${pageContext.request.contextPath}/item/itemList.do?tab=2">
										<img class="item_img_bg"
											src="${pageContext.request.contextPath}/images/new.png">
									</a>
								</div>
								<p class="item_title">상의 추천</p>
							</div>
							<div class="collection_item">
								<div class="item_img">
									<a href="${pageContext.request.contextPath}/item/itemList.do?tab=3">
										<img class="item_img_bg"
											src="${pageContext.request.contextPath}/images/male.png">
									</a>
								</div>
								<p class="item_title">하의 추천</p>
							</div>
							<div class="collection_item">
								<div class="item_img">
									<a href="${pageContext.request.contextPath}/item/itemList.do?tab=1">
										<img class="item_img_bg"
											src="${pageContext.request.contextPath}/images/female.png">
									</a>	
								</div>
								<p class="item_title">신발 추천</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="home-products">
			<div class="home-products-title">
				<div class="title-wrap">
				<c:if test="${item_gender == 0}">
					<div class="title">
						New Item
					</div>
					<div class="sub-title">
						신규 상품
					</div>
				</c:if>
				<c:if test="${item_gender == 1}">
					<div class="title">
						For Men
					</div>
					<div class="sub-title">
						남성 추천 상품
					</div>
				</c:if>
				<c:if test="${item_gender == 2}">
					<div class="title">
						For Women
					</div>
					<div class="sub-title">
						여성 추천 상품
					</div>
				</c:if>	
				<c:if test="${item_gender == 3}">
					<div class="title">
						Luxury
					</div>
					<div class="sub-title">
						인기 럭셔리 상품
					</div>
				</c:if>							
				</div>
			</div>
			<div class="home-products-list">
				<div class="products-list">
					<c:if test="${item_gender == 0}">
					<c:forEach var="item" items="${itemList}">
						<div class="product-item">
							<a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}">
								<div class="thumb-box">
									<div class="product">
										<img src="${pageContext.request.contextPath}/item/photoView.do?item_num=${item.item_num}">
									</div>
								</div>
								<div class="info-box">
									<div class="brand">
										<p class="brand-text">${item.item_brand}</p>
									</div>
									<p class="name">${item.item_name}</p>
									<div class="price">
										<div class="amount">
											<em><fmt:formatNumber value="${item.item_price}"/>원</em>
										</div>
										<div class="amount-notice">
											<p>구매가</p>
										</div>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
					</c:if>
					<c:if test="${item_gender != 0}">
					<c:forEach var="item" items="${itemGenderList}">
						<div class="product-item">
							<a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}">
								<div class="thumb-box">
									<div class="product">
										<img src="${pageContext.request.contextPath}/item/photoView.do?item_num=${item.item_num}">
									</div>
								</div>
								<div class="info-box">
									<div class="brand">
										<p class="brand-text">${item.item_brand}</p>
									</div>
									<p class="name">${item.item_name}</p>
									<div class="price">
										<div class="amount">
											<em><fmt:formatNumber value="${item.item_price}"/>원</em>
										</div>
										<div class="amount-notice">
											<p>구매가</p>
										</div>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
		<div class="home-products-brand">
			<div class="home-products-title">
				<div class="title-wrap">
					<div class="title">
						New Brand
					</div>
					<div class="sub-title">
						신규 브랜드
					</div>
				</div>
			</div>
			<div class="brand-products-list">
				<div class="brand-product">
					<c:forEach var="brand" items="${brand}">
						<div class="brand-item">
						<a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${brand.item_num}">
							<div class="thumb-box">
								<img src="${pageContext.request.contextPath}/item/photoView.do?item_num=${brand.item_num}">
							</div>
							<p class="brand-product-name">${brand.item_brand}</p>
						</a>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 내용 끝 -->











