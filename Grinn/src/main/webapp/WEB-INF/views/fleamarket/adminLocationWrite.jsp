<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 장소 등록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/market.css">
<div class="page-main">
	<h2>장소 등록</h2>
	<form:form modelAttribute="boothLocationVO" action="adminLocationWrite.do" id="location_register">
		<form:errors element="div" cssClass="error-color"></form:errors>
		<ul class=register-label>
			<li>
				<form:label path="place_name">장소명</form:label>
				<form:input path="place_name"/>
				<form:errors path="place_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="booth_count">부스 수</form:label>
				<form:input path="booth_count" type="number"/>
				<form:errors path="booth_count" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="location_row">부스 행</form:label>
				<form:input path="location_row" type="number"/>
				<form:errors path="location_row" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="location_column">부스 열</form:label>
				<form:input path="location_column" type="number"/>
				<form:errors path="location_column" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button>등록</form:button>
			<input type="button" value="목록" onclick="location.href='adminLocationList.do'">
		</div>
	</form:form>
</div>
<!-- 장소 등록 끝 -->