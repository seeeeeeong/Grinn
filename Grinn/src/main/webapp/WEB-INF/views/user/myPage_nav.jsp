<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/profile.js"></script>
<div class = "page_nav">
	<div class="side-bar">
	<h3>마이 페이지</h3>
		<ul>
			<li>
				<img src="${pageContext.request.contextPath}/user/photoView.do" width="200" height="200" class="my-photo">
				<div class="camera" id="photo_btn">
					<img src="${pageContext.request.contextPath}/images/camera.png" width="35">
				</div>
			</li>
			<li>
				<div id="photo_choice" style="display:none;">
					<input type="file" id="upload" accept="image/gif,image/png,image/jpeg"><br>
					<input type="button" value="전송" id="photo_submit">
					<input type="button" value="취소" id="photo_reset">    
				</div>
			</li>
		</ul>
		<ul>
			<li>
				<h4>쇼핑 정보</h4>
				<ul>
					<li>
						<a href = "${pageContext.request.contextPath}/user/buying.do">구매 내역</a>
					</li>
					<li>
						<a href = "${pageContext.request.contextPath}/user/selling.do">판매 내역</a>
					</li>
					<li>
						<a href = "${pageContext.request.contextPath}/user/userFavoriteItems.do">관심 상품</a>
					</li>
					<li>
						<a href = "${pageContext.request.contextPath}/user/userLikedStyles.do">좋아요</a>
					</li>
				</ul>
			</li>
			<li>
				<h4>내 정보</h4>
				<ul>
					<li>
						<a href = "${pageContext.request.contextPath}/user/userLoginInfo.do">로그인 정보</a>
					</li>
					<li>
						<a href = "${pageContext.request.contextPath}/user/userLoginInfo.do">프로필 관리</a>
					</li>
					<li>
						<a href = "${pageContext.request.contextPath}/user/userLoginInfo.do">주소록</a>
					</li>
					<li>
						<a href = "${pageContext.request.contextPath}/user/userPenaltyInfo.do">패널티</a>
					</li>
					<li>
						<a href = "${pageContext.request.contextPath}/user/userLoginInfo.do">포인트</a>
					</li>
				</ul>
			</li>
		</ul>
	</div>
</div>





