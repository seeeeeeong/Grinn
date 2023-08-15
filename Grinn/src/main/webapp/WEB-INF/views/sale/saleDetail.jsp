<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<script type="text/javascript" src="${pageContext.request.contextPath}/js/tradeSale.js"></script>    
<script type="text/javascript">
	$(function(){
		$('#btn_purchase_direct').show();
		$('#btn_purchase_bid').hide();
		$('#print_deadline').attr('data-deadline','1');
		$('.btn-direct input').css('background-color','#41B979')
		$('.btn-direct input').css('color','white');
		
		if(${purchaseBidCount == 0}){
			$('#print_deadline').attr('data-deadline','');
			$('#sale_method').text('').text('판매 입찰 하기');
			$('#direct_price').css('display','none');
			$('#bid_price').css('display','flex');
			$('#input_deadline').css('display','block');
			$('#btn_sale').attr('value','판매 입찰 계속');
			$('#btn_sale').attr('data-type',"2");
			$('#input_bid').val('');
			$('.btn-bid input').css('background-color','#41B979')
			$('.btn-bid input').css('color','white');
			$('.btn-direct input').css('background-color','#ebebeb')
			$('.btn-direct input').css('color','black');
		}
		
		$('#sale_bid').click(function(){
			$('#print_deadline').attr('data-deadline','');
			$('#sale_method').text('').text('판매 입찰 하기');
			$('#direct_price').css('display','none');
			$('#bid_price').css('display','flex');
			$('#input_deadline').css('display','block');
			$('#btn_sale').attr('value','판매 입찰 계속');
			$('#btn_sale').attr('data-type',"2");
			$('#input_bid').val('');
			$('.btn-bid input').css('background-color','#41B979')
			$('.btn-bid input').css('color','white');
			$('.btn-direct input').css('background-color','#ebebeb')
			$('.btn-direct input').css('color','black');
		});
		$('#sale_direct').click(function(){
			$('#input_bid').val(${maxPurchaseBid});
			$('#sale_method').text('').text('즉시 판매 하기');
			$('#direct_price').css('display','flex');
			$('#bid_price').css('display','none');
			$('#input_deadline').css('display','none');
			$('#btn_sale').attr('value','즉시 판매 계속');
			$('#btn_sale').attr('data-type',"1");
			$('.btn-direct input').css('background-color','#41B979')
			$('.btn-direct input').css('color','white');
			$('.btn-bid input').css('background-color','#ebebeb')
			$('.btn-bid input').css('color','black');
		});
		
		$('#input_bid').keyup(function(){
			let val = $(this).val();
			val = Number(val.replaceAll(',',''));
			if(isNaN(val)){
				$('#input_warn').text('숫자를 입력하세요').css('color','red');
				$(this).val('').focus();
				return;
			}else{
				val = val.toLocaleString('ko-KR');
				$(this).val(val);
				$('#input_warn').text('');
			}
		});
		
		$('#input_bid').change(function(){
			let val = $(this).val();
			val = Number(val.replaceAll(',',''));
			if(val.trim==''){
				$('#input_warn').text('희망가를 입력하세요').css('color','red');
				$(this).val('').focus();
				return;
			}
			
			if(val < 20000){
				$('#input_warn').text('2만원 이상을 입력하세요.').css('color','red');
				$(this).val('').focus();
				return;
			}
			
			if(val.toString().length > 9){
				$('#input_warn').text('숫자는 9자리까지 입력 가능합니다.').css('color','red');
				$(this).val('').focus();
				return;
			}
			
			if(val <= ${maxPurchaseBid} && ${maxPurchaseBid}!=0){
				$('#print_deadline').attr('data-deadline','1');
				$('#sale_method').text('').text('즉시 판매 하기');
				$('#direct_price').css('display','flex');
				$('#bid_price').css('display','none');
				$('#input_deadline').css('display','none');
				$('#btn_sale').attr('data-type','1');
				$('#btn_sale').attr('value','즉시 판매 계속');
				$('#input_bid').val(${maxPurchaseBid});
				$('.btn-direct input').css('background-color','#41B979')
				$('.btn-direct input').css('color','white');
				$('.btn-bid input').css('background-color','#ebebeb')
				$('.btn-bid input').css('color','black');
				return;
			}
			
			if(val > ${maxPurchaseBid} && val >= 20000){
				$('#input_warn').text('');
				return;
			}
		});
		
		$('.sale-deadline').each(function(){
			let deadline = $(this).attr('data-deadline');
			$(this).click(function(){
				initBtn();
				$('#print_deadline').text(deadline+'일').attr('data-deadline',deadline);
				let currentDate = new Date();
				currentDate.setDate(currentDate.getDate() + Number(deadline));
				$('#dateDeadline').attr('data-dateDeadline',currentDate);
				let year = currentDate.getFullYear();
				let month = (currentDate.getMonth() + 1);
				let day = currentDate.getDate();
				let formDate = year + '/' + month + '/' + day;
				$('#print_deadline').append(' ('+formDate+') 마감');
				$(this).css('background-color','#41B979');
				$(this).css('color','white');
			});
		});
		
		function initBtn(){
			$('.sale-deadline').each(function(){
				$(this).css('background-color','#fff');
				$(this).css('color','rgba(34,34,34,.8)');
			});
		};
	});
</script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssk/saleDetail.css">
<h1 id="sale_method" class="align-center">즉시 판매 하기</h1>
<div class="page-size-main">
	<div class="content">
		<div class="sale-inner">
			<div class="item">
				<div class="item-profile">
					<img src="${pageContext.request.contextPath}/item/viewProfile.do?item_num=${item.item_num}" width="130" height="130">
				</div>
				<div class="item-info">
					<p class="a">${item.item_brand}</p>
					<p class="b">${item.item_name}</p>
					<p class="c">${item.item_detail}</p>
					<c:if test="${empty item_size }">
						<p class="d">ONS SIZE</p>
					</c:if>
					<c:if test="${!empty item_size }">
						<p class="d">${item_size}</p>
					</c:if>
				</div>
			</div>
			<div class="sale-detail">
				<div class="price-list">
					<input type="hidden" value="${maxPurchaseBid}" name="maxPurchaseBid" id="maxPurchaseBid">
					<input type="hidden" value="${item_num}" name="item_num" id="item_num">
					<input type="hidden" value="${item_sizenum}" name="item_sizenum" id="item_sizenum">
					<input type="hidden" value="${item_size}" name="item_size" id="item_size">
					<input type="hidden" name="dateDeadline" id="dateDeadline">
					<ul>
						<li>
							<p>즉시 구매가</p>
							<c:if test="${minSaleBid == 0}">
								<span>-</span>
							</c:if>
							<c:if test="${minSaleBid != 0}">
								<span><fmt:formatNumber value="${minSaleBid}"/>원</span>		
							</c:if>
						</li>
						<li class="second">
							<p>즉시 판매가</p>
							<c:if test="${maxPurchaseBid == 0}">
								<span>-</span>
							</c:if>
							<c:if test="${maxPurchaseBid != 0}">
								<span><fmt:formatNumber value="${maxPurchaseBid}"/>원</span>		
							</c:if>
						</li>
					</ul>
				</div>
				<div class="sale-groups">
					<div class="sale-buttons">
						<ul class="tab-list">
							<li class="btn-bid">
								<input type="button" value="판매 입찰" id="sale_bid">
							</li>
							<li class="btn-direct">
								<c:if test="${purchaseBidCount != 0}">
									<input type="button" value="즉시 판매" id="sale_direct">
								</c:if>
								<c:if test="${purchaseBidCount == 0}">
									<input type="button" value="즉시 판매" id="sale_direct" disabled>
								</c:if>
							</li>
						</ul>
					</div>
					<div id="price_now">
						<dl id="direct_price">
							<dt>즉시판매가</dt>
							<dd>
								<span><fmt:formatNumber value="${maxPurchaseBid}"/>원</span>
							</dd>
						</dl>
						<dl id="bid_price" style="display:none;" class="bid-input">
							<dt>판매희망가<span id="input_warn"></span></dt>
							<dd>
								<input type="text" placeholder="희망가 입력" id="input_bid" value="${maxPurchaseBid}">
								<span>원</span>
							</dd>
						</dl>
						<div class="sale-note">
							<p>
								총 결제금액은 다음 화면에서 계산됩니다.
							</p>
						</div>
					</div>
				</div>
				<div id="input_deadline" style="display:none;">
					<div class="deadline-title">	
						입찰 마감기한
					</div>
					<div class="deadline-print">
						<span id="print_deadline"></span>
						<div class="deadline-select">
						<a class="sale-deadline" data-deadline="1">1일</a>
						<a class="sale-deadline" data-deadline="3">3일</a>
						<a class="sale-deadline" data-deadline="5">5일</a>
						<a class="sale-deadline" data-deadline="7">7일</a>
						<a class="sale-deadline" data-deadline="10">10일</a>
					</div>
					</div>
				</div>
				<div class="total-confirm">
					<div class="total-price">
						<dl>
							<dt><b>총 결제금액</b></dt>
							<dd>다음 화면에서 확인</dd>
						</dl>
					</div>
					<div id="btn_confirm">
						<input type="button" data-type="1" value="즉시 판매 계속" id="btn_sale">
					</div>
				</div>
			</div>
		</div>
	</div>
</div>