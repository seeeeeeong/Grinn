<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 프로모션 리스트 목록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/promotion.css">
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
	<h2>프로모션 목록(관리자)</h2>
	<!-- 검색창 시작 -->
	<form action="adminList.do" id="search_form" method="get">
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
	<div class="result-display">표시할 프로모션이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>등록일</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>진행</th>
			<th>공개</th>
			<th>권한</th>
		</tr>
		<c:forEach var="pro" items="${list}">
		<tr>
			<td class="align-center">${pro.pro_num}</td>
			<td class="align-center">
				<a href="detail.do?pro_num=${pro.pro_num}">${pro.pro_name}</a>
			</td>
			<td class="align-center">${pro.pro_regDate}</td>
			<td class="align-center">${pro.pro_openDate}</td>
			<td class="align-center">${pro.pro_cloDate}</td>			
			<td class="align-center">
				<c:if test="${pro.pro_ing == 1}">예정</c:if>
				<c:if test="${pro.pro_ing == 2}">진행</c:if>
				<c:if test="${pro.pro_ing == 3}">종료</c:if>
			</td>
			<td class="align-center">
				<c:if test="${pro.pro_hide == 1}">숨김</c:if>
				<c:if test="${pro.pro_hide == 2}">공개</c:if>
			</td>
			<td class="align-center">
				<input type="button" value="수정" onclick="location.href='updatePromotion.do?pro_num=${pro.pro_num}'" class="detail-btn">
				<input type="button" value="삭제" class="delete-btn">
				<script type="text/javascript">
					let delete_btn = document.getElementById('delete_btn');
					delete_btn.onclick=function(){
						let choice = confirm('삭제하시겠습니까?');
						if (choice){
							location.replace('deletePromotion.do?pro_num=${pro.pro_num}');
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
		<input type="button" value="프로모션 등록" onclick="location.href='adminWrite.do'" class="register-btn">
	</div>
</div>
<!-- 프로모션 리스트 목록 끝 -->