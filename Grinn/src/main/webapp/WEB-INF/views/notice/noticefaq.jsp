<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dropdown.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/notice.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js">
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
	<div class="page_body">
		<h2 id="ha">자주묻는질문</h2>
		<!-- 검색부분 추가예정 -->
		<div class="search_faq_div">
			<input type="text" placeholder="검색" title="검색창" class="search_faq_input">
		</div>
		<div class="categories">
			<div class="category_list"><!-- 자주묻는질문 카테고리별 선택기능 -->
				<table class="category_list_items">
					<tr class="category_border">
						<th class="chunk_3" id="ch1" style="color: #222;">
							<span class="category_text">전체</span>
						</th>
						<th class="chunk_3" id="ch2">
							<span class="category_text">이용정책</span>
						</th>
						<th class="chunk_3" id="ch3">
							<span class="category_text">공통</span>
						</th>
						<th class="chunk_3" id="ch4">
							<span class="category_text">구매</span>
						</th>
						<th class="chunk_3" id="ch5">
							<span class="category_text">판매</span>
						</th>
						<th class="chunk_3" id="ch6">
							<span class="category_text">(공백예정)</span>
						</th>
					</tr>
				</table>
			</div>
		</div>
		<div><!-- 자주묻는질문 카테고리별 공지사항 리스트 출력 -->
			<ul class="dropdown_list">
				<li class="close"><!-- 클래스명:close일때가 기본 // 드롭다운이 열렸을 때(제목 라인을 클릭했을때) class명이 open으로 변경되게끔 -->
					<div class="dropdown">
						<%-- 공통 시작 --%>
						<div id="drop">
						<c:forEach var="faq" items="${list}">
							<%-- 드롭다운 타이틀 --%>
							<div class="dropdown_head">
								<strong class="sort">
									<c:if test="${faq.no_category == 1}">이용정책</c:if>
									<c:if test="${faq.no_category == 2}">공통</c:if>
									<c:if test="${faq.no_category == 3}">구매</c:if>
									<c:if test="${faq.no_category == 4}">판매</c:if>
								</strong>
								<div class="title_box">
									<p class="title">${faq.no_title}</p>
								</div>
								<%-- 드롭다운 시작 --%>
								<div class="imgOpen" id="imgOpen"><!-- 위아래 표시하는 사진 넣을 곳 -->
									<img class="classOpenImg"
										src="${pageContext.request.contextPath}/image_bundle/classOpen.png" />
								</div>
								<div class="imgClose" id="imgClose" style="display:none;">
									<img class="classCloseImg"
										src="${pageContext.request.contextPath}/image_bundle/classClose.png" />
								</div>
								<%-- 드롭다운 끝 --%>
							</div>
							<%-- 드롭다운 내용 --%>
							<div class="dropdown_content" style="display:none;">
								<div class="content">
									<b>${faq.no_content}</b>
								</div>
							</div>
						</c:forEach>
						<%-- 공통 끝 --%>
						</div>
						
						<div id="drop2">
						<c:forEach var="faq1" items="${listOne}">
							<%-- 드롭다운 타이틀 --%>
							<div class="dropdown_head" style="display:none;">
								<strong class="sort">
									<c:if test="${faq1.no_category == 1}">이용정책</c:if>
								</strong>
								<div class="title_box">
									<p class="title">${faq1.no_title}</p>
								</div>
								<%-- 드롭다운 시작 --%>
								<div class="imgOpen" id="imgOpen"><!-- 위아래 표시하는 사진 넣을 곳 -->
									<img class="classOpenImg"
										src="${pageContext.request.contextPath}/image_bundle/classOpen.png" />
								</div>
								<div class="imgClose" id="imgClose" style="display:none;">
									<img class="classCloseImg"
										src="${pageContext.request.contextPath}/image_bundle/classClose.png" />
								</div>
								<%-- 드롭다운 끝 --%>
							</div>
							<%-- 드롭다운 내용 --%>
							<div class="dropdown_content" id="dropdown_content" style="display:none;">
								<div class="content">
									${faq.no_content}
								</div>
							</div>
						</c:forEach>
						</div>
						
						<div id="drop3">
						<c:forEach var="faq2" items="${listTwo}">
							<%-- 드롭다운 타이틀 --%>
							<div class="dropdown_head" style="display:none;">
								<strong class="sort">
									<c:if test="${faq2.no_category == 2}">공통</c:if>
								</strong>
								<div class="title_box">
									<p class="title">${faq2.no_title}</p>
								</div>
								<%-- 드롭다운 시작 --%>
								<div class="imgOpen" id="imgOpen"><!-- 위아래 표시하는 사진 넣을 곳 -->
									<img class="classOpenImg"
										src="${pageContext.request.contextPath}/image_bundle/classOpen.png" />
								</div>
								<div class="imgClose" id="imgClose" style="display:none;">
									<img class="classCloseImg"
										src="${pageContext.request.contextPath}/image_bundle/classClose.png" />
								</div>
								<%-- 드롭다운 끝 --%>
							</div>
							<%-- 드롭다운 내용 --%>
							<div class="dropdown_content" id="dropdown_content" style="display:none;">
								<div class="content">
									${faq.no_content}
								</div>
							</div>
						</c:forEach>
						</div>
						
						<c:forEach var="faq3" items="${listThree}">
							<%-- 드롭다운 타이틀 --%>
							<div class="dropdown_head" style="display:none;">
								<strong class="sort">
									<c:if test="${faq3.no_category == 3}">구매</c:if>
								</strong>
								<div class="title_box">
									<p class="title">${faq3.no_title}</p>
								</div>
								<%-- 드롭다운 시작 --%>
								<div class="imgOpen" id="imgOpen"><!-- 위아래 표시하는 사진 넣을 곳 -->
									<img class="classOpenImg"
										src="${pageContext.request.contextPath}/image_bundle/classOpen.png" />
								</div>
								<div class="imgClose" id="imgClose" style="display:none;">
									<img class="classCloseImg"
										src="${pageContext.request.contextPath}/image_bundle/classClose.png" />
								</div>
								<%-- 드롭다운 끝 --%>
							</div>
							<%-- 드롭다운 내용 --%>
							<div class="dropdown_content" id="dropdown_content" style="display:none;">
								<div class="content">
									${faq.no_content}
								</div>
							</div>
						</c:forEach>
						
						<c:forEach var="faq4" items="${listFour}">
							<%-- 드롭다운 타이틀 --%>
							<div class="dropdown_head" style="display:none;">
								<strong class="sort">
									<c:if test="${faq4.no_category == 4}">판매</c:if>
								</strong>
								<div class="title_box">
									<p class="title">${faq4.no_title}</p>
								</div>
								<%-- 드롭다운 시작 --%>
								<div class="imgOpen" id="imgOpen"><!-- 위아래 표시하는 사진 넣을 곳 -->
									<img class="classOpenImg"
										src="${pageContext.request.contextPath}/image_bundle/classOpen.png" />
								</div>
								<div class="imgClose" id="imgClose" style="display:none;">
									<img class="classCloseImg"
										src="${pageContext.request.contextPath}/image_bundle/classClose.png" />
								</div>
								<%-- 드롭다운 끝 --%>
							</div>
							<%-- 드롭다운 내용 --%>
							<div class="dropdown_content" id="dropdown_content" style="display:none;">
								<div class="content">
									${faq.no_content}
								</div>
							</div>
						</c:forEach>
						
					</div>
				</li>
			</ul>
		</div><br>
		<%-- <div class="align-center">${page}</div> --%>
	</div>
	<div class="page-clear"></div>
</div>







