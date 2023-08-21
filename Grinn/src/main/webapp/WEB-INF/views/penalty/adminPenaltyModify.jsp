<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 페널티 수정 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/penalty.js"></script>
<div class="page-main">
	<h2>페널티 수정</h2>
	<form:form modelAttribute="penaltyVO" action="modifyPenalty.do" id="penalty_register" method="post">
	<form:hidden path="pe_num"/>
	<form:errors element="div" cssClass="error-color"></form:errors>
		<ul class="modify-label">
			<li>
				<form:label path="pe_score">점수</form:label>
				<form:input path="pe_score" type="number"/>
				<form:errors path="pe_score" cssClass="error-color"/>
			</li>
			 
			<li>
				<form:label path="pe_service_type">페널티 유형</form:label>
				<form:radiobutton path="pe_service_type" value="3" id="pe_service_type3" checked="checked"/>거래
				<form:errors path="pe_service_type" cssClass="error-color"/>
			</li>
			<li>
				<label>사유</label>
				<form:radiobutton path="pe_type" value="7" id="pe_type1"/>가품 판정
				<form:radiobutton path="pe_type" value="8" id="pe_type2"/>손상/오염
				<form:radiobutton path="pe_type" value="9" id="pe_type3"/>발송 지연
				<form:errors path="pe_type" cssClass="error-color"/>
				<%-- 
				<input type="radio" value="7" name="pe_type" id="pe_service_type7"/>가품 판정
				<input type="radio" value="8" name="pe_type" id="pe_service_type8"/>손상/오염
				<input type="radio" value="9" name="pe_type" id="pe_service_type9"/>발송 지연
				--%>
			</li>
			
		</ul>
		<div class="align-center">
			<form:button>수정</form:button>
			<input type="button" value="목록" onclick="location.href='admin_list.do'">
		</div>
	</form:form>
</div>
<!-- 페널티 수정 끝 -->