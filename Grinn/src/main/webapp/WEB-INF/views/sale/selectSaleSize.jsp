<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssk/selectSize.css">
<h1 class="align-center">판매 하기</h1>
<div class="page-size-main">
	<div class="page-size">
		<div class="page-size-inner">
			<div class="item">
				<div class="item-profile">
					<img src="${pageContext.request.contextPath}/item/viewProfile.do?item_num=${item.item_num}" width="100" height="100">
				</div>
				<div class="item-info">
					<p class="a">${item.item_brand}</p>
					<p class="b">${item.item_name}</p>
					<p class="c">${item.item_detail}</p>
				</div>
			</div>
			<div class="size-select">
				<ul class="select-list">
					<c:forEach var="list" items="${list}">
					<li class="select-size">
						<c:if test="${empty list.item_size}">
							<script type="text/javascript">
								$(function(){
									$('.select-size').css('width','100%');
								});
							</script>
						</c:if>
						<button onclick="location.href='checkSale.do?item_num=${list.item_num}&item_sizenum=${list.item_sizenum}&item_size=${list.item_size}'">
							<div class="select-inner">
								<span class="size">
									<c:if test="${empty list.item_size}">
										ONE SIZE
									</c:if>
									<c:if test="${!empty list.item_size}">
										${list.item_size}
									</c:if>
								</span>
								<span class="price" <c:if test="${list.purchase_price != 0}">style="color:#41B979;"</c:if>>
									<c:if test="${list.purchase_price == 0}">
										판매입찰
									</c:if>
									<c:if test="${list.purchase_price != 0}">
										<fmt:formatNumber value="${list.purchase_price}"/>원
									</c:if>
								</span>
							</div>
						</button>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</div>