<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.page_nav a {
	color: rgba(34, 34, 34, 0.5);
}

.selected-link {
	color: #222222 !important;
	font-weight: bold !important;
}
</style>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		var links = document.querySelectorAll('.page_nav a');
		var currentURL = window.location.href;

		links.forEach(function(link) {
			if (currentURL === link.href) {
				link.classList.add('selected-link');
			}

			link.addEventListener('click', function() {
				links.forEach(function(otherLink) {
					otherLink.classList.remove('selected-link');
				});
				this.classList.add('selected-link');
			});
		});
	});
</script>
<div class="page_nav">
	<div class="side-bar">
		<h3>마이 페이지</h3>
		<ul>
			<li>
				<h4>쇼핑 정보</h4>
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/user/buying.do"
						onclick="applyStyleToLink(this);">구매 내역</a></li>
					<li><a
						href="${pageContext.request.contextPath}/user/selling.do"
						onclick="applyStyleToLink(this);">판매 내역</a></li>
					<li><a
						href="${pageContext.request.contextPath}/user/userFavoriteItems.do"
						onclick="applyStyleToLink(this);">관심 상품</a></li>
					<li><a
						href="${pageContext.request.contextPath}/user/userLikedStyles.do"
						onclick="applyStyleToLink(this);">좋아요</a></li>
				</ul>
			</li>
			<li>
				<h4>내 정보</h4>
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/user/userLoginInfo.do"
						onclick="applyStyleToLink(this);">로그인 정보</a></li>
					<li><a
						href="${pageContext.request.contextPath}/user/userProfileInfo.do"
						onclick="applyStyleToLink(this);">프로필 관리</a></li>
					<li><a
						href="${pageContext.request.contextPath}/user/userAddressBook.do"
						onclick="applyStyleToLink(this);">주소록</a></li>
					<li><a
						href="${pageContext.request.contextPath}/user/userPenaltyInfo.do"
						onclick="applyStyleToLink(this);">패널티</a></li>
					<li><a
						href="${pageContext.request.contextPath}/user/userPointInfo.do"
						onclick="applyStyleToLink(this);">포인트</a></li>
				</ul>
			</li>
		</ul>
	</div>
</div>
