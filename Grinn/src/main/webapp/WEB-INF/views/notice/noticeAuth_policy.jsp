<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
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
	</div>
</div>
</div>