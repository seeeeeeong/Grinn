<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<script type = "text/javascript">
	$(function(){
		let id = 'ch'+${status};
		$('#'+id).css('color','#222');
		initCategory()
		$('.category-title').each(function(index,item){
			$(this).click(function(){
				location.href='${pageContext.request.contextPath}/poll/admin_pollList.do?status='+(index+1);
			});
		});
		function initCategory(){
			for(i=1; i<=3; i++){
				$('ch'+i).css('color','rgba(34,34,34,.5)');
			}
		}
	})
</script>
<div class = "page_body">
	<div class = "page-main">
			<div>
				(관리자)투표 리스트입니다.
				<div class = "categories">
					<div class = "category-list">
						<table>
							<tr>
								<th class = "category-title" id = "ch1">
									<span class = "category-text">전체</span>
								</th>
								<th class = "category-title" id = "ch2">
									<span class = "category-text">진행중</span>
								</th>
								<th class = "category-title" id = "ch3">
									<span class = "category-text">마감</span>
								</th>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<c:if test = "${count == 0}">
			<div class = "result-display">표시할 게시물이 없습니다.</div>
			</c:if>
			<c:if test = "${count > 0}">
			<div class = "list01">
				<c:forEach var = "item" items = "${list}">
				
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				<!-- 투표 목록 불러오기 -->
				
				
				</c:forEach>
			</div>
		<div class = "align-center">${page}</div>
		</c:if>
	</div>
</div>























