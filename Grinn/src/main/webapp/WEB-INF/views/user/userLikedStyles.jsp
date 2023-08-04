<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 좋아요 시작 -->
<h2>좋아요</h2>
<table>
  <thead>
    <tr>
      <th>게시물 사진</th>
      <th>작성자 프로필 사진</th>
      <th>작성자 닉네임</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${likedStyles}" var="post">
      <tr>
        <td><img src="data:image/jpeg;base64,${likedStyle.st_photo1Base64}" width="100px" height="100px" /></td>
        <td><img src="${post.mem_photo}" width="50" height="50"></td>
        <td>${post.mem_nickname}</td>
      </tr>
    </c:forEach>
  </tbody>
</table>
<!-- 좋아요 끝 -->
