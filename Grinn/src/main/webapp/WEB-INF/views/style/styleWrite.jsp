<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 스타일 작성 시작 -->
<style>
.style-title {
	margin: 0 auto;
	width: 500px;
	text-align: center;
}
.up-la{
  display: inline-block;
  padding: .5em .75em;
  color: #fff;
  text-align:center;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: gray;
  cursor: pointer;
  border: 1px solid gray;
  border-radius: .25em;
  -webkit-transition: background-color 0.2s;
  transition: background-color 0.2s;
}

.up-la:hover {
  background-color: black;
}

.up-la:active {
  background-color: #367c36;
}

.upload {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/st_itemTag.js"></script>
<div class="page-main">
	<div class="style-title"><h2>스타일 올리기</h2></div>
	<form:form modelAttribute="styleVO" action="write.do" enctype="multipart/form-data" class="style_form">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<label for="upload1" class="up-la">이미지 업로드</label>
				<input type="file" name="upload1" id="upload1" class="upload" required onchange="handleFileSelection(1)"/>
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
				<label class="item-tag">상품 태그</label>
				<input type="text" id="item_search" autocomplete="off" style="margin-rigth:10px">
				<ul id="search_area"></ul>
				<div id="item_tag"></div>
				<div>
					<input type="hidden" name="item_num1" id="item_num1" value="0">
					<input type="hidden" name="item_num2" id="item_num2" value="0">
					<input type="hidden" name="item_num3" id="item_num3" value="0">
				</div>
			</li>
		</ul>
		<div class="align-center">
			<form:button class="submit-style">올리기</form:button>
			<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/style/list.do'">
		</div>
	</form:form>
</div>
<!-- 스타일 작성 끝 -->