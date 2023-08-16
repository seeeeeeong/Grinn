<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssk/admin_detail.css">
<script type="text/javascript">
	$(function(){
		$('#modalWrap').css('display','none');
		
		if(${trade.trade_state} == 6){
			$('.trade-state dd').css('color','red');
		}
		
		$('.change-state').click(function(){
			if(${trade.trade_state != 3} && ${trade.trade_state != 4}){
				alert('거래 상태가 [검수중],[배송중] 일때만 변경할 수 있습니다.');
			}else{
				$('#modalWrap').css('display','block');
				
				$('#main').css('opacity','1');
				$('body').css('overflow','hidden').css('padding-right','17px');
			}
		});
		$('#modal_close').click(function(){
			$('#modalWrap').css('display','none');
			$('#main').removeAttr('style');
			$('body').removeAttr('style');
		});
		
		$('.penal').click(function(event){
			event.preventDefault();
			let date = $(this).attr('data-regDate');
			let currentDate = new Date();
			date = new Date(date);
			let diff = currentDate.getDate() - date.getDate();
			
			if(diff <= 5){
				alert('아직 상품 발송 기간 '+(5-diff)+'일 남아있습니다.');	
				return;
			}else{
				location.href='adminUpdateTradeState.do?trade_num=${trade.trade_num}&trade_state=6';
			}
		});
	});
</script>
<div class="page_body">
	<div class="page-main">
		<h2 id="ha">거래 상세 정보</h2>
		<div class="trade-content">
			<div class="trade-content-detail">
				<div class="item-title">
					<h2>아이템 정보</h2>
				</div>
				<div class="item-info">
					<div class="item-info-box">
						<div class="item-img">
							<img src="${pageContext.request.contextPath}/item/viewProfile.do?item_num=${trade.item_num}" width="130" height="130">
						</div>
						<div class="item-profile">
							<p class="a">${trade.item_brand}</p>
							<p class="b">${trade.item_name}</p>
							<p class="c">${trade.item_detail}</p>
							<c:if test="${empty trade.item_size }">
								<p class="d">ONS SIZE</p>
							</c:if>
							<c:if test="${!empty trade.item_size }">
								<p class="d">${trade.item_size}</p>
							</c:if>
						</div>
					</div>
				</div>
				<div class="seller-title">
					<h2>판매자 정보</h2>
				</div>
				<div class="seller-info">
					<div class="seller-info-box">
						<div class="seller-detail">
							<dl class="seller-name">
								<dt>이름</dt>
								<dd>${trade.sellerVO.mem_name}</dd>
							</dl>
							<dl class="seller-phone">
								<dt>전화번호</dt>
								<dd>${trade.sellerVO.mem_phone}</dd>
							</dl>
							<dl class="seller-auth">
								<dt>등급</dt>
								<dd>
									<c:if test="${trade.sellerVO.mem_auth == 0}">탈퇴</c:if>
									<c:if test="${trade.sellerVO.mem_auth == 1}">정지</c:if>
									<c:if test="${trade.sellerVO.mem_auth == 2}">일반</c:if>
									<c:if test="${trade.sellerVO.mem_auth == 9}">관리</c:if>
								</dd>
							</dl>
						</div>
					</div>
				</div>
				<div class="buyer-title">
					<h2>구매자 정보</h2>
				</div>
				<div class="buyer-info">
					<div class="buyer-info-box">
						<div class="buyer-detail">
							<dl class="buyer-name">
								<dt>이름</dt>
								<dd>${trade.buyerVO.mem_name}</dd>
							</dl>
							<dl class="buyer-phone">
								<dt>전화번호</dt>
								<dd>${trade.buyerVO.mem_phone}</dd>
							</dl>
							<dl class="buyer-auth">
								<dt>등급</dt>
								<dd>
									<c:if test="${trade.buyerVO.mem_auth == 0}">탈퇴</c:if>
									<c:if test="${trade.buyerVO.mem_auth == 1}">정지</c:if>
									<c:if test="${trade.buyerVO.mem_auth == 2}">일반</c:if>
									<c:if test="${trade.buyerVO.mem_auth == 9}">관리</c:if>
								</dd>
							</dl>
						</div>
					</div>
				</div>
				<div class="trade-title">
					<h2>거래 정보</h2>
					<c:if test="${trade.trade_state > 2}">
						<a class="change-state"><span class="a-tag-text">상태 변경</span></a>
					</c:if>
					<c:if test="${trade.trade_state == 2}">
						<a class="penal" data-regDate="${trade.trade_regDate}" href="adminUpdateTradeState.do?trade_num=${trade.trade_num}&trade_state=6"><span class="a-tag-text">거래 실패</span></a>
					</c:if>
					
				</div>
				<div class="trade-info">
					<div class="trade-info-box">
						<div class="trade-detail">
							<div class="trade-detail-summary">
								<dl class="trade-regDate">
									<dt>거래 성사일</dt>
									<dd>${trade.trade_regDate}</dd>
								</dl>
								<dl class="trade-state">
									<dt>상태</dt>
									<dd>
										<c:if test="${trade.trade_state == 2}">검수준비중</c:if>
										<c:if test="${trade.trade_state == 3}">검수중</c:if>
										<c:if test="${trade.trade_state == 4}">배송중</c:if>
										<c:if test="${trade.trade_state == 5}">배송완료</c:if>
										<c:if test="${trade.trade_state == 6}">거래실패</c:if>
									</dd>
								</dl>
								<dl class="trade_price">
									<dt>거래가</dt>
									<dd><fmt:formatNumber value="${trade.trade_price}"/>원</dd>
								</dl>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 모달창 -->
<div id="modalWrap">
  <div id="modalContent">
    <div id="modalBody">
      <div class="modal-content">
      	<div class="modal-title">
      		<h2>거래 상태 변경</h2>
      	</div>
      	<div class="modal-detail">
      		<div class="modal-btns">
      			<c:if test="${trade.trade_state == 3}">
      				<input type="button" value="검수중" disabled="disabled" id="btn3">
      				<input type="button" value="배송중" id="btn4" onclick="location.href='adminUpdateTradeState.do?trade_num=${trade.trade_num}&trade_state=4'">
      				<input type="button" value="배송완료" disabled="disabled" id="btn5">
      				<input type="button" value="거래실패" id="btn6" onclick="location.href='adminUpdateTradeState.do?trade_num=${trade.trade_num}&trade_state=6'">
      			</c:if>
      			<c:if test="${trade.trade_state == 4}">
      				<input type="button" value="검수중" disabled="disabled" id="btn3">
      				<input type="button" value="배송중" disabled="disabled" id="btn4">
      				<input type="button" value="배송완료" id="btn5" onclick="location.href='adminUpdateTradeState.do?trade_num=${trade.trade_num}&trade_state=5'">
      				<input type="button" value="거래실패" disabled="disabled" id="btn6" >
      			</c:if>
      		</div>
      	</div>
      	<div class="modal-close">
      		<input type="button" value="닫기" id="modal_close">
      	</div>
      </div>
    </div>
  </div>
</div>










