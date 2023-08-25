<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/confirmId.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/memberLog.css">
<form:form modelAttribute = "memberVO" action = "registerUser.do" id = "member_register">
<div class="page-main">
	<div id = "main-logo">
		<h1 class = "h1">Grinn</h1>
		<h1 class = "h1-small" >make your smile</h1>
	</div>
	<div class = "form-ul">
		<ul>
			<li class="floating-label"><b>이름</b></li>
			<li id = "li">
				<form:input class = "input-text-name" path="mem_name" cssClass = "form-input"/>
				<form:label path="mem_name"></form:label>
				<form:errors path="mem_name" cssClass="error-color" element = "div"/>      
			</li>
			<li class="floating-label"><b>아이디</b></li>
			<li id = "li">
				<form:input class = "input-text-id" path = "mem_id" placeholder = "영문, 숫자 포함 4~12자" autocomplete = "off" cssClass = "form-input"/>
				<form:label path = "mem_id"></form:label>
				<button id = "confirmId">ID중복체크</button>
				<span id = "message_id"></span>
				<form:errors path = "mem_id" cssClass = "error-color" element = "div"/>      				
			</li>
			<li class="floating-label"><b>비밀번호</b></li>
			<li id = "li">
				<form:password path = "mem_passwd" placeholder = "영문, 숫자 포함 4~12자" cssClass = "form-input"/>
				<form:label path = "mem_passwd"></form:label>
				<form:errors path = "mem_passwd" cssClass = "error-color" element = "div"/>      
			</li>
			<li class="floating-label"><b>이메일</b></li>
			<li id = "li">
				<form:input class = "input-text" path = "mem_email" cssClass = "form-input"/>
				<form:label path = "mem_email"></form:label>
				<form:errors path = "mem_email" cssClass = "error-color" element = "div"/>      
			</li>
			<li class="floating-label"><b>전화번호</b></li>
			<li id = "li-phone">
				<form:input class= "input-text" path = "mem_phone" cssClass = "form-input"/>
				<form:label path = "mem_phone"></form:label>
				<form:errors path = "mem_phone" cssClass = "error-color" element = "div"/>      
			</li>
			<li>
				<div class = "align-center">
					<form:button class = "default-btn">가입하기</form:button>
				</div> 
			</li>
		</ul>	
	</div>   
</div>       
</form:form>
