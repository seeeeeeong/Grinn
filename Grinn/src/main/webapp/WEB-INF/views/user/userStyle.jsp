<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/style.fav.js"></script>
    <style>
        .like-button{
        	width: 20px;
            height: 20px;
            float:right;
            margin-bottom: 10px;
        }
    </style>
    
<div class="page-main">
	<!-- 회원정보 시작 -->
    <c:choose>
        <c:when test="${not empty userStyles[0].st_num}">
            <img src="/user/StyleProfile.do?st_num=${userStyles[0].st_num}" width="200" height="200" class="my-photo">
        </c:when>
        <c:otherwise>
            <img src="${pageContext.request.contextPath}/user/photoView.do" width="200" height="200" class="my-photo">
        </c:otherwise>
    </c:choose>
    <p>아이디: ${member.mem_id}</p>
    <p>닉네임: ${member.mem_nickname}</p>
    <p>한줄소개글: ${member.mem_int}</p>
       
	<!-- 회원정보 끝 -->
	<p>게시물: ${totalStyleCount}</p>
	<p>팔로워: ${followerCount}</p>
	<p>팔로잉: ${followingCount}</p>

	<!-- 사용자가 작성한 스타일 게시물 정보 시작 -->
    <c:forEach items="${userStyles}" var="style">
        <div>
            <!-- 이미지 표시 -->
            <img src="/user/imageView.do?st_num=${style.st_num}&st_type=1" alt="Style Image">
            <!-- 프로필 이미지 표시 -->
            <img src="/user/StyleProfile.do?st_num=${style.st_num}" width="200" height="200" class="my-photo">
            <!-- 아이디 표시 -->
    		<p>아이디: ${member.mem_id}</p>
    		<!-- 좋아요 버튼 -->	
    		<div class="like-button">
            	<img id="output_fav" data-num="${style.st_num}" src="${pageContext.request.contextPath}/images/no_like.png">
            </div>
            <!-- 좋아요 개수를 표시할 요소 -->

            <!-- st_phrase 표시 -->
            <p>${style.st_phrase}</p>
        </div>
    </c:forEach>
	<!-- 사용자가 작성한 스타일 게시물 정보 끝 -->
</div>