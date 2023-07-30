<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="page-main">
	<div class="style-title">스타일 올리기</div>
	<form:form modelAttribute="styleVO" action="write.do" enctype="multipart/form-data" class="style_form">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<input type="file" name="upload1" id="upload1"/>
				<input type="file" name="upload2" id="upload2"/>
			</li>
			<li>
				<input type="file" name="upload3" id="upload3"/>
				<input type="file" name="upload4" id="upload4"/>
			</li>
			<li>
				<form:textarea path="st_phrase" rows="4" cols="51" placeholder="스타일을 자랑해보세요."/>
			</li>
		</ul>
		<div class="align-center">
			<form:button>올리기</form:button>
			<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/style/list.do'">
		</div>
	</form:form>
</div>