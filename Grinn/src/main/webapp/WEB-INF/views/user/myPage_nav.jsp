<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- MY페이지 메뉴 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/profile.js"></script>
<div class="side-bar">
	<ul>
		<li>
			<img src="${pageContext.request.contextPath}/user/photoView.do" width="200" height="200" class="my-photo">
			<div class="camera" id="photo_btn">
				<img src="${pageContext.request.contextPath}/images/camera.png" width="35">
			</div>
		</li>
		<li>
			<div id="photo_choice" style="display:none;">
				<input type="file" id="upload" 
				    accept="image/gif,image/png,image/jpeg"><br>
				<input type="button" value="전송" id="photo_submit">
				<input type="button" value="취소" id="photo_reset">    
			</div>
		</li>
	</ul>
	<ul>
		<li>
			<input type="button" class="menu-btn" value="구매내역"
			  onclick="location.href='${pageContext.request.contextPath}/user/userPurchasedItems.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="판매내역"
			  onclick="location.href='${pageContext.request.contextPath}/user/userSoldItems.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="관심상품"
			  onclick="location.href='${pageContext.request.contextPath}/user/userFavoriteItems.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="좋아요"
			  onclick="location.href='${pageContext.request.contextPath}/user/userLikedStyles.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="로그인정보"
			  onclick="location.href='${pageContext.request.contextPath}/user/userLoginInfo.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="패널티"
			  onclick="location.href='${pageContext.request.contextPath}/user/userPenaltyInfo.do'">
		</li>
	</ul>
</div>
<!-- MY페이지 메뉴 끝 -->





