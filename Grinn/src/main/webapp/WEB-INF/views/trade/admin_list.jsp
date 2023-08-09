<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssk/admin_list.css">
<script type="text/javascript">
	$(function(){
		let id = 'ch'+${status};
		$('#'+id).css('color','#222');
		initCategory()
		$('.category-title').each(function(index,item){
			$(this).click(function(){
				location.href='${pageContext.request.contextPath}/trade/admin_list.do?status='+(index+1);
			});
		});
		
		function initCategory(){
			for(i=1;i<=6;i++){
				$('ch'+i).css('color','rgba(34,34,34,.5)');
			}
		}
	});
</script>
<div class="page_body">
	<div class="page-main">
		<h2 id="ha">거래 목록</h2>
		<div class="categories">
			<div class="category-list">
				<table class="category-list-items">
					<tr class="category-row">
						<th class="category-title" id="ch1">
							<span class="category-text">전체</span>
						</th>
						<th class="category-title" id="ch2">
							<span class="category-text">검수준비중</span>
						</th>
						<th class="category-title" id="ch3">
							<span class="category-text">검수중</span>
						</th>
						<th class="category-title" id="ch4">
							<span class="category-text">배송중</span>
						</th>
						<th class="category-title" id="ch5">
							<span class="category-text">배송완료</span>
						</th>
						<th class="category-title" id="ch6">
							<span class="category-text">거래실패</span>
						</th>
					</tr>
				</table>
			</div>
		</div>
		<div class="trade-notice">
			<span>거래가는 수수료와 배송비가 포함되어있는 가격입니다.</span>
		</div>
		<div class="trade-content">
			<div class="trade-content-detail">
				<div class="real-content">
					<table>
						<tr>
							<th width="300">상품</th>
							<th>사이즈</th>
							<th>거래가</th>
							<th>구매자</th>
							<th>구매자등급</th>
							<th>판매자</th>
							<th>판매자등급</th>
							<th>등록일</th>
							<th>거래상태</th>
						</tr>
					<c:forEach var="list" items="${list}">
						<tr>
							<td>${list.item_name}</td>
							<td>${list.item_size}</td>
							<td><fmt:formatNumber value="${list.trade_price}"/></td>
							<td>${list.buyerVO.mem_name}</td>
							<c:if test="${list.buyerVO.mem_auth == 0}">
								<td>탈퇴</td>
							</c:if>
							<c:if test="${list.buyerVO.mem_auth == 1}">
								<td>정지</td>
							</c:if>
							<c:if test="${list.buyerVO.mem_auth == 2}">
								<td>일반</td>
							</c:if>
							<c:if test="${list.buyerVO.mem_auth == 9}">
								<td>관리</td>
							</c:if>
							<td>${list.sellerVO.mem_name}</td>
							<c:if test="${list.sellerVO.mem_auth == 0}">
								<td>탈퇴</td>
							</c:if>
							<c:if test="${list.sellerVO.mem_auth == 1}">
								<td>정지</td>
							</c:if>
							<c:if test="${list.sellerVO.mem_auth == 2}">
								<td>일반</td>
							</c:if>
							<c:if test="${list.sellerVO.mem_auth == 9}">
								<td>관리</td>
							</c:if>
							<td>${list.trade_regDate}</td>
							<c:if test="${list.trade_state == 2}">
								<td>검수준비중</td>
							</c:if>
							<c:if test="${list.trade_state == 3}">
								<td>검수중</td>
							</c:if>
							<c:if test="${list.trade_state == 4}">
								<td>배송중</td>
							</c:if>
							<c:if test="${list.trade_state == 5}">
								<td>배송완료</td>
							</c:if>
							<c:if test="${list.trade_state == 6}">
								<td>거래실패</td>
							</c:if>
						</tr>				
					</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>











