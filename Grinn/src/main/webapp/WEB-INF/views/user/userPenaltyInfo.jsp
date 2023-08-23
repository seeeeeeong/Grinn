<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.bordered-heading {
	border-bottom: 2px solid #000;
	padding-bottom: 20px;
}

.user-info-container {
	display: flex;
	align-items: center;
	border: 1px solid rgba(34, 34, 34, 0.3);
	padding: 20px;
	margin: 20px 0 30px 0;
	border-radius: 5px;
}

.user-info-content {
	display: flex;
	align-items: center;
	gap: 16px;
}
.user-info-details {
	display: flex;
	flex-direction: column;
	gap: 8px;
}
.user-info-details2 {
	display: flex;
	flex-direction: column;
	margin-left:400px;
}

.user-info-names {
	font-size: 16px;
	line-height: 1.5;
}

.user-info-names strong {
	font-size: 20px;
	font-weight: bold;
}

.user-info-names span {
	font-size: 16px;
	opacity: 0.5;
}
.user-info-auth {
	width:120px;
	float:left;
	font-size: 16px;
	line-height: 1.5;
	text-align:center;
	margin:0 20px;
}
.user-info-auth strong {
	font-size: 20px;
	font-weight: bold;
}

.user-info-auth span {
	font-size: 12px;
	text-align: center;
	opacity: 0.5;
}

.user-info-penalty {
	float:right;
	font-size: 16px;
	line-height: 1.5;
	text-align:center;
	margin:0 20px;
}
.user-info-penalty strong {
	font-size: 20px;
	font-weight: bold;
}

.user-info-penalty span {
	font-size: 12px;
	opacity: 0.5;
}
.penalty-detail{
	color:rgba(34, 34, 34, 0.3);
	font-weight:700;
	border-top: 1px solid rgba(34, 34, 34, 0.3);
	border-bottom: 1px solid rgba(34, 34, 34, 0.3);
    padding: 5px 0 5px 0;
}

.section-border {
	border-bottom: 0.5px solid rgba(0, 0, 0, 0.3);
	width: 50%;
}

.button {
	background-color: white;
	color: black;
	border: 1px solid rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	padding: 5px 10px;
	cursor: pointer;
}

.button-container {
	display: flex;
	align-items: center;
	justify-content: space-between;
}
.int-input-container {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.int-input {
	border: none;
	border-bottom: 1px solid rgba(0, 0, 0, 0.3);
	border-radius: 0;
	padding: 5px 0;
	margin-top: 25px;
}
.penalty-list{
	margin-bottom: 15px;
}
.no-penalty{
	margin-top: 40px;
	font-size:12px;
	opacity: 0.3;
}
.penalty-table{
	margin: 0 auto;
	width: 100%; 
	text-align:center;
}
th{
	border-bottom: 1px solid #ebebeb;
	padding:10px;
}

</style>
<!-- 페널티 시작 -->
<div class="page-main">
	<h2 class="bordered-heading" style="font-size: 24px;">페널티</h2>
	<br>
	<div class="user-info-container">
		<div class="user-info-content">
			<div class="user-info-details">
				<div class="user-info-names">
					<strong>${member.mem_id}</strong><br> <span>${member.mem_email}</span>
				</div>
			</div>
			<div class="user-info-details2">
				<div>
					<div class="user-info-auth">
						<strong>
						<c:if test="${member.mem_auth == 0}">탈퇴 회원</c:if>
						<c:if test="${member.mem_auth == 1}">정지 회원</c:if>
						<c:if test="${member.mem_auth == 2}">일반 회원</c:if>
						</strong>
						<br> 
						<span>회원등급</span>
					</div>
					<div class="user-info-penalty">
						<strong>${pe_total}점</strong><br> <span>페널티 합계</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="penalty-detail">상세 내역</div>
<div class="penalty-list">
	<c:if test="${empty penaltyList}">
		<div class="align-center">
			<div class="no-penalty">
				부과된 페널티가 없습니다.<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
			</div>
		</div>
	</c:if>
</div>

<div>
	<c:if test="${!empty penaltyList}">
	<table class="penalty-table">
		<thead>
			<tr>
				<th width="20%">페널티 번호</th>
				<th width="20%">점수</th>
				<th width="30%">사유</th>
				<th width="30%">부과일</th>
			</tr>
		</thead>
		<tbody> 
			<c:forEach items="${penaltyList}" var="penalty">
				<tr>
					<td>${penalty.pe_num}</td>
					<td>${penalty.pe_score}</td>
					<td>
						<c:if test="${penalty.pe_type == 7}">가품 판정</c:if>
						<c:if test="${penalty.pe_type == 8}">손상/오염</c:if>
						<c:if test="${penalty.pe_type == 9}">발송 지연</c:if>
					</td>
					<td>${penalty.pe_date}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</c:if>
</div>
<!-- 페널티 끝 -->
