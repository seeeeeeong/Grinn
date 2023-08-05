<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="page-main">
<!-- 회원정보 시작 -->
    <img src="${pageContext.request.contextPath}/user/photoView.do" width="200" height="200" class="my-photo">
    <p>닉네임: ${mem_nickname}</p>
    <p>이메일: ${mem_email}</p>
    <p>권한: ${mem_auth}</p>
    <p>포인트: ${mem_point}</p>
<!-- 프로필 관리 버튼 -->
    <input type="button" class="menu-btn" value="프로필 관리"
           onclick="location.href='${pageContext.request.contextPath}/user/userLoginInfo.do'">
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
      <!-- 이미지 표시 -->
        <td><img src="/user/ItemImageView.do?item_num=${item.item_num}" alt="Item Image"></td>
        <td>${item.item_brand}</td>
        <td>${item.item_name}</td>
        <td>${item.item_price}</td>
      </tr>
    </c:forEach>
  </tbody>
</table>
<!-- 관심상품 끝 -->
</div>