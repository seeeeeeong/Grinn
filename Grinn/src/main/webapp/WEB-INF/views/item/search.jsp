<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script type="text/javascript">
$(function(){
	$('.tabs').hide();
	$('input[type="search"]').attr('placeholder','전체 검색');
	
	function searchData(){
		let data = $('input[type="search"]').val();
		if(data == ''){
			alert('검색어를 입력하세요.');
			$('input[type="search"]').val('').focus();
			return false;
		}
		location.href="../main/search.do?keyfield=1&keyword="+data;
	};
	
	$('input[type="search"]').keypress(function(){
		if(event.keyCode==13){
			searchData();	
		}
		
	});
});
</script>
<div class="page-main">
	<h2 class="h2h2">"${keyword}" 검색결과</h2>
	<c:if test="${count1==0 && count2==0 &&count3==0}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<div class="searchBox1">
		<c:if test="${count1>0}">
			<div class="searchBox2">
				<h3>ITEM (${count1})</h3>
				<c:if test="${count1>4}">																						
					<input type="button" value="더보기 >" 
						onclick="location.href='${pageContext.request.contextPath}/item/itemList.do?keyfield=2&keyword=${keyword}'">
				</c:if>
			</div>
			<div class="list01">
			<c:forEach var="item" items="${list1}">
				<div class="list02">
					<a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}"> 	
						<img src="${pageContext.request.contextPath}/item/photoView.do?item_num=${item.item_num}">
							<div class="list03">
								<p class="listBrand">${item.item_brand}</p>
								<div>
									<p class="itemName">${item.item_name}</p>
									<p class="itemDetail">${item.item_detail}</p>
								</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
		</c:if>
	</div>
	<div class="searchBox1">
		<c:if test="${count2>0}">
			<div class="searchBox2">
				<h3>STYLE (${count2})</h3>
				<c:if test="${count2>4}">																						
					<input type="button" value="더보기 > " 
						onclick="location.href='${pageContext.request.contextPath}/style/list.do?keyword=${keyword}'">
				</c:if>
			</div>
			<div class="stoutput2">
			<c:forEach var="style" items="${list2}">
				<div class="stylelist01">
					<a href="${pageContext.request.contextPath}/style/detail.do?st_num=${style.st_num}">
                    	<img src="${pageContext.request.contextPath}/style/viewPhoto1.do?st_num=${style.st_num}" class="stylept">
						<ul class="detail-style">
							<li>
								<img src="${pageContext.request.contextPath}/member/viewProfile.do?mem_num=${style.mem_num}" width="25" height="25" class="my-photo">
							</li>
							<li>${style.mem_id}</li>
						</ul>
						<div class="sub-style">
							<c:if test="${!empty style.st_phrase}">
								<p>${style.st_phrase}</p>
							</c:if>
						</div>
						</a>
					</div>
				</c:forEach>
			</div>
		</c:if>
	</div>
	<div class="searchBox1">
		<c:if test="${count3>0}">
			<div class="searchBox2">
				<h3>FLEAMARKET (${count3})</h3>
				<c:if test="${count3>4}">																						
					<input type="button" value="더보기 > " 
						onclick="location.href='${pageContext.request.contextPath}/fleamarket/boothList.do?keyfield=1&keyword=${keyword}'">
				</c:if>
			</div>
			<div class="list01">
			<c:forEach var="market" items="${list3}">
				<div class="list02">
					<a href="${pageContext.request.contextPath}/fleamarket/detail.do?market_num=${market.market_num}">
					<img src="${pageContext.request.contextPath}/fleamarket/imageView.do?market_num=${market.market_num}&photo_type=2" width="80" height="120">
							<div class="list03">
								<p class="listBrand">${market.market_title}</p>
								<div>
									<p class="itemName">${market.place_name}</p>
									<p class="itemDetail">${market.market_startDate} ~ ${market.market_endDate}</p>
								</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
		</c:if>
	</div>
</div>
