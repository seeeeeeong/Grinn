<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		location.href="../main/search.do?keyfield=2&keyword="+data;
	};
	
	$('input[type="search"]').keypress(function(){
		if(event.keyCode==13){
			searchData();	
		}
		
	});
});
</script>
<c:if test="${count1>4}">																						
	<input type="button" value="더보기" onclick="location.href='${pageContext.request.contextPath}/item/itemList.do?keyfield=2&keyword=${keyword}'">
</c:if>
<c:forEach var="item" items="${list1}">
	<a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}">${item.item_name}</a>
</c:forEach>
<c:if test="${count2>4}">																						
	<input type="button" value="더보기" onclick="location.href='${pageContext.request.contextPath}/style/list.do?keyword=${keyword}'">
</c:if>
<c:forEach var="style" items="${list2}">
	<a href="${pageContext.request.contextPath}/style/detail.do?st_num=${style.st_num}">${style.st_num}</a>
</c:forEach>
