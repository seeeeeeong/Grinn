<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 부스 리스트 목록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/market.css">
<script type="text/javascript">
	$(function(){
		// 검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim() == ''){
				alert('검색어를 입력하세요');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<h2>플리마켓 목록(관리자)</h2>
	<!-- 검색창 시작 -->
	<form action="adminBoothList.do" id="search_form" method="get">
		<div class="itemListTop">
		<div class="search">
			<div>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목+내용</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>제목</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
				</select>
			</div>
			<div class="itemSearch">
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</div>
			<div>
				<input type="image" src="../images/item_search.png" name="submit"> 
			</div>
		</div>
		</div>
	</form>
	<!-- 검색창 끝 -->
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>장소</th>
			<th>진행</th>
			<th>권한</th>
		</tr>
		<c:forEach var="adminBooth" items="${boothList}">
		<tr>
			<td class="align-center">${adminBooth.market_num}</td>
			<td width="300">${adminBooth.market_title}</td>
			<td class="align-center">${adminBooth.market_startDate}</td>
			<td class="align-center">${adminBooth.market_endDate}</td>			
			<td class="align-center">${adminBooth.place_name}</td>
			<td class="align-center">
				<c:if test="${adminBooth.market_type == 1}">예정</c:if>
				<c:if test="${adminBooth.market_type == 2}">예약</c:if>
				<c:if test="${adminBooth.market_type == 3}">종료</c:if>
			</td>
			<td class="align-center">
				<input type="button" value="수정" onclick="location.href='updateBooth.do?market_num=${adminBooth.market_num}'" class="admin-btn">
				<input type="button" value="삭제" class="admin-btn">
				<script type="text/javascript">
					let delete_btn = document.getElementById('delete_btn');
					delete_btn.onclick=function(){
						let choice = confirm('삭제하시겠습니까?');
						if (choice){
							location.replace('deleteBooth.do?market_num=${adminBooth.market_num}');
						}
					};
				</script>
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
	<div class="align-right">
		<input type="button" value="부스 등록" onclick="location.href='adminBoothWrite.do'" class="register-btn">
	</div>
</div>
<!-- 부스 리스트 목록 끝 -->