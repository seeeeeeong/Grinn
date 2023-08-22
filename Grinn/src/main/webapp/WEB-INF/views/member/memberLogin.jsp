<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/memberLog.css">
<form:form modelAttribute = "memberVO" action = "login.do" id = "member_login">
<form:errors element = "div" cssClass = "error-color"/>
<div class="page-main">
	<div id = "main-logo">
		<h1 class = "h1">Grinn</h1>
		<h1 class = "h1-small" >make your smile</h1>
	</div>
	<div class = "form-ul">
		<ul>
			<li class="floating-label"><b>아이디</b></li>
			<li>
				<form:input path = "mem_id" cssClass = "form-input" autocomplete = "off"/>
				<form:label path = "mem_id"></form:label>
				<form:errors path = "mem_id" element = "div" cssClass = "error-color"/> 
			</li>
			<li class="floating-label"><b>비밀번호</b></li>
			<li>
				<form:password path = "mem_passwd" cssClass = "form-input"/>
				<form:label path = "mem_passwd"></form:label>
				<form:errors path = "mem_passwd" element = "div" cssClass = "error-color"/> 
			</li>
			<li>
				<div class = "align-left">
					<label for = "auto">
						<input type = "checkbox" name = "auto" id = "auto">
						자동 로그인
					</label>
				</div>
			</li>
			<li>
					<form:button class = "login-btn"><b>로그인</b></form:button>
					<input type = "button" value = "회원가입" class = "login-btn" onclick = "location.href='registerUser.do'">
				
			</li>
		</ul>   
	</div>  
	</div>                          
</form:form>
