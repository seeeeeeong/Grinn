<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 예약 목록 - 사용자 시작 -->
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<h2>예약 목록</h2>
	<form action="bookList.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>예약번호</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" 
				   onclick="location.href='bookList.do'">
			</li>
		</ul>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 예약 목록이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>예약 번호</th>
			<th>플리마켓명</th>
			<th>예약 날짜</th>
			<th>희망 시작</th>
			<th>희망 종료일</th>
			<th>상세</th>
		</tr>
		<c:forEach var="book" items="${userList}">
		<tr>
			<td>${book.book_num}</td>
			<td>${book.marketVO.market_title}</td>
			<td>${book.book_regDate}</td>
			<td>${book.book_date1}</td>
			<td>${book.book_date2}</td>
			<td class="align-center">
				<input type="button" value="상세보기" onclick="location.href='bookDetail.do?book_num=${book.book_num}'" class="detail-btn">
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>	
</div>
<!-- 예약 목록 - 사용자 끝 -->