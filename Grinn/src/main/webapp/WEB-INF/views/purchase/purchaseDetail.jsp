<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="page-main">
	<h1>구매 하기</h1>	
	<div>
		아이템 정보가 들어가는 곳
	</div>
	
	<hr size="1" width="100%" noshade>
	
	<div class="align-center">
		<div>
			<p>즉시 구매가</p>
			<p>${minSaleBid}</p>
		</div>
		<div>
			<p>즉시 판매가</p>
			<p>${maxPurchaseBid}</p>
		</div>
		
		<hr size="1" width="100%" noshade>	
		
		<div>
			<input type="button" value="구매 입찰" id="purchase_bid">
			<input type="button" value="즉시 구매" id="purchase_direct">
		</div>
	</div>
	
	
	
	
</div>