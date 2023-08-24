<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/polling.item.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/polling.css">
<form:form modelAttribute = "pollVO" action = "pollList.do" id = "poll_list">

	<div class = "page-main">
	<%-- 
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>투표수</option>
			</select>
		</div>
	--%>
		<script type="text/javascript">
			$(function(){
				$('#order').change(function(){
					location.href='&order='+$('#order').val();
				});
			});
		</script>
		<div class = "align-right">
			<c:if test="${!empty user}">
				<input type = "button" value = "투표등록" onclick = "location.href='pollWrite.do'" class = "insert-poll">
			</c:if>
		</div>
		
		
		<div class = "poll_list">
			<c:if test = "${count == 0}">
				<div class = "result-display">표시할 게시물이 없습니다.</div>
			</c:if>
			<c:if test = "${count > 0}">
				<c:forEach var = "poll" items = "${list}">
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
								<input type="hidden" data-id="${poll.poll_num}" value="${poll.poll_num}"> 
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
							<input type="radio" name="polling-option" value="option1" onclick = "showResult()" id = "radioCheck">
							<div class="polling-item" id = "poll1Box">
								<!-- <label id = "polling-item-box">
									<img id = "polling-item-img" src="${pageContext.request.contextPath}/poll/viewPhotoByItem_num.do?item_num=${poll.poll_item1}">
									<span id = "result"></span>
									${poll.item_brand1}${poll.item_name1}
								</label> -->
								<img id = "polling-item-img" src="${pageContext.request.contextPath}/poll/viewPhotoByItem_num.do?item_num=${poll.poll_item1}">
								${poll.item_brand1}${poll.item_name1}
							</div>
							</c:if>
							
							<!-- poll_item2 -->
							<c:if test="${poll.poll_item2 != 0}">
							<input type="radio" name="polling-option" value="option2" onclick = "showResult()">
							<div class="polling-item" id = "poll2Box">
								<label id = "polling-item-box">
									<img id = "polling-item-img" src="${pageContext.request.contextPath}/poll/viewPhotoByItem_num.do?item_num=${poll.poll_item2}" width="100" height="100"><br>
									<span id = "result2"></span>
								</label>
							</div>
							</c:if>
							
							<!-- poll_item3 -->
							<c:if test="${poll.poll_item3 != 0}">
							<input type="radio" name="polling-option" value="option3" onclick = "showResult()">
							<div class="polling-item" id = "poll3Box">
								<label id = "polling-item-box">
									<img id = "polling-item-img" src="${pageContext.request.contextPath}/poll/viewPhotoByItem_num.do?item_num=${poll.poll_item3}" width="100" height="100"><br>
									<span id = "result3"></span>
								</label>
							</div>
							</c:if>
							
							<!-- poll_item4 -->
							<c:if test="${poll.poll_item4 != 0}">
							<input type="radio" name="polling-option" value="option4" onclick = "showResult()">
							<div class="polling-item" id = "poll4Box">
								<label id = "polling-item-box">
									<img id = "polling-item-img" src="${pageContext.request.contextPath}/poll/viewPhotoByItem_num.do?item_num=${poll.poll_item4}" width="100" height="100"><br>
									<span id = "result4"></span>
								</label>
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
											location.replace('delete.do?poll_num=${poll.poll_num}');
										}
									};
								</script>        		      				
			      			</c:if>
			      			<input id = "poll-result" type = "button" value = "투표">
							</div>
						</div><%--polling-items 투표 항목들 --%>
						</div><%-- poll-item3 --%>
						
						<!-- 3 -->
						<div class = "poll-item3">
					</div><%-- poll-item --%>
				</c:forEach>
			</c:if>
		</div><%-- poll_list --%>
		<div class = "align-center">${page}</div>
	</div><%-- page-main --%>
</form:form>


