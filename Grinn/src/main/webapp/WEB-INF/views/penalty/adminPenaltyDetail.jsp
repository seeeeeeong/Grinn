<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 관리자 페널티 내역 시작 -->
<div class="page-main">
	<h2 class="detail-border">페널티 내역</h2>
	<form:form modelAttribute="penaltyVO" action="admin_detail.do" id="penalty_detail">
		<form:hidden path="pe_num"/>
		<ul>
			<li>
				<label>번호</label>
				${penaltyVO.pe_num}
			</li>
			<li>
				<label>회원 ID</label>
				${penaltyVO.memberVO.mem_id}
			</li>
			<li>
				<label>회원 등급</label>
				<c:if test="${penaltyVO.memberVO.mem_auth == 0}">탈퇴</c:if>
				<c:if test="${penaltyVO.memberVO.mem_auth == 1}">정지</c:if>
				<c:if test="${penaltyVO.memberVO.mem_auth == 2}">일반</c:if>
				<c:if test="${penaltyVO.memberVO.mem_auth == 9}">관리</c:if>
			</li>
			<li>
				<label>부여일</label>
				${penaltyVO.pe_date}
			</li>
			<li>
				<label>유형</label>
				<c:if test="${penaltyVO.pe_service_type == 1}">게시판</c:if>
				<c:if test="${penaltyVO.pe_service_type == 2}">댓글</c:if>
				<c:if test="${penaltyVO.pe_service_type == 3}">거래</c:if>
			</li>
			<li>
				<label>점수</label>
				${penaltyVO.pe_score}
			</li>
			<li>
				<label>사유</label>
				<c:if test="${penaltyVO.pe_type == 1}">도용한 게시글</c:if>
				<c:if test="${penaltyVO.pe_type == 2}">관련 없는 게시글</c:if>
				<c:if test="${penaltyVO.pe_type == 3}">선정적 게시글</c:if>
				<c:if test="${penaltyVO.pe_type == 4}">허위 댓글</c:if>
				<c:if test="${penaltyVO.pe_type == 5}">비방 댓글</c:if>
				<c:if test="${penaltyVO.pe_type == 6}">선정적 댓글</c:if>
				<c:if test="${penaltyVO.pe_type == 7}">가품 판정</c:if>
				<c:if test="${penaltyVO.pe_type == 8}">손상/오염</c:if>
				<c:if test="${penaltyVO.pe_type == 9}">발송 지연</c:if>
			</li>
		</ul>	
		<div class="align-right">
			<input type="button" value="페널티 목록"
			 onclick="location.href='${pageContext.request.contextPath}/penalty/admin_list.do'">
		</div>             
	</form:form>
</div>
<!-- 관리자 페널티 내역 끝 -->