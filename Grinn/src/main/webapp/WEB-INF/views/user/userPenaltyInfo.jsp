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
<table>
	<thead>
		<tr>
			<th>페널티 번호</th>
			<th>점수</th>
			<th>사유</th>
			<th>부과일</th>
		</tr>
	</thead>
	<tbody>
	<%-- 
		<c:forEach items="${penaltyInfo}" var="penalty">
			<tr>
				<td>${penalty.pe_total}</td>
				<td>${penalty.pe_score}</td>
				<td><c:choose>
						<c:when test="${not empty penalty.peBoard_score}">
							<c:choose>
								<c:when test="${penalty.peBoard_score == 0}">음란, 불법</c:when>
								<c:when test="${penalty.peBoard_score == 1}">홍보</c:when>
								<c:when test="${penalty.peBoard_score == 2}">욕설</c:when>
								<c:when test="${penalty.peBoard_score == 3}">반복</c:when>
								<c:when test="${penalty.peBoard_score == 4}">개인정보노출</c:when>
								<c:otherwise>기타</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${not empty penalty.peTrade_score}">
							<c:choose>
								<c:when test="${penalty.peTrade_score == 5}">가품 판정</c:when>
								<c:when test="${penalty.peTrade_score == 6}">손상/오염</c:when>
								<c:when test="${penalty.peTrade_score == 7}">판매 거부</c:when>
								<c:when test="${penalty.peTrade_score == 8}">발송 지연</c:when>
								<c:when test="${penalty.peTrade_score == 9}">정보 불일치</c:when>
								<c:otherwise>기타</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>기타</c:otherwise>
					</c:choose></td>
				<td><c:choose>
						<c:when test="${not empty penalty.peBoard_date}">
              ${penalty.peBoard_date}
            </c:when>
						<c:when test="${not empty penalty.peTrade_date}">
              ${penalty.peTrade_date}
            </c:when>
						<c:otherwise>기타</c:otherwise>
					</c:choose></td>
			</tr>
		</c:forEach>
		--%>
	</tbody>
</table>
<!-- 페널티 끝 -->
