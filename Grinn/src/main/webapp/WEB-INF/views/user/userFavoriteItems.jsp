<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.bordered-heading {
  border-bottom: 2px solid #000; 
  padding-bottom: 20px; 
}
.bordered-item {
  border-style: solid;
  border-width: 0 0 1px 0;
  border-color: rgba(0, 0, 0, 0.3);
  padding: 10px;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.item-section {
  display: flex;
  align-items: center;
}

.item-section img {
  margin-right: 20px;
}

.item-detail {
  text-align: right;
}

.item-detail2 {
  display: flex;
  align-items: center;
  justify-content: space-between;
  background-color: rgb(239, 98, 83); 
  padding: 5px 10px; 
  color: white; 
  font-weight: bold;
  border-radius: 6px;
  margin-right: 10px;
  padding: 20px 15px; /* 내부 간격 조정 */
}

.purchase {
  border-right: 1px solid white;
  padding-right: 15px;
  font-weight: bold;
  margin-right: 10px;
}

.item-price {
  font-weight: bold;
  margin-left: auto;
  align-self: flex-end;
}
.favoirte-items {
  margin-bottom: 30px; 
}

.align-center {
  margin-top: 30px;
  margin-bottom: 200px;  
}

.text-center {
	text-align: center;
}

.no-favorite-items {
    margin-top: 20px; /* 위쪽 간격 조절 */
    font-size: 12px;
    opacity: 0.3;
}
</style>
<!-- 관심상품 시작 -->
<div class="page-main">

    <h2 class="bordered-heading">관심 상품</h2>

	
<div class="favoirte-items">
	<c:choose>
    <c:when test="${empty favoriteItems}">
      <div class="text-center">
      <div class="no-favorite-items">관심 상품이 없습니다.<br><br><br><br><br><br><br><br></div>
      </div>
    </c:when>
    <c:otherwise>
  <c:forEach items="${favoriteItems}" var="item">
    <div class="favorite-item bordered-item">
       <a href="/item/itemDetail.do?item_num=${item.item_num}">
      <div class="item-section">
        <img src="/user/itemImageView.do?item_num=${item.item_num}" alt="Item Image" style="width: 100px; height: 100px;">
      	<div class="item-detail1">
      	<p><strong>${item.item_brand}</strong></p>
        ${item.item_name}
        </div>
      </div>
      </a>
      <a href="/purchase/selectSize.do?item_num=${item.item_num}">
      <div class="item-detail2">
      	<div class="purchase">구매</div>
  		<div class="item-price"><fmt:formatNumber value="${item.item_price}" pattern="#,##0원" /></div>
      </div>
      </a>
    </div>
  </c:forEach>
  </c:otherwise>
  </c:choose>
</div>

<!-- 관심상품 끝 -->

<div class="align-center">${page}</div>
</div>

