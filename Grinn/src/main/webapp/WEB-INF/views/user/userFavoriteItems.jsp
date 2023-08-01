<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 관심상품 시작 -->
<div class="page-main">
<h2>관심 상품</h2>
<table>
  <thead>
    <tr>
      <th>상품 사진</th>
      <th>상품 브랜드</th>
      <th>상품 이름</th>
      <th>상품 가격</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${favoriteItems}" var="item">
      <tr>
        <td><img src="${item.item_photo1}" width="50" height="50"></td>
        <td>${item.item_brand}</td>
        <td>${item.item_name}</td>
        <td>${item.item_price}</td>
      </tr>
    </c:forEach>
  </tbody>
</table>
</div>
<!-- 관심상품 끝 -->