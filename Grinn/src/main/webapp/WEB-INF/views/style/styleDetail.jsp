<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 스타일 상세 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <style>
	.swiper-container {
		height: auto;
	}
	
	.swiper-slide {
		text-align: center;
		display: flex; /* 내용을 중앙정렬 하기위해 flex 사용 */
		align-items: center; /* 위아래 기준 중앙정렬 */
		justify-content: center; /* 좌우 기준 중앙정렬 */
	}
	</style>
	<script>
	new Swiper('.swiper-container', {

		slidesPerView : 1, // 동시에 보여줄 슬라이드 갯수
		spaceBetween : 30, // 슬라이드간 간격
		slidesPerGroup : 1, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음

		// 그룹수가 맞지 않을 경우 빈칸으로 메우기
		// 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
		loopFillGroupWithBlank : false,

		loop : true, // 무한 반복

		pagination : { // 페이징
			el : '.swiper-pagination',
			clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
		},
		navigation : { // 네비게이션
			nextEl : '.swiper-button-next', // 다음 버튼 클래스명
			prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
		},
	});
	</script>
<div class="instagram-post">
	<div class="user-profile">
		<img src="profile_picture.png" class="profile-photo">
		<span class="username">${style.mem_id}</span>
    </div>
    <div class="swiper-container">
    	<div class="swiper-wrapper">
	    	<div class="swiper-slide">
	    		<img src="${pageContext.request.contextPath}/image_upload/${style.st_photo1n}" width="600" height="600">
	    	</div>
	    	<div class="swiper-slide">
	    	<c:if test="${!empty style.st_photo2n}">
	    		<img src="${pageContext.request.contextPath}/image_upload/${style.st_photo2n}" width="600" height="600">
	    	</c:if>
	    	</div>
	    	<div class="swiper-slide">
			<c:if test="${!empty style.st_photo3n}">
	    		<img src="${pageContext.request.contextPath}/image_upload/${style.st_photo3n}" width="600" height="600">
	    	</c:if>
	    	</div>
	    	<div class="swiper-slide">
	    	<c:if test="${!empty style.st_photo4n}">
	    		<img src="${pageContext.request.contextPath}/image_upload/${style.st_photo4n}" width="600" height="600">
	    	</c:if>
	    	</div>
    	</div>
    		<!-- 네비게이션 -->
		<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
		<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
		<!-- 페이징 -->
		<div class="swiper-pagination"></div>
	</div>

	<div class="like-button">
		<img src="${pageContext.request.contextPath}/images/black_heart.png" width="40" height="40">
	</div>
    <div class="post-caption">
      <p>${style.st_phrase}</p>
    </div>
    <div class="post-date">
      <span class="posted-date">${style.st_regdate}</span>
      <c:if test="${!empty style.st_mdate}">
        <span class="modified-date">${style.st_mdate}</span>
      </c:if>
    </div>
</div>

<!-- 스타일 상세 -->