<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/notice.js"></script>
<div class="page-main">
		<div id="page_body">
			<h3 id="ha">검수기준</h3>
			<div class="categories">
				<div class="category_list"><!-- 검수기준카테고리별 선택기능 -->
					<table class="category_list_items">
						<tr class="category_border">
							<th class="chunk_3" id="ch1" style="color: #222;">
								<span class="category_text">신발</span>
							</th>
							<th class="chunk_3" id="ch2">
								<span class="category_text">상의</span>
							</th>
							<th class="chunk_3" id="ch3">
								<span class="category_text">하의</span>
							</th>
							<th class="chunk_3" id="ch4">
								<span class="category_text">패션잡화</span>
							</th>
							<th class="chunk_3" id="ch5">
								<span class="category_text">프리미엄시계</span>
							</th>
							<th class="chunk_3" id="ch6">
								<span class="category_text">프리미엄가방</span>
							</th>
						</tr>
					</table>
				</div>
			</div>
			<div class="wrap"><!-- 검수기준카테고리별 공지사항 내용출력 -->
				<div class="content">
					<div class="description_wrap1" id="description_wrap">
						<c:if test="${list.get(0).no_policy == 1}">${list.get(0).no_content}</c:if>
					</div>
					<div class="description_wrap2" style="display:none;" id="description_wrap">
						<c:if test="${list.get(1).no_policy == 2}">${list.get(1).no_content}</c:if>
					</div>
					<div class="description_wrap3" style="display:none;" id="description_wrap">
						<c:if test="${list.get(2).no_policy == 3}">${list.get(2).no_content}</c:if>
					</div>
					<div class="description_wrap4" style="display:none;" id="description_wrap">
						<c:if test="${list.get(3).no_policy == 4}">${list.get(3).no_content}</c:if>
					</div>
					<div class="description_wrap5" style="display:none;" id="description_wrap">
						<c:if test="${list.get(4).no_policy == 5}">${list.get(4).no_content}</c:if>
					</div>
					<div class="description_wrap6" style="display:none;" id="description_wrap">
						<c:if test="${list.get(5).no_policy == 6}">${list.get(5).no_content}</c:if>
					</div>
				</div>
			</div>
			<div class="align-center">${page}</div>
		</div>
	<div class="page-clear"></div>
</div>











