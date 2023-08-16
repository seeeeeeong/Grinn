<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 후기수정 시작 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/itemWrite.js"></script>
<div class="page-main1">
    <h2>후기 수정</h2>
	<div class="reviewForm">
		<div>
			<ul>
				<li><img
					src="${pageContext.request.contextPath}/item/photoView.do?item_num=${itemVO.item_num}"
					width="200" height="200"></li>
			</ul>
			<ul>
				<li class="a">${itemVO.item_name}</li>
				<li class="b">${itemVO.item_detail}</li>
			</ul>
		</div>
	</div>
	<form:form modelAttribute="itemReviewVO" action="itemReviewModify.do" id="itemReview" method="post" enctype="multipart/form-data">
    	<form:hidden path="review_num"/>
		<fieldset>
			<form:radiobutton path="review_star" value="5" id="rate1" />
			<label for="rate1">★</label>
			<form:radiobutton path="review_star" value="4" id="rate2" />
			<label for="rate2">★</label>
			<form:radiobutton path="review_star" value="3" id="rate3" />
			<label for="rate3">★</label>
			<form:radiobutton path="review_star" value="2" id="rate4" />
			<label for="rate4">★</label>
			<form:radiobutton path="review_star" value="1" id="rate5" />
			<label for="rate5">★</label>
		</fieldset>
		<ul>
			<li><form:textarea id="review_content" path="review_content"
					placeholder="후기를 입력하세요" autocomplete="off" rows="10" cols="105" /><br>
				<form:errors path="review_content" cssClass="error-color"/><br>
				<span class="letter-count">300/300</span></li>
		</ul>
		<!-- 사진 등록 시작 -->
		<div class="bb">
			<div class="aa">
				<ul>
					<li>
						<!-- 이미지를 나타낼 <img> 요소 --> 
						<c:if test="${empty itemReviewVO.review_photo}">
							<img src="${pageContext.request.contextPath}/images/item_add.png"
										width="100" height="100" class="item-photo">
							<input type="file" id="upload" name="upload"
										accept="image/gif,image/png,image/jpeg">
						</c:if> 
						<c:if test="${!empty itemReviewVO.review_photo}">
							<img src="${pageContext.request.contextPath}/item/reviewPhoto.do?review_num=${itemReviewVO.review_num}"
									width="200" height="200" class="item-photo">
							<input type="file" id="upload" name="upload"
										accept="image/gif,image/png,image/jpeg">
						</c:if>
					</li>
				</ul>
			</div>
				<div class="reviewButton">
					<div>
						<input type="submit" value="등록" class="default-btn"> 
						<input type="button" value="홈으로" class="default-btn"
							onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
				</div>
			</div>
		</div>
		<!-- 사진 등록 끝 -->
        
    </form:form>
</div>
<!-- 후기 수정 끝 -->