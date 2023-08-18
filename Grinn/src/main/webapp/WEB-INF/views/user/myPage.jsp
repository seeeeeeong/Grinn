<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
.user-info-container {
	display: flex;
	align-items: center;
	border: 1px solid rgba(34, 34, 34, 0.3);
	padding: 20px;
	margin: 20px 0;
	border-radius: 5px;
}

.user-info-content {
	display: flex;
	align-items: center;
	gap: 16px;
}

.my-photo {
	width: 100px;
	height: 100px;
}

.user-info-details {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.user-info-buttons {
	display: flex;
	align-items: center;
}

.menu-btn {
	font-size: 12px;
	color: rgba(0, 0, 0, 0.5);
	background-color: transparent;
	border: 1px solid rgba(34, 34, 34, 0.3);
	border-radius: 5px;
	padding: 5px 10px;
	margin-right: 10px;
}

.user-info-meta {
	display: flex;
	align-items: center;
	margin-left: auto;
	text-align: right;
}

.user-info-names {
	font-size: 16px;
	line-height: 1.5;
}

.user-info-names strong {
	font-size: 16px;
	font-weight: bold;
}

.user-info-names span {
	font-size: 14px;
	opacity: 0.5;
}

.user-info-permissions, .user-info-points {
	flex: 1;
	display: flex;
	flex-direction: column;
	align-items: center;
	white-space: nowrap;
	padding: 0 20px;
}

.user-info-permissions {
	border-right: 1px solid rgba(0, 0, 0, 0.3);
	padding-right: 20px;
	white-space: nowrap;
}

.user-info-permissions strong, .user-info-points strong {
	font-size: 16px;
	font-weight: bold;
}

.user-info-permissions span, .user-info-points span {
	font-size: 14px;
	opacity: 0.5;
}

/* 구매내역 */
.myPurchase {
	border: 1px solid rgba(34, 34, 34, 0.3);
	border-radius: 5px;
	padding: 10px;
	display: flex;
	align-items: center;
	justify-content: space-around;
}

.purchase-section {
	flex: 1;
	text-align: center;
	display: flex;
	padding: 10px;
	justify-content: center;
}

.purchase-section a {
	text-decoration: none;
	color: #333;
}

.purchase-section a:hover {
	opacity: 1;
}

.purchase-section strong {
	font-size: 16px;
	font-weight: bold;
}

.myPurchase-link {
	display: flex;
	justify-content: space-between;
	flex: 1;
}

.purchase-section span {
	display: block;
	margin-top: 5px;
}

.purchased-item {
	display: flex;
	align-items: center;
	border: 1px solid rgba(34, 34, 34, 0.3);
	padding: 20px;
	margin: 20px 0;
	border-radius: 5px;
}

.mySale {
	border: 1px solid rgba(34, 34, 34, 0.3);
	border-radius: 5px;
	padding: 10px;
	display: flex;
	align-items: center;
	justify-content: space-around;
}

.sale-section {
	flex: 1;
	text-align: center;
	display: flex;
	padding: 10px;
	justify-content: center;
}

.sale-section a {
	text-decoration: none;
	color: #333;
}

.sale-section a:hover {
	opacity: 1;
}

.sale-section strong {
	font-size: 16px;
	font-weight: bold;
}

.mySale-link {
	display: flex;
	justify-content: space-between;
	flex: 1;
}

.sale-section span {
	display: block;
	margin-top: 5px;
}

.saled-item {
	display: flex;
	align-items: center;
	border: 1px solid rgba(34, 34, 34, 0.3);
	padding: 20px;
	margin: 20px 0;
	border-radius: 5px;
}
</style>
<div class="page-main">
	<!-- 회원정보 시작 -->
	<div class="user-info-container">
		<div class="user-info-content">
			<img src="${pageContext.request.contextPath}/user/photoView.do"
				class="my-photo">
			<div class="user-info-details">
				<div class="user-info-names">
					<strong>${mem_id}</strong><br> <span>${mem_email}</span>
				</div>
				<div class="user-info-buttons">
					<input type="button" class="menu-btn" value="프로필 관리"
						onclick="location.href='${pageContext.request.contextPath}/user/userLoginInfo.do'">
					<a href="/user/userStyle.do?mem_num=${mem_num}"> <input
						type="button" class="menu-btn" value="내 스타일">
					</a>
				</div>
			</div>
		</div>
		<div class="user-info-meta">
			<div class="user-info-permissions">
				<strong>${mem_auth}</strong><br> <span>회원등급</span>
			</div>
			<div class="user-info-points">
				<strong>${mem_point}</strong><br> <span>포인트</span>
			</div>
		</div>
	</div>
	<br>
	<!-- 회원정보 끝 -->
	<!-- 구매내역 시작 -->
	<div class="myPurchase-container">
		<h2 style="font-size: 18px;">구매 내역</h2>
		<div class="myPurchase">
			<div class="purchase-section">
				<a href="${pageConetext.request.contextPath}/user/buying.do?way=1">
					<span style="font-size: 12px; opacity: 0.5;">구매입찰</span> <strong
					style="color: #fa7070;">${purchasedCount}</strong>
				</a>
			</div>
			<div class="purchase-section">
				<a href="${pageConetext.request.contextPath}/user/buying.do?way=2">
					<span style="font-size: 12px; opacity: 0.5;">진행중</span> <strong>${ongoingCount}</strong>
				</a>
			</div>
			<div class="purchase-section">
				<a href="${pageConetext.request.contextPath}/user/buying.do?way=1">
					<span style="font-size: 12px; opacity: 0.5;">종료</span> <strong>${completedCount}</strong>
				</a>
			</div>
		</div>
	</div>

	<div class="purchased-items">
		<c:choose>
			<c:when test="${empty purchasedItems}">
				<div class="purchased-item"
					style="display: flex; align-items: center; justify-content: center;">
					<p style="font-size: 12px; opacity: 0.3;">거래 내역이 없습니다.</p>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${purchasedItems}" var="pitem">

					<div class="purchased-item"
						style="display: flex; align-items: center; justify-content: space-between;">
						<a href="/item/itemDetail.do?item_num=${pitem.item_num}">
							<div class="item-section"
								style="display: flex; align-items: center;">
								<img src="/user/purchasedItem.do?item_num=${pitem.item_num}"
									alt="Purchased Item"
									style="width: 50px; height: 50px; margin-right: 10px;">
								${pitem.item_name}
							</div>
						</a>
						<div class="item-section"
							style="display: flex; align-items: center; gap: 80px; justify-content: center; white-space: nowrap;">
							<span style="margin-left: 10px; opacity: 0.3;">${purchasedDate[0]}</span>
							<c:choose>
								<c:when test="${purchasedState[0] eq 2}">
                        검수준비중
                    </c:when>
								<c:when test="${purchasedState[0] eq 3}">
                        검수중
                    </c:when>
								<c:when test="${purchasedState[0] eq 4}">
                        배송중
                    </c:when>
								<c:when test="${purchasedState[0] eq 5}">
                        배송완료<br>
									<a href="${pageConetext.request.contextPath}/style/write.do" style="font-size: 12px; opacity: 0.5;">스타일올리기</a>
								</c:when>
								<c:when test="${purchasedState[0] eq 6}">
                        거래실패
                    </c:when>
							</c:choose>

						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
	<!-- 구매내역 끝 -->
	<br>
	<br>
	<!-- 판매내역 시작 -->
	<div class="mySale-container">
		<h2 style="font-size: 18px;">판매 내역</h2>
		<div class="mySale">
			<div class="sale-section">
				<a href="${pageConetext.request.contextPath}/user/selling.do?way=1">
					<span style="font-size: 12px; opacity: 0.5;">판매입찰</span> <strong
					style="color: #41B979;">${saledCount}</strong>
				</a>
			</div>
			<div class="sale-section">
				<a href="${pageConetext.request.contextPath}/user/selling.do?way=2">
					<span style="font-size: 12px; opacity: 0.5;">진행중</span> <strong>${saledOngoingCount}</strong>
				</a>
			</div>
			<div class="sale-section">
				<a href="${pageConetext.request.contextPath}/user/selling.do?way=1">
					<span style="font-size: 12px; opacity: 0.5;">종료</span> <strong>${saledCompleteCount}</strong>
				</a>
			</div>
		</div>
	</div>

	<div class="saled-items">
		<c:choose>
			<c:when test="${empty saledItems}">
				<div class="saled-item"
					style="display: flex; align-items: center; justify-content: center;">
					<p style="font-size: 12px; opacity: 0.3;">거래 내역이 없습니다.</p>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${saledItems}" var="sitem">

					<div class="saled-item"
						style="display: flex; align-items: center; justify-content: space-between;">
						<a href="/item/itemDetail.do?item_num=${sitem.item_num}">
							<div class="item-section"
								style="display: flex; align-items: center;">
								<img src="/user/saledItem.do?item_num=${sitem.item_num}"
									alt="Purchased Item"
									style="width: 50px; height: 50px; margin-right: 10px;">
								${sitem.item_name}
							</div>
						</a>
						<div class="item-section"
							style="display: flex; align-items: center; gap: 80px; justify-content: center; white-space: nowrap;">
							<span style="margin-left: 10px; opacity: 0.3;">${saledDate[0]}</span>
							<c:choose>
								<c:when test="${saledState[0] eq 2}">
                        검수준비중
                    </c:when>
								<c:when test="${saledState[0] eq 3}">
                        검수중
                    </c:when>
								<c:when test="${saledState[0] eq 4}">
                        배송중
                    </c:when>
								<c:when test="${saledState[0] eq 5}">
                        배송완료
                    </c:when>
								<c:when test="${saledState[0] eq 6}">
                        거래실패
                    </c:when>
							</c:choose>

						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
	<!-- 판매내역 끝 -->
	<br>
	<br>
	<!-- 관심상품 시작 -->
	<div
		style="display: flex; justify-content: space-between; align-items: center;">
		<h2>관심 상품</h2>
		<a href="/user/userFavoriteItems.do"
			style="font-size: 12px; opacity: 0.3;">더보기</a>
	</div>
	<br>
	<br>
	<div class="favorite-items"
		style="display: flex; flex-wrap: wrap; justify-content: space-between;">
		<c:choose>
			<c:when test="${empty favoriteItems}">
				<div class="favorite-item"
					style="display: flex; align-items: center; justify-content: center; width: 100%;">
					<p style="font-size: 12px; opacity: 0.3;">
						관심 상품이 없습니다.<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
					</p>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${favoriteItems}" var="item" varStatus="loop">
					<c:if test="${loop.index < 8}">
						<div class="favorite-item"
							style="width: 23%; margin-bottom: 20px; text-align: center;">
							<a href="/item/itemDetail.do?item_num=${item.item_num}"> <img
								src="/user/itemImageView.do?item_num=${item.item_num}"
								alt="Item Image" style="width: 200px; height: 200px;">
								<p style="margin: 5px 0;">
									<strong>${item.item_brand}</strong>
								</p>
								<p style="margin: 2px 0;">${item.item_name}</p>
								<p>
									<strong><fmt:formatNumber value="${item.item_price}"
											pattern="#,##0원" /></strong>
								</p>
							</a>
						</div>
					</c:if>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
	<!-- 관심상품 끝 -->
</div>









