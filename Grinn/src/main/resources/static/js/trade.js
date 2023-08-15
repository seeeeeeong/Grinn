$(function(){
			
		// 구매 입찰 버튼 클릭시 
		$(document).on('click','#btn_purchase',function(){
			let type = $('#btn_purchase').attr('data-type');
			let dateDeadline = new Date();
			let year = dateDeadline.getFullYear();
			let month = (dateDeadline.getMonth() + 1);
			let day = dateDeadline.getDate();
			
			if(type=="2"){
				if($('#input_bid').val().trim() == ''){
					alert('희망 하는 구매 입찰가를 입력하세요!');
					$('#input_bid').val('').focus();
					return;
				}
				
				if($('#print_deadline').attr('data-deadline') == null || $('#print_deadline').attr('data-deadline') == ''  ){
					alert('입찰 마감 기한을 선택하세요!');
					return;
				}
				dateDeadline = new Date($('#dateDeadline').attr('data-dateDeadline'));
				year = dateDeadline.getFullYear();
				month = (dateDeadline.getMonth() + 1);
				day = dateDeadline.getDate();
			}
			dateDeadline = year+'-'+month+'-'+day;
			
			$.ajax({
				url: '../purchase/paymentPurchaseBid.do',
				type: 'post',
				data:{
					type:type,
					minSaleBid:$('#minSaleBid').val(),
					item_num:$('#item_num').val(),
					item_sizenum:$('#item_sizenum').val(),
					item_size:$('#item_size').val(),
					deadline:$('#print_deadline').attr('data-deadline'),
					purchase_price:$('#input_bid').val().replaceAll(',',''),
					dateDeadline:dateDeadline
				},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인은 필수입니다!');
						location.href='../member/login.do';
					}else if(param.result == 'duplicated'){
						alert('입찰 정보를 등록한 기록이 있습니다!');
					}else if(param.result == 'success'){
						$('.purchase-detail').empty();
						let output = '';
						let fee = Math.ceil(param.purchase_price * 0.1);
						let ship = 0;
						if(param.purchase_price < 50000){
							ship = 3000;
						}
						let total = param.purchase_price + fee + ship;
						output += '<div class="delivery-info">';
						output += '<div class="delivery-address">';
						output += '<div class="delivery-address-title">';
						output += '<h3>배송주소</h3>';
						output += '</div>';
						output += '<div class="delivery-address-detail">';
						output += '<div class="address-info">';
						output += '<div class="address-detail-info">';
						output += '<dl class="info-list">';
						output += '<div class="info-box">';
						output += '<dt>받는 분</dt>';
						output += '<dd>'+param.member.mem_name+'</dd>';
						output += '</div>';
						output += '<div class="info-box">';
						output += '<dt>연락처</dt>';
						output += '<dd>'+param.member.mem_phone+'</dd>';
						output += '</div>';
						output += '<div class="info-box">';
						output += '<dt>배송 주소</dt>';
						output += '<dd>'+ param.member.mem_zipcode+' '+param.member.mem_address1+' '+param.member.mem_address2+'</dd>';
						output += '</div>';
						output += '</dl>';
						output += '</div>';
						output += '</div>';
						output += '<div class="address-req">';
						output += '</div>';
						output += '</div>';
						output += '</div>';
						output += '</div>';
						
						output += '<div class="final-tradeInfo">';
						output += '<div class="final-order-title">';
						output += '<h3>최종 주문 정보</h3>'
						output += '</div>';
						output += '<div class="final-order-content">';
						output += '<div class="final-order-group">';
						output += '<div class="final-total-price">';
						output += '<dl>';
						output += '<dt>총 결제금액</dt>';
						output += '<dd>'+total.toLocaleString('ko-KR')+'원</dd>';
						output += '</dl>';
						output += '</div>';
						output += '<div class="price-detail">';
						output += '<dl>';
						if(param.type=="2"){
							output += '<dt>구매 희망가</dt>';
						}else{
							output += '<dt>즉시 구매가</dt>';
						}
						output += '<dd>'+param.purchase_price.toLocaleString('ko-KR')+'원</dd>';
						output += '</dl>';
						output += '<dl>';
						output += '<dt>검수비</dt>';
						output += '<dd>무료</dd>';						
						
						output += '</dl>';
						output += '<dl>';
						output += '<dt>수수료</dt>';
						output += '<dd>'+fee.toLocaleString('ko-KR')+'원</dd>';						
						
						output += '</dl>';
						output += '<dl>';
						output += '<dt>배송비</dt>';
						output += '<dd>'+ship.toLocaleString('ko-KR')+'원</dd>';						
						
						output += '</dl>';
						output += '</div>';
						output += '<div class="bid-deadline">';
						if(param.type=='2'){
							output += '<dl>';
							output += '<dt>입찰 마감 기한</dt>';
							output += '<dd>'+param.deadline+'일 - '+param.dateDeadline+'까지</dd>';						
							output += '</dl>';	
						}
						output += '</div>';
						output += '</div>';
						output += '</div>';
						output += '</div>';
						
						output += '<div class="check-purchase">';
						output += '<ul class="check-list">';
						output += '<li class="check-item" style="border-top:none;">';
						output += '<a class="check-a">';
						output += '<div class="check-group">';
						output += '<p class="check-main">';
						output += '판매자의 판매거부, 배송지연, 미입고 등의 사유가 발생할 경우, 거래가 취소될 수 있습니다.';
						output += '</p>';
						output += '<p class="check-sub">';
						output += '앱 알림 해제, 알림톡 차단, 전화번호 변경 후 미등록 시에는 거래 진행 상태 알림을 받을 수 없습니다.';
						output += '</p>';
						output += '</div>';
						output += '<div class="checkbox-item">';
						output += '<input type="checkbox" id="check1">';
						output += '<label for="check1"></label>';
						output += '</div>';
						output += '</a>';
						output += '</li>';
						output += '<li class="check-item">';
						output += '<a class="check-a">';
						output += '<div class="check-group">';
						output += '<p class="check-main">';
						output += '창고 보관을 선택한 경우, 구매자에게 배송되지 않고 KREAM 창고에 보관됩니다.';
						output += '</p>';
						output += '<p class="check-sub">';
						output += '검수 합격 후 보관이 완료되면 창고 이용료(현재 첫 30일 무료)가 결제됩니다.';
						output += '</p>';
						output += '</div>';
						output += '<div class="checkbox-item">';
						output += '<input type="checkbox" id="check2">';
						output += '<label for="check2"></label>';
						output += '</div>';
						output += '</a>';
						output += '</li>';
						output += '<li class="check-item">';
						output += '<a class="check-a">';
						output += '<div class="check-group">';
						output += '<p class="check-main">';
						output += '구매 입찰의 거래가 체결되면, 단순 변심이나 실수에 따른 구매 결정 후 취소는 불가합니다.';
						output += '</p>';
						output += '<p class="check-sub">';
						output += '본 거래는 개인간 거래로 전자상거래법(제17조)에 따른 청약철회(환불, 교환) 규정이 적용되지 않습니다. 단, 조작 실수 등을 고려하여 계정당 하루 1회 구매를 거부할 수 있습니다.';
						output += '</p>';
						output += '</div>';
						output += '<div class="checkbox-item">';
						output += '<input type="checkbox" id="check3">';
						output += '<label for="check3"></label>';
						output += '</div>';
						output += '</a>';
						output += '</li>';
						output += '<li class="check-item">';
						output += '<a class="check-a">';
						output += '<div class="check-group">';
						output += '<p class="check-main">';
						output += '구매 조건을 모두 확인하였으며, 입찰 진행에 동의합니다.';
						output += '</p>';
						output += '<p class="check-sub">';
						output += '검수 합격 후 보관이 완료되면 창고 이용료(현재 첫 30일 무료)가 결제됩니다.';
						output += '</p>';
						output += '</div>';
						output += '<div class="checkbox-item">';
						output += '<input type="checkbox" id="check4">';
						output += '<label for="check4"></label>';
						output += '</div>';
						output += '</a>';
						output += '</li>';
						output += '</ul>';
						output += '</div>';
						output += '<div class="total-buy-confirm">';
						output += '<div class="final-total-price">';
							
						output += '</div>';
						output += '<div class="total-btn-confirm">';
						if(param.type=="2"){
							output += '<form action="/purchase/purchasePaymentBid.do" method="post" id="newForm">';
							output += '<input type="hidden" name="item_num" id="item_num" value="'+param.item_num+'">';
							output += '<input type="hidden" name="item_sizenum" id="item_sizenum" value="'+param.item_sizenum+'">';
							output += '<input type="hidden" name="purchase_price" id="purchase_price" value="'+param.purchase_price+'">';
							output += '<input type="hidden" name="total" id="total" value="'+total+'">';
							output += '<input type="hidden" name="purchase_deadline" id="purchase_deadline" value="'+param.dateDeadline+'">';
							output += '<input type="submit" id="btn_final_purchase" value="구매입찰하기">';
						}else{							
							output += '<form action="/purchase/purchasePaymentDirect.do" method="post" id="newForm">';
							output += '<input type="hidden" name="item_num" id="item_num" value="'+param.item_num+'">';
							output += '<input type="hidden" name="item_sizenum" id="item_sizenum" value="'+param.item_sizenum+'">';
							output += '<input type="hidden" name="trade_price" id="trade_price" value="'+param.purchase_price+'">';
							output += '<input type="hidden" name="total" id="total" value="'+total+'">';
							output += '<input type="hidden" name="trade_zipcode" id="trade_zipcode" value="'+param.member.mem_zipcode+'">';
							output += '<input type="hidden" name="trade_address1" id="trade_address1" value="'+param.member.mem_address1+'">';
							output += '<input type="hidden" name="trade_address2" id="trade_address2" value="'+param.member.mem_address2+'">';
							output += '<input type="submit" id="btn_final_purchase" value="즉시구매하기">';
						}
						
						output += '</form>';
						output += '</div>';
						output += '</div>';
						$('.purchase-detail').html(output);
						checking();
					}else{
						alert('구매 입찰 통신 오류');
					}
				},
				error:function(){
					alert('네트워크 통신 오류');
				}
			});
		});
		function checking(){
			if($('#check1').is(':checked') && $('#check2').is(':checked') && $('#check4').is(':checked') && $('#check3').is(':checked')){
				$('#btn_final_purchase').prop('disabled',false);
				$('#btn_final_purchase').css('background-color','#fa7070');
				$('#btn_final_purchase').css('color','white');
			}else{
				$('#btn_final_purchase').css('background-color','#ebebeb');
				$('#btn_final_purchase').css('color','black');
				$('#btn_final_purchase').prop('disabled',true);
				$('#btn_final_purchase').removeAttr('cursor');	
			}
		}		
		checking();
		$(document).on("click", ".check-a", function() {
		  let index = $(".check-a").index(this);
		  let id = 'check' + (index+1);
		  
		  if ($('#'+id).is(':checked')) {
		    $('#' + id).prop('checked', false);
		  } else {
		    $('#' + id).prop('checked', true);
		  }
		  checking();
		});

});