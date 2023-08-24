<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.tab-content {
	display: none;
	overflow: auto; /* 스크롤 생성 */
	max-height: 590px; /* 내용이 표시될 최대 높이 설정 */
	position: relative;
}

.tab-content.active {
	display: block;
}

.fav-info-container {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	gap: 10px;
}

.fav-item {
	display: flex;
	align-items: center;
	width: 100%;
	justify-content: space-between;
	border-bottom: 1px solid #ccc; /* 테두리 스타일 추가 */
	padding: 5px; /* 내용과 테두리 사이의 여백 */
}

.my-photo {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	object-fit: cover;
}

.text-content {
	flex: 1;
	overflow: hidden;
	text-overflow: ellipsis;
	margin-right: 10px;
}

.style-image {
	width: 50px;
	height: 50px;
	object-fit: cover;
}

.text-small {
	font-size: 12px;
}

.transparent-bg {
	background-color: rgba(255, 255, 255, 0.5); /* 투명도 설정 */
}

/* 버튼 스타일 수정 */
#transactionTabButton, #styleTabButton {
	border: none;
	background: none;
	font-size: 14px;
	cursor: pointer;
}

#transactionTabButton.active, #styleTabButton.active {
	border-bottom: 2px solid black;
	font-weight: bold;
}

.tab-buttons {
	display: flex;
	gap: 10px;
	margin-bottom: 10px;
}

/* 추가 스타일 */
.tab-buttons .active {
	border-bottom: 2px solid black;
}

/* 버튼 스타일 추가 */
.tab-buttons button {
	font-size: 14px;
	opacity: 0.5;
	border: none;
	background-color: white;
	border-radius: 10px;
	padding: 5px 10px;
	border: 1px solid rgba(0, 0, 0, 0.3);
}

.tab-buttons button.active {
	opacity: 1;
	border: 1px solid rgba(0, 0, 0, 0.3);
}
</style>
</head>
<body>
	<button id="transactionTabButton" class="active">쇼핑</button>
	<button id="styleTabButton">스타일</button>
	<hr>
	<br>

	 <div class="tab-content" id="transactionContent">
		<c:forEach var="purchase" items="${purchaseList}">
			
			<div class="fav-info-container">
				
					<div class="fav-item">
						<img
							src="/user/itemImageView.do?item_num=${purchase.item_num}"
							alt="Item Image" style="width: 50px; height: 50px;">
						<div class="text-content">
							<c:choose>
								<c:when test="${purchase.trade_state == 2}">
									<strong class="text-small">&nbsp;&nbsp;검수준비중</strong>
								</c:when>
								<c:when test="${purchase.trade_state == 3}">
									<strong class="text-small">&nbsp;&nbsp;검수중</strong>
								</c:when>
								<c:when test="${purchase.trade_state == 4}">
									<strong class="text-small">&nbsp;&nbsp;배송중</strong>
								</c:when>
								<c:when test="${purchase.trade_state == 5}">
									<strong class="text-small">&nbsp;&nbsp;배송완료</strong>
								</c:when>
								<c:when test="${purchase.trade_state == 6}">
									<strong class="text-small">&nbsp;&nbsp;거래실패</strong>
								</c:when>
								<c:otherwise>
									<strong class="text-small">&nbsp;&nbsp;${purchase.trade_state}</strong>
								</c:otherwise>
							</c:choose>
							<br> <span class="text-small transparent-bg">&nbsp;&nbsp;${purchase.item_name}
								<br>&nbsp;&nbsp;${purchase.trade_regDate}
							</span>
						</div>
					</div>
				
			</div>
	</c:forEach>
	
	<c:forEach var="sale" items="${saleList}">
			
			<div class="fav-info-container">
				
					<div class="fav-item">
						<img
							src="/user/itemImageView.do?item_num=${sale.item_num}"
							alt="Item Image" style="width: 50px; height: 50px;">
						<div class="text-content">
							<c:choose>
								<c:when test="${sale.trade_state == 2}">
									<strong class="text-small">&nbsp;&nbsp;검수준비중</strong>
								</c:when>
								<c:when test="${sale.trade_state == 3}">
									<strong class="text-small">&nbsp;&nbsp;검수중</strong>
								</c:when>
								<c:when test="${sale.trade_state == 4}">
									<strong class="text-small">&nbsp;&nbsp;배송중</strong>
								</c:when>
								<c:when test="${sale.trade_state == 5}">
									<strong class="text-small">&nbsp;&nbsp;배송완료</strong>
								</c:when>
								<c:when test="${sale.trade_state == 6}">
									<strong class="text-small">&nbsp;&nbsp;거래실패</strong>
								</c:when>
								<c:otherwise>
									<strong class="text-small">&nbsp;&nbsp;${sale.trade_state}</strong>
								</c:otherwise>
							</c:choose>
							<br> <span class="text-small transparent-bg">&nbsp;&nbsp;${sale.item_name}
								<br>&nbsp;&nbsp;${sale.trade_regDate}
							</span>
						</div>
					</div>
				
			</div>
	</c:forEach>
	</div> 




	<div class="tab-content" id="styleContent">
		<div class="tab-buttons">
			<button class="like-tab-button">좋아요</button>
			<button class="comment-tab-button">댓글</button>
			<button class="follow-tab-button">팔로우</button>
		</div>
		<br>


	</div>

	<!-- 스타일 탭 내용을 여기에 표시합니다. -->
	<div class="like-tab tab-content">

		<c:forEach var="fav" items="${favList}">

			<div class="fav-info-container">
				
					<div class="fav-item">
						<img src="/user/userProfile.do?mem_num=${fav.mem_num}"
							class="my-photo">
						<div class="text-content">
							<strong class="text-small">&nbsp;&nbsp;${fav.mem_id}</strong><span
								class="text-small transparent-bg">님이 회원님의 게시글을 좋아합니다.</span>
						</div>
						<img src="/user/StyleImageView.do?st_num=${fav.st_num}"
							class="style-image">
					</div>
				
			</div>
		</c:forEach>
	</div>

	<div class="comment-tab tab-content">
		<c:forEach var="comment" items="${commentList}">
			<div class="fav-info-container">
				<c:if test="${not empty comment}">
					

						<div class="fav-item">
							<img src="/user/userProfile.do?mem_num=${comment.mem_num}"
								class="my-photo">
							<div class="text-content">
								<strong class="text-small">&nbsp;&nbsp;${comment.mem_id}</strong>
								<span class="text-small transparent-bg"> 님이 댓글을 남겼습니다:
									${comment.com_comment} </span>
							</div>
							<img src="/user/StyleImageView.do?st_num=${comment.st_num}"
								class="style-image">
						</div>
					
				</c:if>
			</div>
		</c:forEach>
	</div>



	 <div class="follow-tab tab-content">

		<div class="fav-info-container">
			<c:forEach var="follow" items="${followInfo}">
				<div class="fav-item">
					<img
						src="${pageContext.request.contextPath}/user/FollowerProfileImage.do?mem_num=${follow.mem_num}"
						class="my-photo">
					<div class="text-content">
						<strong class="text-small">&nbsp;&nbsp;${follow.mem_id}</strong><span
							class="text-small transparent-bg">님이 회원님을 팔로우하기 시작했습니다.</span>

					</div>

				</div>
			</c:forEach>
		</div>
	</div> 


	<script type="text/javascript">
		document.getElementById("transactionTabButton").addEventListener(
				"click",
				function() {
					document.getElementById("transactionContent").classList
							.add("active");
					document.getElementById("styleContent").classList
							.remove("active");
					document.getElementById("transactionTabButton").classList
							.add("active");
					document.getElementById("styleTabButton").classList
							.remove("active");

					// 스타일 탭 버튼과 내용의 액티브 클래스 제거
					likeTabButton.classList.remove("active");
					commentTabButton.classList.remove("active");
					followTabButton.classList.remove("active");
					likeTab.classList.remove("active");
					commentTab.classList.remove("active");
					followTab.classList.remove("active");
				});

		document.getElementById("styleTabButton").addEventListener(
				"click",
				function() {
					// 쇼핑 탭 버튼과 내용의 액티브 클래스 제거
					document.getElementById("transactionContent").classList
							.remove("active");
					document.getElementById("styleContent").classList
							.add("active");
					document.getElementById("transactionTabButton").classList
							.remove("active");
					document.getElementById("styleTabButton").classList
							.add("active");

					// 좋아요 탭 버튼과 내용의 액티브 클래스 추가
					likeTabButton.classList.add("active");
					commentTabButton.classList.remove("active");
					followTabButton.classList.remove("active");
					likeTab.classList.add("active");
					commentTab.classList.remove("active");
					followTab.classList.remove("active");
				});

		// 초기 로딩 시 좋아요 탭을 기본으로 활성화
		document.querySelector(".like-tab-button").click();

		const likeTabButton = document.querySelector(".like-tab-button");
		const commentTabButton = document.querySelector(".comment-tab-button");
		const followTabButton = document.querySelector(".follow-tab-button");
		const likeTab = document.querySelector(".like-tab");
		const commentTab = document.querySelector(".comment-tab");
		const followTab = document.querySelector(".follow-tab");

		likeTabButton.addEventListener("click", function() {
			likeTab.classList.add("active");
			commentTab.classList.remove("active");
			followTab.classList.remove("active");
			likeTabButton.classList.add("active");
			commentTabButton.classList.remove("active");
			followTabButton.classList.remove("active");
		});

		commentTabButton.addEventListener("click", function() {
			likeTab.classList.remove("active");
			commentTab.classList.add("active");
			followTab.classList.remove("active");
			likeTabButton.classList.remove("active");
			commentTabButton.classList.add("active");
			followTabButton.classList.remove("active");
		});

		followTabButton.addEventListener("click", function() {
			likeTab.classList.remove("active");
			commentTab.classList.remove("active");
			followTab.classList.add("active");
			likeTabButton.classList.remove("active");
			commentTabButton.classList.remove("active");
			followTabButton.classList.add("active");
		});

		document.addEventListener("DOMContentLoaded", function() {
			// 쇼핑 탭 내용을 보이도록 설정
			document.getElementById("transactionContent").classList
					.add("active");
			document.getElementById("transactionTabButton").classList
					.add("active");
		});
	</script>


</body>
</html>
