<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="page-main">
<!-- 판매내역 시작 -->
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
       <tr>
      <c:forEach items="${SoldItems}" var="sitems">
        <td><img src="${sitems.item_photo1}" width="50" height="50"></td>
        <td>${sitems.item_name}</td>
      </c:forEach>
      <c:forEach items="${SoldItemSize}" var="sitemSizes">  
        <td>${sitemSizes.item_size}</td>
      </c:forEach>
      <c:forEach items="${soldTrades}" var="strades">  
        <td>${strades.trade_regDate}</td>
        <td>${strades.trade_state}</td>
      </c:forEach>  
      </tr>
  </tbody>
</table>
<!-- 판매내역 끝 -->
</div>
