<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="page-main">
<!-- 회원정보 시작 -->
    <img src="${pageContext.request.contextPath}/user/photoView.do" width="200" height="200" class="my-photo">
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
            <!-- st_phrase 표시 -->
            <p>${style.st_phrase}</p>
        </div>
    </c:forEach>
	<!-- 사용자가 작성한 스타일 게시물 정보 끝 -->
</div>