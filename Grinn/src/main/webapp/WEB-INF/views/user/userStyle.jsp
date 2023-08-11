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
    <script type="text/javascript">
    function followUser(toUser) {
        
    	// AJAX 요청 보내기
        $.ajax({
            url: '/user/follow',
            method: 'POST',
            data: { to_user: toUser }, // toUser 값을 데이터로 전달합니다.
            success: function (data) {
                // 요청이 성공적으로 완료되었을 때 처리
                if (data === 'follow') {
                    alert('팔로우 성공!');
                } else if (data === 'unfollow') {
                    alert('팔로우 취소!');
                } else {
                    alert('알 수 없는 응답입니다.');
                }
                // 추가적인 처리를 수행하거나 화면을 갱신할 수 있습니다.
            },
            error: function () {
                // 요청이 실패했을 때 처리
                alert('팔로우 실패...');
            }
        });
    }
    </script>
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
 	
 	<c:choose>
    <c:when test="${isOwnProfile}">
        <!-- "Profile Management(프로필 관리)" 버튼 표시 -->
        <a href="/user/userLoginInfo.do">프로필 관리</a>
    </c:when>
    <c:otherwise>
        <button onclick="followUser(${member.mem_num})">팔로우</button>
    </c:otherwise>
	</c:choose>
 	  
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