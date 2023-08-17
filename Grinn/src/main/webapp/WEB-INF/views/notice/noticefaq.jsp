<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	$(function(){
		let id = 'ch'+${no_category};
		$('#'+id).css('color','#222');
		initCategory()
		$('.chunk_3').each(function(index,item){
			$(this).click(function(){
				location.href='${pageContext.request.contextPath}/notice/noticefaq.do?no_category='+(index+1);
			});
		});
		
		function initCategory(){
			for(i=1;i<=6;i++){
				$('ch'+i).css('color','rgba(34,34,34,.5)');
			}
		}
	});
	//드롭다운
	$(function(){
		//이미지(열 때)
		$('.imgOpen').each(function(index,item){
			$(this).click(function(){
				$('.imgOpen').css('display','block');
				$(this).css('display','none');
				$('.dropdown_content').css('display','none');
				$('.dropdown_content[data-index="'+index+'"]').css('display','block');
				$('.imgClose').css('display','none');
				$('.imgClose[data-index="'+index+'"]').css('display','block');
			});
		});
		//이미지(닫을 때)
		$('.imgClose').each(function(index,item){
			$(this).click(function(){
				$(this).css('display','none');
				$('.dropdown_content').css('display','none');
				$('.dropdown_content[data-index="'+index+'"]').css('display','none');
				$('.imgOpen').css('display','block');
				$('.imgOpen[data-index="'+index+'"]').css('display','block');
			});
		});
	});
</script>
<div class="page-main">
	<div class="page_body">
		<h2 id="ha">자주묻는질문</h2>
		<!-- 검색부분 -->
		<form action="noticefaq.do" id="search_form" method="get">
			<div class="search_faq_div">
				<input type="text" placeholder="검색" class="search_faq_input"
						name="keyword" id="keyword">
			</div>
		</form>
		<!-- 자주묻는질문 시작 -->
		<div class="categories">
			<div class="category_list"><!-- 자주묻는질문 카테고리별 선택기능 -->
				<table class="category_list_items">
					<tr class="category_border">
						<th class="chunk_3" id="ch1">
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
							<span class="category_text">기타</span>
						</th>
					</tr>
				</table>
			</div>
		</div>
		<div><!-- 자주묻는질문 카테고리별 공지사항 리스트 출력 -->
			<ul class="dropdown_list">
				<li class="close"><!-- 클래스명:close일때가 기본 // 드롭다운이 열렸을 때(제목 라인을 클릭했을때) class명이 open으로 변경되게끔 -->
					<div class="dropdown">
						<%-- 드롭다운 시작 --%>
						<div id="drop">
							<c:forEach var="faq" items="${list}" varStatus="idx">
								<div class="dropdown_head">
									<strong class="sort">
										<c:if test="${faq.no_category == 2}">이용정책</c:if>
										<c:if test="${faq.no_category == 3}">공통</c:if>
										<c:if test="${faq.no_category == 4}">구매</c:if>
										<c:if test="${faq.no_category == 5}">판매</c:if>
										<c:if test="${faq.no_category == 6}">기타</c:if>
									</strong>
									<%-- 타이틀 시작 --%>
									<div class="title_box">
										<p class="title">${faq.no_title}</p>
									</div>
									<%-- 타이틀 끝 --%>
									<%-- 이미지 시작 --%>
									<div class="imgOpen" id="imgOpen" data-index="${idx.index}"><!-- 위아래 표시하는 사진 넣을 곳 -->
										<img class="classOpenImg"
											src="${pageContext.request.contextPath}/image_bundle/classOpen.png" />
									</div>
									<div class="imgClose" id="imgClose" style="display:none;" data-index="${idx.index}">
										<img class="classCloseImg"
											src="${pageContext.request.contextPath}/image_bundle/classClose.png" />
									</div>
									<%-- 이미지 끝 --%>
								</div>
								<%-- 드롭다운 끝 --%>
								<%-- 내용 시작 --%>
								<div class="dropdown_content" style="display:none;" data-index="${idx.index}">
									<div class="content">
										<b>${faq.no_content}</b>
									</div>
								</div>
								<%-- 내용 끝 --%>
							</c:forEach>
						</div>
					</div>
				</li>
			</ul>
		</div><br>
		<div class="align-center">${page}</div>
	</div>
	<div class="page-clear"></div>
</div>







