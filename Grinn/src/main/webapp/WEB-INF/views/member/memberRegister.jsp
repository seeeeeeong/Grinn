<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/confirmId.js"></script>
<div class="page-main">
	<h2>회원가입</h2>
	<form:form modelAttribute="memberVO" action="registerUser.do" id="member_register">
		<ul>
			<li>
				<form:label path="id">아이디</form:label>
				<form:input path="id" placeholder="영문, 숫자 포함 4~12자" autocomplete="off"/>
				<input type="button" id="confirmId" value="ID중복체크" class="default-btn">
				<span id="message_id"></span>
				<form:errors path="id" cssClass="error-color"/>      
			</li>
			<li>
				<form:label path="passwd">비밀번호</form:label>
				<form:password path="passwd" placeholder="영문, 숫자 포함 4~12자"/>
				<form:errors path="passwd" cssClass="error-color"/>      
			</li>
			<li>
				<form:label path="email">이메일</form:label>
				<form:input path="email"/>
				<form:errors path="email" cssClass="error-color"/>      
			</li>
			<li>
				<form:label path="phone">전화번호</form:label>
				<form:input path="phone"/>
				<form:errors path="phone" cssClass="error-color"/>      
			</li>
		</ul>	
		<div class="align-center">
			<form:button class="default-btn">가입하기</form:button>
		</div>             
	</form:form>
</div>