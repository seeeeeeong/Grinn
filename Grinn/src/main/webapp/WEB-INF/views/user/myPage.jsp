<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 회원정보 시작 -->
<div class="page-main">
    <img src="${pageContext.request.contextPath}/member/photoView.do" width="200" height="200" class="my-photo">
    <p>닉네임: ${mem_nickname}</p>
    <p>이메일: ${mem_email}</p>
    <p>권한: ${mem_auth}</p>
    <p>포인트: ${mem_point}</p>
<!-- 프로필 관리 버튼 -->
    <input type="button" class="menu-btn" value="프로필 관리"
           onclick="location.href='${pageContext.request.contextPath}/user/loginInfo.do'">
    <!-- 내 스타일 버튼 -->
    <input type="button" class="menu-btn" value="내 스타일"
           onclick="location.href='${pageContext.request.contextPath}/user/userStyle.do'">
<!-- 회원정보 끝 -->

<!-- 구매내역 시작 -->
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
    <c:forEach items="${purchasedItems}" var="item">
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
<!-- 구매내역 끝 -->

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
<!-- 판매내역 끝 -->

<!-- 관심상품 시작 -->
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
<!-- 관심상품 끝 -->
</div>