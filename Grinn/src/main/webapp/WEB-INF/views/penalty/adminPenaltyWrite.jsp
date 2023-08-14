<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 페널티 등록 시작 -->
<div class="page-main">
	<h2>페널티 등록</h2>
	<form:form modelAttribute="penaltyVO" action="adminPenaltyWrite.do" id="penalty_register">
		<form:errors element="div" cssClass="error-color"></form:errors>
		<ul class="register-label">
			<li>
				<label for="pe_service_type">페널티 유형</label>
				<form:radiobutton path="pe_service_type" value="1" id="pe_service_type1"/>게시판
				<form:radiobutton path="pe_service_type" value="2" id="pe_service_type2"/>거래
				<form:errors path="pe_service_type" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="mem_num">ID</form:label>
				<form:input path="mem_num"/>
				<form:errors path="mem_num" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="pe_score">점수</form:label>
				<form:input path="pe_score" type="number"/>
				<form:errors path="pe_score" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="pe_type">사유</form:label>
				<form:select path="pe_type">
					<form:option value="1" selected="${penaltyVO.pe_service_type == '1'? 'selected' : ''}">도용</form:option>
					<form:option value="2" selected="${penaltyVO.pe_service_type == '1'? 'selected' : ''}">관련 없는 게시글</form:option>
					<form:option value="3" selected="${penaltyVO.pe_service_type == '1'? 'selected' : ''}">선정적 게시글</form:option>
					<form:option value="4" selected="${penaltyVO.pe_service_type == '1'? 'selected' : ''}">허위 댓글</form:option>
					<form:option value="5" selected="${penaltyVO.pe_service_type == '1'? 'selected' : ''}">비방 댓글</form:option>
					<form:option value="6" selected="${penaltyVO.pe_service_type == '1'? 'selected' : ''}">선정적 댓글</form:option>
					<form:option value="7" selected="${penaltyVO.pe_service_type == '2'? 'selected' : ''}">가품 판정</form:option>
					<form:option value="8" selected="${penaltyVO.pe_service_type == '2'? 'selected' : ''}">손상/오염</form:option>
					<form:option value="9" selected="${penaltyVO.pe_service_type == '2'? 'selected' : ''}">발송지연</form:option>
				</form:select>
				<form:errors path="pe_type" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button>등록</form:button>
			<input type="button" value="목록" onclick="location.href='admin_list.do'">
		</div>
	</form:form>
</div>
<!-- 페널티 등록 끝 -->