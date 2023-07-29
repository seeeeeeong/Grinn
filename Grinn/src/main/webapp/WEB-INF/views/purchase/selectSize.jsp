<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="page-main">
	<h1>구매 하기</h1>	
	<div>
		아이템 정보가 들어가는 곳
	</div>
	
	<div class="align-center">
		<table>
			<c:forEach var="list" items="${list}">
			<tr>
				<td>
					<a href="purchase/check.do?item_num=${list.item_num}&item_sizenum=${list.item_sizenum}">${list.item_sizenum}</a>
				</td>
				<td>
					${list.item_size}
				</td>
				<td>
					${list.sale_price}
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>