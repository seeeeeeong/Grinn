<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 구매내역 시작 -->
<div class="page-main">
<h2>구매 내역</h2>
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
      <tr>
      <c:forEach items="${purchasedItems}" var="pitem">
        <td><img src="${pitem.item_photo1}" width="50" height="50"></td>
        <td>${item.item_name}</td>
      </c:forEach>
      <c:forEach items="${purchasedItemSize}" var="pitemSize">  
        <td>${pitemSize.item_size}</td>
      </c:forEach>
      <c:forEach items="${purchasedTrades}" var="ptrades">  
        <td>${ptrades.trade_regDate}</td>
        <td>${ptrades.trade_state}</td>
      </c:forEach>  
      </tr>
  </tbody>
</table>
</div>
<!-- 구매내역 끝 -->