<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 상품 목록 시작 -->
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<h2>상품 목록(관리자)</h2>
	<form action="itemAdminList.do" id="search_form" method="get">
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
				type="button" value="목록" onclick="location.href='itemAdminList.do'">
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
								location.href = 'itemAdminList.do?keyfield='
										+ $('#keyfield').val() + '&keyword='
										+ $('#keyword').val() + '&order='
										+ $('#order').val();
							});
				});
			</script>
			<c:if test="${!empty user}">
				<input type="button" value="상품등록" onclick="location.href='write.do'">
			</c:if>
		</div>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<table class="striped-table">
			<tr class="align-center">
				<td>제품번호</td>
				<td></td>
				<td>브랜드</td>
				<td>제품명</td>
				<td>최근 거래가</td>
				<td>최근 거래일</td>
				<td>수정</td>
			</tr>
			<c:forEach var="item" items="${list}">
				<tr class="align-center">
					<td>${item.item_num}</td>
					<td>
						<img src="${pageContext.request.contextPath}/item/photoView.do?item_num=${item.item_num}" width="100" height="100">
					</td>
					<td>${item.item_brand}</td>
					<td>${item.item_name}</td>
					<td></td>
					<td></td>
					<td>
						<a href="#">수정</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 상품 목록 끝 -->