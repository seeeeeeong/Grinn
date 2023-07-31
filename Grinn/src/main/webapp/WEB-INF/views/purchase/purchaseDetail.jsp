<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function(){
		$('#btn_purchase_direct').show();
		$('#btn_purchase_bid').hide();
		
		$('#purchase_bid').click(function(){
			$('#purchase_method').text('').text('구매 입찰 하기');
			$('#direct_price').css('display','none');
			$('#bid_price').css('display','block');
			$('#input_deadline').css('display','block');
			$('#btn_purchase_direct').hide();
			$('#btn_purchase_bid').show();
		});
		$('#purchase_direct').click(function(){
			$('#purchase_method').text('').text('즉시 구매 하기');
			$('#direct_price').css('display','block');
			$('#bid_price').css('display','none');
			$('#input_deadline').css('display','none');
			$('#btn_purchase_direct').show();
			$('#btn_purchase_bid').hide();
		});
		
		$('#input_bid').change(function(){
			if($(this).val().trim==''){
				$('#input_warn').text('희망가를 입력하세요').css('color','red');
				$(this).val('').focus();
			}
			
			if($(this).val() < 20000){
				$('#input_warn').text('2만원 이상을 입력하세요.').css('color','red');
				$(this).val('').focus();
			}
			
			if($(this).val() > ${minSaleBid}){
				$('#purchase_method').text('').text('즉시 구매 하기');
				$('#direct_price').css('display','block');
				$('#bid_price').css('display','none');
				$('#input_deadline').css('display','none');
			}
			
			if($(this).val() <= ${minSaleBid} && $(this).val() >= 20000){
				$('#input_warn').text('');
			}
		});
		
		$('.purchase_deadline').each(function(){
			let deadline = $(this).attr('data-deadline');
			$(this).click(function(){
				$('#print_deadline').text(deadline+'일').attr('data-deadline',deadline);
				let currentDate = new Date();
				currentDate.setDate(currentDate.getDate() + Number(deadline));
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
	<h1 id="purchase_method">즉시 구매 하기</h1>	
	<div>
		아이템 정보가 들어가는 곳
	</div>
	
	<hr size="1" width="100%" noshade>
	
	<div class="align-center">
		<div>
			<p>즉시 구매가</p>
			<p>${minSaleBid}</p>
		</div>
		<div>
			<p>즉시 판매가</p>
			<p>${maxPurchaseBid}</p>
		</div>
		
		<hr size="1" width="100%" noshade>	
		
		<div>
			<input type="button" value="구매 입찰" id="purchase_bid">
			<input type="button" value="즉시 구매" id="purchase_direct">
		</div>
		
		<div id="price_now">
			<table id="direct_price">
				<tr>
					<td>즉시구매가</td>
					<td>${minSaleBid}</td>
				</tr>
				<tr>
					<td colspan="2">총 결제금액은 다음 화면에서 계산됩니다.</td>
				</tr>
			</table>
			
			<table id="bid_price" style="display:none;">
				<tr>
					<td>구매희망가</td>
					<td><span id="input_warn"></span></td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" placeholder="희망가 입력" id="input_bid">원</td>
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
				<span id="print_deadline"></span> (언제 마감?)
			</div>
			<div>
				<a class="purchase_deadline" data-deadline="1">1일</a>
				<a class="purchase_deadline" data-deadline="3">3일</a>
				<a class="purchase_deadline" data-deadline="5">5일</a>
				<a class="purchase_deadline" data-deadline="7">7일</a>
				<a class="purchase_deadline" data-deadline="10">10일</a>
			</div>
		</div>
		<div>
			<ul>
				<li><b>총 결제금액</b></li>
				<li>다음 화면에서 확인</li>
			</ul>
		</div>
		<div id="btn_confirm">
			<input type="button" value="즉시 구매 계속" id="btn_purchase_direct">
			<input type="button" value="구매 입찰 계속" id="btn_purchase_bid">
		</div>
	</div>
</div>