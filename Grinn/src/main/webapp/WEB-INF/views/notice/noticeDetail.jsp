<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<div id="page-main">
	<div id="page_body">
		<c:if test="${notice.no_status == 1}">
			<h3 id="ha">공지사항</h3>
		</c:if>
		<c:if test="${notice.no_status == 2}">
			<h3 id="ha">자주묻는질문</h3>
		</c:if>
		<c:if test="${notice.no_status == 3}">
			<h3 id="ha">검수기준</h3>
		</c:if>
		<div class="dropdown">
			<div class="dropdown_head">
				<div class="title_box">
					<span class="date">
						<c:if test="${empty notice.no_modifydate}">
							${notice.no_regdate}
						</c:if>
						<c:if test="${!empty notice.no_modifydate}">
							${notice.no_regdate}
						</c:if>
					</span>
					<p class="title">
					${notice.no_title}
					</p>
				</div>
			</div>
			<div class="dropdown_content">
				<div class="content">
					${notice.no_content}
				</div>
			</div>
			<div class="btn_list">
				<a href="noticeList.do" class="btn_auth">목록보기</a>
				<c:if test="${notice.mem_num==29}"><!-- 관리자 auth:9이므로 mem_auth로 수정예정 -->
					<a href="update.do?no_num=${notice.no_num}" class="btn_auth">수정하기</a>
					<a href="delete.do?no_num=${notice.no_num}" id="delete_btn"><input type="button" value="삭제하기" class="btn_auth"></a>
					<script type="text/javascript">
						let delete_btn = document.getElementById('delete_btn');
						delete_btn.onclick = function(){
							let choice = confirm('삭제하시겠습니까?');
							if(choice){
								location.replace('delete.do?no_num=${notice.no_num}');
							}else{
								return false;
							}
						};
					</script>
				</c:if>
			</div>
		</div>
	</div>
</div>
<div class="page_clear"></div>