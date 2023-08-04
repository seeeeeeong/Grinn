<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/itemWrite.js"></script>
<!-- 게시글 상세 시작 -->
<div class="page-main">
	<h2>제품상세</h2>
	<div class="itemDetailPage">
		<!-- 사진 -->
		<div>
			<img
				src="${pageContext.request.contextPath}/item/viewProfile.do?item_num=${item.item_num}"
				width="400" height="400">
		</div>
		<div class="divider"></div>
		<div>
			<!-- 브랜드, 이름, 설명, 사이즈, 최근 거래가, 구매/판매버튼, 관심상품 -->
			<div class="itemInfo">
				<div class="title_box">
					<p class="a">${item.item_brand}</p>
					<p class="b">${item.item_name}</p>
					<p class="c">${item.item_detail}</p>
				</div>
				<div class="details">
					<div>사이즈</div>
					<div>최근 거래가</div>
				</div>
				<div>
					<div class="buttons">
						<button class="a">구매</button>
						<button class="b">판매</button>
					</div><br> 
					<span class="output_fav" data-num="${item.item_num}"> 
						<img 
							src="${pageContext.request.contextPath}/images/save_blank.png" width="15" height="15"> 
						<span>관심상품</span> 
						<span class="output_fcount" data-num="${item.item_num}"></span>
					</span>
				</div>
			</div>
		</div>
	</div>
</div>
<%-- <div class="align-right">
			<input type="button" value="수정" onclick="location.href='update.do?board_num=${board.board_num}'">
			<input type="button" value="삭제" id="delete_btn">
			<script type="text/javascript">
				let delete_btn = document.getElementById('delete_btn');
				delete_btn.onclick=function(){
					let choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.replace('delete.do?board_num=${board.board_num}');
					}
				}
			</script>
		<input type="button" value="목록" onclick="location.href='list.do'">
	</div> --%>
