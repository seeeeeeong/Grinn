<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="page-main">
	<h1>판매 하기</h1>	
	<div>
		아이템 정보가 들어가는 곳
	</div>
	
	<div class="align-center">
		<table>
			<c:forEach var="list" items="${list}">
			<tr>
				<td>
					<a href="checkSale.do?item_num=${list.item_num}&item_sizenum=${list.item_sizenum}&item_size=${list.item_size}">${list.item_sizenum}</a>
				</td>
				<c:if test="${empty list.item_size}">
				<td>
					ONE SIZE
				</td>
				</c:if>
				<c:if test="${!empty list.item_size}">
				<td>
					${list.item_size}
				</td>
				</c:if>
				<c:if test="${list.purchase_price == 0}">
				<td>
					정가 : 40,000원
				</td>
				</c:if>
				<c:if test="${list.purchase_price != 0}">
				<td>
					${list.purchase_price}원
				</td>
				</c:if>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>