<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- 판매내역 시작 -->
<script type="text/javascript">
	$(function(){
		$('#dialog').dialog({
			width: '700px',
			height: 'auto',
			autoOpen: false,
			modal: true
		});
		
		$('.select-status').click(function(){
			$('#dialog').dialog('open');
		});
		
		$('#btn_status1').click(function(){
			$('#status').attr('value','전체').attr('data-status','1');	
			$('#dialog').dialog('close');
			if(${way} == '1'){
				location.href='${pageContext.request.contextPath}/myPage/selling.do?way=1&status=1';
			}else if(${way} == '2'){
				location.href='${pageContext.request.contextPath}/myPage/selling.do?way=2&status=1';
			}
		});
		$('#btn_status2').click(function(){
			if(${way} == '1'){
				$('#status').attr('value','입찰중').attr('data-status','2');	
				
				location.href='${pageContext.request.contextPath}/myPage/selling.do?way=1&status=2';
			}else if(${way} == '2'){
				$('#status').attr('value','검수준비중').attr('data-status','2');	
				$('#dialog').dialog('close');
				location.href='${pageContext.request.contextPath}/myPage/selling.do?way=2&status=2';
			}
		});
		$('#btn_status3').click(function(){
			if(${way} == '1'){
				$('#status').attr('value','기한만료').attr('data-status','3');	
				$('#dialog').dialog('close');
				location.href='${pageContext.request.contextPath}/myPage/selling.do?way=1&status=3';
			}else if(${way} == '2'){
				$('#status').attr('value','검수중').attr('data-status','3');	
				$('#dialog').dialog('close');
				location.href='${pageContext.request.contextPath}/myPage/selling.do?way=2&status=3';
			}
		});
		
		$('#btn_status4').click(function(){
			$('#status').attr('value','배송중').attr('data-status','4');	
			$('#dialog').dialog('close');
			location.href='${pageContext.request.contextPath}/myPage/selling.do?way=2&status=4';
		});
		
		$('#btn_status5').click(function(){
			$('#status').attr('value','거래실패').attr('data-status','6');	
			$('#dialog').dialog('close');
			location.href='${pageContext.request.contextPath}/myPage/selling.do?way=2&status=6';
		});
		
		if(${way} == '1'){
			if($('#status').attr('data-status') == '3'){
				$('.list-text').css('color','red');
			}	
		}
		
	});
</script>

<div class="page-main">
	<h2>판매 내역</h2>
	<div class="title-list">
		<table>
			<thead>
				<tr>
					<td onclick="location.href='${pageConetext.request.contextPath}/myPage/selling.do?way=1'">
						<p>${bidCount}</p>
						<p>판매입찰</p>
					</td>
					<td onclick="location.href='${pageConetext.request.contextPath}/myPage/selling.do?way=2'">
						<p>${tradeCount}</p>
						<p>진행중</p>
					</td>
					<td onclick="location.href='${pageConetext.request.contextPath}/myPage/selling.do?way=3'">
						<p>${quitCount}</p>
						<p>종료</p>
					</td>
				</tr>
			</thead>
		</table>
	</div>
	<c:if test="${count == 0}">
	<c:if test="${way == 1}">
	<div class="result-display">판매 입찰 내역이 없습니다.</div>
	</c:if>
	<c:if test="${way == 2}">
	<div class="result-display">판매 거래 내역이 없습니다.</div>
	</c:if>
	<c:if test="${way == 3}">
	<div class="result-display">종료된 판매 내역이 없습니다.</div>
	</c:if>
	</c:if>
<c:if test="${count > 0}">
<div class="table-header">
	
	<c:if test="${way == 1}">
		<div class="list-select">
			<div class="select-status">
				<c:if test="${status == 1}">
					<input type="button" data-status="1" value="전체" id="status">
				</c:if>
				<c:if test="${status == 2}">
					<input type="button" data-status="2" value="입찰중" id="status">
				</c:if>
				<c:if test="${status == 3}">
					<input type="button" data-status="3" value="기한만료" id="status">
				</c:if>
			</div>
		</div>
	</c:if>
	<c:if test="${way == 2}">
		<div class="list-select">
			<div class="select-status">
				<c:if test="${status == 1}">
					<input type="button" data-status="1" value="전체" id="status">
				</c:if>
				<c:if test="${status == 2}">
					<input type="button" data-status="2" value="검수준비중" id="status">
				</c:if>
				<c:if test="${status == 3}">
					<input type="button" data-status="3" value="검수중" id="status">
				</c:if>
				<c:if test="${status == 4}">
					<input type="button" data-status="4" value="배송중" id="status">
				</c:if>
				<c:if test="${status == 6}">
					<input type="button" data-status="6" value="거래실패" id="status">
				</c:if>
			</div>
		</div>
	</c:if>
	<c:if test="${way == 3}">
		<div class="list-select">
			<div class="select-status">
				<input type="button" data-status="5" value="배송완료" id="status">
			</div>
		</div>
	</c:if>
</div>

	<table>
	  <thead>
	    <tr>
	      <th>상품 사진</th>
	      <th>상품 브랜드</th>
	      <th>상품 이름</th>
	      <th>상품 사이즈</th>
	      <c:if test="${way == 1}">
	      <th>희망 가격</th>
	      <th>입찰 등록일</th>
	      <th>입찰 마감일</th>
	      </c:if>
	      <c:if test="${way >= 2}">
	      <th>거래 가격</th>
	      <th>거래 날짜</th>
	      <th>구매자 이름</th>
	      <th>거래 상태 </th>
	      </c:if>
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach items="${list}" var="list">
	      <tr class="list-text">
	        <td><img src="${list.item_photo1}" width="50" height="50"></td>
	        <td>${list.item_brand}</td>
	        <td>${list.item_name}</td>
	        <td>${list.item_size}</td>
	        <c:if test="${way == 1}">
	        <td>${list.sale_price}</td>
	        <td>${list.sale_regDate}</td>
	        <td>${list.sale_deadline}</td>
	        </c:if>
	        <c:if test="${way == 2}">
	        <td>${list.trade_price}</td>
	        <td>${list.trade_regDate}</td>
	        <td>${list.mem_name}</td>
	        <c:if test="${list.trade_state==2}">
	        <td>검수준비중</td>
	        </c:if>
	        <c:if test="${list.trade_state==3}">
	        <td>검수중</td>
	        </c:if>
	        <c:if test="${list.trade_state==4}">
	        <td>배송중</td>
	        </c:if>
	        <c:if test="${list.trade_state==6}">
	        <td>거래실패</td>
	        </c:if>
	        </c:if>
	        <c:if test="${way == 3}">
	        <td>${list.trade_price}</td>
	        <td>${list.trade_regDate}</td>
	        <td>${list.mem_name}</td>
	        <c:if test="${list.trade_state==5}">
	        <td>배송완료</td>
	        </c:if>
	        </c:if>
	      </tr>
	    </c:forEach>
	  </tbody>
	</table>
</c:if>
<div class="align-center">${page}</div>
<c:if test="${way == 1}">
	<div id="dialog">
		<ul>
			<li>
				<input type="button" value="전체" id="btn_status1">
			</li>
			<li>
				<input type="button" value="입찰중" id="btn_status2">
			</li>
			<li>
				<input type="button" value="기한만료" id="btn_status3">
			</li>
		</ul>
	</div>
</c:if>
<c:if test="${way == 2}">
	<div id="dialog">
		<ul>
			<li>
				<input type="button" value="전체" id="btn_status1">
			</li>
			<li>
				<input type="button" value="검수준비중" id="btn_status2">
			</li>
			<li>
				<input type="button" value="검수중" id="btn_status3">
			</li>
			<li>
				<input type="button" value="배송중" id="btn_status4">
			</li>
			<li>
				<input type="button" value="거래실패" id="btn_status5">
			</li>
		</ul>
	</div>
</c:if>
</div>
<!-- 판매내역 끝 -->
