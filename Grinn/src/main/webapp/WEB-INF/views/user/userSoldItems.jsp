<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 판매내역 시작 -->
<div class="page-main">
<h2>판매 내역</h2>
<table>
  <thead>
    <tr>
      <th>상품 사진</th>
      <th>상품 이름</th>
      <th>상품 사이즈</th>
      <th>거래 등록일</th>
      <th>거래 상태</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${soldItems}" var="item">
      <tr>
        <td><img src="${item.item_photo1}" width="50" height="50"></td>
        <td>${item.item_name}</td>
        <td>${item.item_size}</td>
        <td>${item.trade_regdate}</td>
        <td>${item.trade_state}</td>
      </tr>
    </c:forEach>
  </tbody>
</table>
</div>
<!-- 판매내역 끝 -->