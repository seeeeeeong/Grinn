<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 회원별 페널티 목록 시작 -->
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
	<h2>페널티 목록 - 관리자</h2>
	<!-- 검색창 시작 -->
	<form action="penalty.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>ID</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='penalty.do'">
			</li>
		</ul>
	</form>
	<!-- 검색창 끝 -->
	<div>
		<div>
			<p>페널티 합계</p>
			<span>${penalty_sum}</span>
		</div>
		<div>
			<p>회원 등급</p>
			<span>${member.mem_auth}</span>
		</div>
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 페널티 목록이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>페널티 번호</th>
			<th>유형</th>
			<th>페널티</th>
			<th>부여일</th>
			<th>권한</th>
		</tr>
		<c:forEach var="pe" items="${penaltyList}">
		<tr>
			<td class="align-center">${pe.pro_num}</td>
			<td class="align-center">${pe.pe_service_type}</td>
			<td class="align-center">${pe.pe_score}</td>
			<td class="align-center">${pe.pe_date}</td>			
			<td class="align-center">
				<input type="button" value="상세보기" onclick="location.href='detailPenalty.do?pe_num=${pe.pe_num}'" class="detail-btn">
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 회원별 페널티 목록 끝 -->