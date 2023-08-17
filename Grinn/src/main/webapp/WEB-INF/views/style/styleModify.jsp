<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 스타일 수정 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/st_itemTag.js"></script>
<div class="page-main">
	<div class="style-title">스타일 수정</div>
	<form:form modelAttribute="styleVO" action="write.do" enctype="multipart/form-data" class="style_form">
		<ul>
			<li>
				<input type="file" name="upload1" id="upload1" accept="image/png, image/jpeg, image/gif" required onchange="handleFileSelection(1)"/>
				<input type="file" name="upload2" id="upload2" accept="image/png, image/jpeg, image/gif" disabled onchange="handleFileSelection(2)" style="display: none;"/>
			</li>
			<li>
				<input type="file" name="upload3" id="upload3" accept="image/png, image/jpeg, image/gif" disabled onchange="handleFileSelection(3)" style="display: none;"/>
				<input type="file" name="upload4" id="upload4" accept="image/png, image/jpeg, image/gif" disabled onchange="handleFileSelection(4)" style="display: none;"/>
			</li>
			<li>
				<form:textarea path="st_phrase" rows="4" cols="51" placeholder="스타일을 자랑해보세요."/>
			</li>
			<li>
				<label class="item-tag">상품 태그</label>
				<input type="text" id="item_search" autocomplete="off">
				<ul id="search_area"></ul>
				<div id="item_tag"></div>
				<div>
					<c:if test="${styleVO.item_num1 != null}">
						<div>
							<img src="${pageContext.request.contextPath}/style/viewPhotoByItem_num.do?item_num=${styleVO.item_num1}">
							<span>${styleVO.item_name1}</span>
						</div>
					</c:if>
					<c:if test="${styleVO.item_num2 != null}">
						<div>
							<img src="${pageContext.request.contextPath}/style/viewPhotoByItem_num.do?item_num=${styleVO.item_num2}">
							<span>${styleVO.item_name2}</span>
						</div>
					</c:if>
					<c:if test="${styleVO.item_num3 != null}">
						<div>
							<img src="${pageContext.request.contextPath}/style/viewPhotoByItem_num.do?item_num=${styleVO.item_num3}">
							<span>${styleVO.item_name3}</span>
						</div>
					</c:if>										
					<input type="hidden" name="item_num1" id="item_num1" value="0">
					<input type="hidden" name="item_num2" id="item_num2" value="0">
					<input type="hidden" name="item_num3" id="item_num3" value="0">
				</div>
			</li>
		</ul>
		<div class="align-center">
			<form:button class="submit-style">수정</form:button>
			<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/style/list.do'">
		</div>
	</form:form>
</div>
<!-- 스타일 수정 끝 -->