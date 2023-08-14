<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 스타일 신고 목록 관리자 시작 -->
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요.');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<style>
	td{
		text-align:center;
	}
</style>
<div class="page-main">
	<h2>스타일 신고 목록</h2>
	<form action="styleReportList.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>신고자 ID</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>피신고자 ID</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="검색">
				<input type="button" value="목록" onclick="location.href='styleReportList.do'">
			</li>
		</ul>
	</form>
	<c:if test="${count == 0}">
		<div class="result-display">표시할 회원 정보가 없어요...</div>
	</c:if>
	<c:if test="${count > 0}">
		<table class="striped-table">
			<tr>
				<th>신고번호</th>
				<th>신고자ID</th>
				<th>피신고자ID</th>
				<th>신고유형</th>
				<th>댓글 공개여부</th>
				<th>신고 접수일</th>
			</tr>
			<c:forEach var="reportCom" items="${list}">
				<tr>
					<td><a href="comReportDetail.do?rcom_num=${reportCom.rcom_num}">${reportCom.rcom_num}</a></td>
					<td>${reportCom.report_id}</td>
					<td>${reportCom.reported_id}</td>
					<td>
						<c:if test="${reportCom.rep_type == 1}">선정적인 댓글</c:if>
						<c:if test="${reportCom.rep_type == 2}">비방성 댓글</c:if>
						<c:if test="${reportCom.rep_type == 3}">영리목적/홍보성</c:if>
						<c:if test="${reportCom.rep_type == 4}">기타</c:if>
					</td>
					<td>
						<c:if test="${reportCom.rep_hide == 0}">미처리</c:if>
						<c:if test="${reportCom.rep_hide == 1}">공개</c:if>
						<c:if test="${reportCom.rep_hide == 2}">비공개</c:if>
					</td>
					<td>${reportCom.rep_regdate}</td>
				</tr>
			</c:forEach>
		</table><br>
		<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 스타일 신고 목록 관리자 끝 -->