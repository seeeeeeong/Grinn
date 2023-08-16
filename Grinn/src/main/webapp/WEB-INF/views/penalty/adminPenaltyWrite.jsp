<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 페널티 등록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/penalty.js"></script>
<div class="page-main">
	<h2>페널티 등록</h2>
	<form:form modelAttribute="penaltyVO" action="adminPenaltyWrite.do" id="penalty_register">
		<form:errors element="div" cssClass="error-color"></form:errors>
		<ul class="register-label">
			<li>
				<label for="mem_num">ID</label>
				<form:input path="mem_num"/>
				<form:errors path="mem_num" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="pe_score">점수</form:label>
				<form:input path="pe_score" type="number"/>
				<form:errors path="pe_score" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="pe_service_type">페널티 유형</form:label>
				<form:radiobutton path="pe_service_type" value="1" id="pe_service_type1"/>게시글
				<form:radiobutton path="pe_service_type" value="2" id="pe_service_type2"/>댓글
				<form:radiobutton path="pe_service_type" value="3" id="pe_service_type3"/>거래
				<form:errors path="pe_service_type" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="pe_type">사유</form:label><br>
				<input type="radio" value="1" name="pe_service_type1" id="pe_service_type1" class="pe-type1"/>도용 게시글
				<input type="radio" value="2" name="pe_service_type2" id="pe_service_type2" class="pe-type1"/>관련 없는 게시글
				<input type="radio" value="3" name="pe_service_type3" id="pe_service_type3" class="pe-type1"/>선정적 게시글<br>
				<input type="radio" value="4" name="pe_service_type4" id="pe_service_type4" class="pe-type2"/>허위 댓글
				<input type="radio" value="5" name="pe_service_type5" id="pe_service_type5" class="pe-type2"/>비방 댓글
				<input type="radio" value="6" name="pe_service_type6" id="pe_service_type6" class="pe-type2"/>선정적 댓글<br>
				<input type="radio" value="7" name="pe_service_type7" id="pe_service_type7" class="pe-type3"/>가품 판정
				<input type="radio" value="8" name="pe_service_type8" id="pe_service_type8" class="pe-type3"/>손상/오염
				<input type="radio" value="9" name="pe_service_type9" id="pe_service_type9" class="pe-type3"/>발송지연
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