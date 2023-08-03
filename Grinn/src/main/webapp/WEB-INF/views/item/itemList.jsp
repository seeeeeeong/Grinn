<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 상품 목록 시작 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/item.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/itemWrite.js"></script>
<script type="text/javascript">
	$(function() {
		//검색 유효성 체크
		$('#search_form').submit(function() {
			if ($('#keyword').val().trim() == '') {
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>

<div class="page-main">
	<h2>상품 목록</h2>
	<form action="itemList.do" id="search_form" method="get">
		<ul class="search">
			<li><select name="keyfield" id="keyfield">
					<option value="1"
						<c:if test="${param.keyfield == 1}">selected</c:if>>브랜드</option>
					<option value="2"
						<c:if test="${param.keyfield == 2}">selected</c:if>>상품명</option>
			</select></li>
			<li><input type="search" name="keyword" id="keyword"
				value="${param.keyword}"></li>
			<li><input type="submit" value="찾기"> <input
				type="button" value="목록" onclick="location.href='itemList.do'">
			</li>
		</ul>
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>관심상품순</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>리뷰순</option>
			</select>
			<script type="text/javascript">
				$(function() {
					$('#order').change(
							function() {
								location.href = 'itemList.do?keyfield='
										+ $('#keyfield').val() + '&keyword='
										+ $('#keyword').val() + '&order='
										+ $('#order').val();
							});
				});
			</script>
			<input type="button" value="상품등록" onclick="location.href='write.do'">
		</div>
	</form>
	<c:if test="${count == 0}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<div class="list01">
			<c:forEach var="item" items="${list}">
				<div class="list02">
					<a href="detail.do?item_num=${item.item_num}"> 	
						<img src="${pageContext.request.contextPath}/item/photoView.do?item_num=${item.item_num}">
							<div class="list03">
								<p class="listBrand">${item.item_brand}</p>
								<div>
									<p class="itemName">${item.item_name}</p>
									<p class="itemDetail">${item.item_detail}</p>
								</div>
							</div>
							<div>
							<!-- 즉시구매가 넣는곳 -->
								<p>7000원</p>
							</div>
						</a>
						<div>
						<!-- 상품보관버튼 -->
						<span class="wishReview"> 
							<img class="output_fav" data-num="${item.item_num}"
								src="${pageContext.request.contextPath}/images/save_blank.png" width="15" height="15"> 
								<span class="output_fcount"  data-num="${item.item_num}"></span>
						</span> 
						<span class="wishReview"> 
							<img src="${pageContext.request.contextPath}/images/review.png"
								width="15" height="15"> <span>${item.re_cnt}</span>
						</span>
					</div>
					</div>
				</c:forEach>
			</div>
		<%-- <table class="striped-table">
			<tr>
				<td>사진</td>
				<td>제품명</td>
				<td>제품상세</td>
				<td>가격</td>
				<td>좋아요수</td>
				<td>댓글수</td>
			</tr>
			<c:forEach var="item" items="${list}">
				<tr>
					<td>
						<img src="${pageContext.request.contextPath}/item/photoView.do?item_num=${item.item_num}" width="200" height="200">
					</td>
					<td width="400">
						<a href="detail.do?item_num=${item.item_num}">${item.item_name}</a>
					</td>
					<td class="align-center">${item.item_detail}</td>
					<td class="align-center">${item.item_price}</td>
					<td class="align-center">${item.fav_cnt}</td>
					<td class="align-center">${item.re_cnt}</td>
				</tr>
			</c:forEach>
		</table> --%>
		<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 상품 목록 끝 -->