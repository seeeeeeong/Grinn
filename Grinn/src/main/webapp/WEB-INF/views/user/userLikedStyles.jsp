<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 좋아요 시작 -->
<h2>좋아요</h2>


    <c:forEach items="${likedStyles}" var="post">

    <img src="/user/StyleImageView.do?st_num=${post.st_num}" width="200" height="200" alt="Item Image">
    <img src="${pageContext.request.contextPath}/user/photoView.do?mem_num=${post.mem_num}" width="200" height="200" class="my-photo">
	${memId[0]}
    </c:forEach>

<!-- 좋아요 끝 -->
