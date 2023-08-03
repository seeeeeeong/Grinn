<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<script type="text/javascript" src="${pageContext.request.contextPath}/js/tradeSale.js"></script>    
<script type="text/javascript">
	$(function(){
		$('#btn_purchase_direct').show();
		$('#btn_purchase_bid').hide();
		$('#print_deadline').attr('data-deadline','1');
		
		if(${purchaseBidCount == 0}){
			$('#print_deadline').attr('data-deadline','');
			$('#sale_method').text('').text('판매 입찰 하기');
			$('#direct_price').css('display','none');
			$('#bid_price').css('display','block');
			$('#input_deadline').css('display','block');
			$('#btn_sale').attr('value','판매 입찰 계속');
			$('#btn_sale').attr('data-type',"2");
			$('#input_bid').val('');
		}
		
		$('#sale_bid').click(function(){
			$('#print_deadline').attr('data-deadline','');
			$('#sale_method').text('').text('판매 입찰 하기');
			$('#direct_price').css('display','none');
			$('#bid_price').css('display','block');
			$('#input_deadline').css('display','block');
			$('#btn_sale').attr('value','판매 입찰 계속');
			$('#btn_sale').attr('data-type',"2");
			$('#input_bid').val('');
		});
		$('#sale_direct').click(function(){
			$('#input_bid').val(${minSaleBid});
			$('#sale_method').text('').text('즉시 판매 하기');
			$('#direct_price').css('display','block');
			$('#bid_price').css('display','none');
			$('#input_deadline').css('display','none');
			$('#btn_sale').attr('value','즉시 판매 계속');
			$('#btn_sale').attr('data-type',"1");
			
		});
		
		$('#input_bid').change(function(){
			if($(this).val().trim==''){
				$('#input_warn').text('희망가를 입력하세요').css('color','red');
				$(this).val('').focus();
				return;
			}
			
			if($(this).val() < 20000){
				$('#input_warn').text('2만원 이상을 입력하세요.').css('color','red');
				$(this).val('').focus();
				return;
			}
			
			if($(this).val() <= ${maxPurchaseBid} && ${maxPurchaseBid}!=0){
				$('#print_deadline').attr('data-deadline','1');
				$('#sale_method').text('').text('즉시 판매 하기');
				$('#direct_price').css('display','block');
				$('#bid_price').css('display','none');
				$('#input_deadline').css('display','none');
				$('#btn_sale').attr('data-type','1');
				$('#btn_sale').attr('value','즉시 판매 계속');
				$('#input_bid').val(${maxPurchaseBid});
				return;
			}
			
			if($(this).val() > ${maxPurchaseBid} && $(this).val() >= 20000){
				$('#input_warn').text('');
				return;
			}
		});
		
		$('.sale_deadline').each(function(){
			let deadline = $(this).attr('data-deadline');
			$(this).click(function(){
				$('#print_deadline').text(deadline+'일').attr('data-deadline',deadline);
				let currentDate = new Date();
				currentDate.setDate(currentDate.getDate() + Number(deadline));
				$('#dateDeadline').attr('data-dateDeadline',currentDate);
				let year = currentDate.getFullYear();
				let month = (currentDate.getMonth() + 1);
				let day = currentDate.getDate();
				let formDate = year + '/' + month + '/' + day;
				$('#print_deadline').append('('+formDate+') 마감');
			});
		});
	});
</script>
<div class="page-main">
	<h1 id="sale_method">즉시 판매 하기</h1>	
	<div>
		아이템 정보가 들어가는 곳
	</div>
	
	<hr size="1" width="100%" noshade>
	
	<div class="align-center sale-detail">
		<div>
			<input type="hidden" value="${maxPurchaseBid}" name="maxPurchaseBid" id="maxPurchaseBid">
			<input type="hidden" value="${item_num}" name="item_num" id="item_num">
			<input type="hidden" value="${item_sizenum}" name="item_sizenum" id="item_sizenum">
			<input type="hidden" value="${item_size}" name="item_size" id="item_size">
			<input type="hidden" name="dateDeadline" id="dateDeadline">
			<p>즉시 구매가</p>
			<c:if test="${minSaleBid == 0}">
			<p>-</p>
			</c:if>
			<c:if test="${minSaleBid != 0}">
			<p>${minSaleBid}</p>		
			</c:if>
		</div>
		<div>
			<p>즉시 판매가</p>
			<c:if test="${maxPurchaseBid == 0}">
			<p>-</p>
			</c:if>
			<c:if test="${maxPurchaseBid != 0}">
			<p>${maxPurchaseBid}</p>		
			</c:if>
		</div>
		
		<hr size="1" width="100%" noshade>	
		
		<div>
			<input type="button" value="판매 입찰" id="sale_bid">
			<c:if test="${purchaseBidCount != 0}">
			<input type="button" value="즉시 판매" id="sale_direct">
			</c:if>
			<c:if test="${purchaseBidCount == 0}">
			<input type="button" value="즉시 판매" id="sale_direct" disabled>
			</c:if>
		</div>
		
		<div id="price_now">
			<table id="direct_price">
				<tr>
					<td>즉시판매가</td>
					<td>${maxPurchaseBid}</td>
				</tr>
				<tr>
					<td colspan="2">총 결제금액은 다음 화면에서 계산됩니다.</td>
				</tr>
			</table>
			
			<table id="bid_price" style="display:none;">
				<tr>
					<td>판매희망가</td>
					<td><span id="input_warn"></span></td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" placeholder="희망가 입력" id="input_bid" value="${maxPurchaseBid}">원</td>
				</tr>
				<tr>
					<td colspan="2">총 결제금액은 다음 화면에서 계산됩니다.</td>
				</tr>
			</table>
		</div>
		
		<div id="input_deadline" style="display:none;">
			<div>
				입찰 마감기한
			</div>
			<div>
				<span id="print_deadline"></span>
			</div>
			<div>
				<a class="sale_deadline" data-deadline="1">1일</a>
				<a class="sale_deadline" data-deadline="3">3일</a>
				<a class="sale_deadline" data-deadline="5">5일</a>
				<a class="sale_deadline" data-deadline="7">7일</a>
				<a class="sale_deadline" data-deadline="10">10일</a>
			</div>
		</div>
		<div>
			<ul>
				<li><b>총 결제금액</b></li>
				<li>다음 화면에서 확인</li>
			</ul>
		</div>
		<div id="btn_confirm">
			<input type="button" data-type="1" value="즉시 판매 계속" id="btn_sale">
		</div>
	</div>
</div>