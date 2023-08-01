<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/category.js"></script>
<script type="text/javascript">
	$(function(){
		$('.category_link').click(function(){
			$('.description_wrap').css('display','block');
		});
	});
</script>
<div class="page-main">
	<div class="container">
		<div id="page_nav">
			<ul>
				<li><a href="${pageContext.request.contextPath}/notice/noticeList.do">고객센터</a></li>
			</ul>
			<ul>
				<li><a href="${pageContext.request.contextPath}/notice/noticeList.do">공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/notice/noticefaq.do">자주묻는질문</a></li>
				<li><a href="${pageContext.request.contextPath}/notice/noticeAuth_policy.do">검수기준</a></li>
			</ul>
		</div>
		<div id="page_body">
			<h3 id="ha">검수기준</h3>
			<div class="categories">
				<div class="category_list"><!-- 검수기준카테고리별 선택가능 -->
					<table class="category_list_items">
						<tr>
							<c:forEach var="notice" items="${list}">
								<th class="chunk_3">
									<a href="" class="category_link">
										<span class="category_text">${notice.no_title}</span>
									</a>
								</th>
							</c:forEach>
						</tr>
					</table>
				</div>
			</div>
			<div class="wrap"><!-- 검수기준카테고리별 공지사항리스트 -->
				<div class="content">
					<div class="description_wrap" style="display:none;">
						<c:forEach var="notice" items="${list}">
							<c:if test="${notice.no_policy == 1}">${notice.no_content}</c:if>
							<c:if test="${notice.no_policy == 2}">${notice.no_content}</c:if>
							<c:if test="${notice.no_policy == 3}">${notice.no_content}</c:if>
							<c:if test="${notice.no_policy == 4}">${notice.no_content}</c:if>
							<c:if test="${notice.no_policy == 5}">${notice.no_content}</c:if>
							<c:if test="${notice.no_policy == 6}">${notice.no_content}</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="page-clear"></div>
</div>

























