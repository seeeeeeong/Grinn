<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/polling.item.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/polling.css">
<form:form modelAttribute = "pollVO" action = "pollView.do" id = "poll_view">

	<div class = "page-main">
		<div class = "poll_list">
					<div class = "poll-item">
						<!-- 1 -->
						<div class = "poll-itemone">
							<div class = "user-profile">
								<a href="${pageContext.request.contextPath}/user/userStyle.do?mem_num=${poll.mem_num}">
									<img class = "user-photo" src="${pageContext.request.contextPath}/member/viewProfile.do?mem_num=${poll.mem_num}">
								</a>
								<div class = "user-profile-name">
									<a href="${pageContext.request.contextPath}/user/userStyle.do?mem_num=${poll.mem_num}">
										<span class = "mem-id"><b>${poll.mem_id}</b></span>
									</a>
									<div class = "poll-date">
										<span class = "poll-sdate"><small>시작일 : ${poll.poll_date}</small></span>
										<span class = "poll-edate"><small>종료일 : ${poll.poll_deadline}</small></span>
									</div>
								</div>
							</div>
						</div>
						<!-- 2 -->
						<div class = "poll-content-detail">
							<div class = "poll-item-title">
								<input id = "pollNum" type="hidden" data-id="${poll.poll_num}" value="${poll.poll_num}"> 
								<span class = "poll-title"><b>${poll.poll_title}</b></span>
							</div>
							<div class = "poll-item-content">
								<c:if test = "${!empty poll.poll_content}">
								<span class = "poll-content">${poll.poll_content}</span>
								</c:if>
							</div>
						</div>
						
						<div class="polling-items">
							<!-- poll_item2 -->
							<c:if test="${poll.poll_item1 != 0}">
							<input type="radio" name="polling-option" value="${poll.poll_item1}" onclick = "showResult()" id = "radioCheck1" data-num="${poll.poll_num}">
							<div class="polling-item" id = "poll1Box">
								<img id = "polling-item-img" src="${pageContext.request.contextPath}/poll/viewPhotoByItem_num.do?item_num=${poll.poll_item1}">
								<div class = "item_content">
									<b>${poll.item_brand1}</b><br>
									${poll.item_name1}
								</div>
								<div id = "result"></div>
							</div>
							</c:if>
							
							<!-- poll_item2 -->
							<c:if test="${poll.poll_item2 != 0}">
							<input type="radio" name="polling-option" value="${poll.poll_item2}" onclick = "showResult()" id = "radioCheck2" data-num="${poll.poll_num}">
							<div class="polling-item" id = "poll2Box">
								<img id = "polling-item-img" src="${pageContext.request.contextPath}/poll/viewPhotoByItem_num.do?item_num=${poll.poll_item2}" width="100" height="100"><br>
								<div class = "item_content">
									<b>${poll.item_brand2}</b><br>
									${poll.item_name2}
								</div>
								<div id = "result"></div>
							</div>
							</c:if>
							
							<!-- poll_item3 -->
							<c:if test="${poll.poll_item3 != 0}">
							<input type="radio" name="polling-option" value="${poll.poll_item3}" onclick = "showResult()" id = "radioCheck3" data-num="${poll.poll_num}">
							<div class="polling-item" id = "poll3Box">
								<img id = "polling-item-img" src="${pageContext.request.contextPath}/poll/viewPhotoByItem_num.do?item_num=${poll.poll_item3}" width="100" height="100"><br>
								<div class = "item_content">
									<b>${poll.item_brand3}</b><br>
									${poll.item_name3}
									<div id = "result"></div>
								</div>
							</div>
							</c:if>
							
							<!-- poll_item4 -->
							<c:if test="${poll.poll_item4 != 0}">
							<input type="radio" name="polling-option" value="${poll.poll_item4}" onclick = "showResult()"  id = "radioCheck4" data-num="${poll.poll_num}">
							<div class="polling-item" id = "poll4Box">
								<img id = "polling-item-img" src="${pageContext.request.contextPath}/poll/viewPhotoByItem_num.do?item_num=${poll.poll_item4}" width="100" height="100"><br>
								<div class = "item_content">
									<b>${poll.item_brand4}</b><br>
									${poll.item_name4}
									<div id = "result"></div>
								</div>
							</div>
							</c:if>
							
							
							<div class = "align-right">
							<c:if test="${!empty user && user.mem_num == poll.mem_num}">
			      				<span id="delete_btn" style = "color:gray;">삭제</span>
								<script type="text/javascript">
									let delete_btn = document.getElementById('delete_btn');
									delete_btn.onclick=function(){
										let choice = confirm('글을 삭제하시겠습니까?');
										if(choice){
											location.replace('deletePoll.do?poll_num=${poll.poll_num}');
										}
									};
								</script>        		      				
			      			</c:if>
			      			<%--
			      			<input id = "poll-reply" type = "button" value = "댓글" onclick = "displayReplyCount()">
			      			 --%>
			      			<input id = "poll-result" type = "button" value = "투표" onclick = "pollClick()">
							</div>
							<span id="output_pcount"></span>
						</div><%--polling-items 투표 항목들 --%>
						</div><%-- poll-item3 --%>
						
		</div><%-- poll_list --%>
	</div><%-- page-main --%>
</form:form>


