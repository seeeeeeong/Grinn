<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 스타일 작성 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/st_itemTag.js"></script>
<div class="page-main">
	<div class="style-title">스타일 올리기</div>
	<form:form modelAttribute="styleVO" action="write.do" enctype="multipart/form-data" class="style_form">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<span style="font-size:30pt;">📷</span><br>
				<input type="file" name="upload1" id="upload1" required onchange="handleFileSelection(1)"/>
				<input type="file" name="upload2" id="upload2" disabled onchange="handleFileSelection(2)" style="display: none;"/>
			</li>
			<li>
				<input type="file" name="upload3" id="upload3" disabled onchange="handleFileSelection(3)" style="display: none;"/>
				<input type="file" name="upload4" id="upload4" disabled onchange="handleFileSelection(4)" style="display: none;"/>
			</li>
			<li>
				<form:textarea path="st_phrase" rows="4" cols="51" placeholder="스타일을 자랑해보세요."/>
			</li>
			<li>
				<label>상품 태그</label>
				<input type="text" id="item_search" autocomplete="off">
				<ul id="search_area"></ul>
				<div id="item_tag"></div>
			</li>
		</ul>
		<div class="align-center">
			<form:button>올리기</form:button>
			<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/style/list.do'">
		</div>
	</form:form>
</div>
<!-- 스타일 작성 끝 -->