$(function(){
			
	// 판매 입찰 버튼 클릭시 
	$(document).on('click','#btn_sale',function(){
		let type = $('#btn_sale').attr('data-type');
		let dateDeadline = new Date();
		let year = dateDeadline.getFullYear();
		let month = (dateDeadline.getMonth() + 1);
		let day = dateDeadline.getDate();
		
		if(type=="2"){
			if($('#input_bid').val().trim() == ''){
				alert('희망 하는 판매 입찰가를 입력하세요!');
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
			url: '../sale/paymentSaleBid.do',
			type: 'post',
			data:{
				type:type,
				maxPurchaseBid:$('#maxPurchaseBid').val(),
				item_num:$('#item_num').val(),
				item_sizenum:$('#item_sizenum').val(),
				item_size:$('#item_size').val(),
				deadline:$('#print_deadline').attr('data-deadline'),
				sale_price:$('#input_bid').val().replaceAll(',',''),
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
					$('.sale-detail').empty();
					let output = '';
					let fee = Math.ceil(param.sale_price * 0.1);
					let total = param.sale_price - fee;
					output += '<div class="delivery-info">';
					output += '<div class="delivery-address">';
					output += '<div class="delivery-address-title">';
					output += '<h3>반송주소</h3>';
					if(param.member.mem_zipcode == null || param.member.mem_zipcode == ''){
							output += '<a class="add-ship-info">+ 배송지 입력</a>';	
					}else{
						output += '<a class="add-ship-info">+ 배송지 변경</a>';
					}
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
					output += '<dt>반송 주소</dt>';
					if(param.member.mem_zipcode == null || param.member.mem_zipcode == ''){
						output += '<dd class="info-ship">반송 배송지를 입력해주세요.</dd>';
					}else{
						output += '<dd class="info-ship">'+param.member.mem_address1+' '+param.member.mem_address2+'</dd>';	
					}
					
					output += '</div>';
					output += '</dl>';
					output += '</div>';
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
					output += '<dt>총 정산금액</dt>';
					output += '<dd>'+total.toLocaleString('ko-KR')+'원</dd>';
					output += '</dl>';
					output += '</div>';
					output += '<div class="price-detail">';
					output += '<dl>';
					if(param.type=="2"){
						output += '<dt>핀매 희망가</dt>';
					}else{
						output += '<dt>즉시 판매가</dt>';
					}
					output += '<dd>'+param.sale_price.toLocaleString('ko-KR')+'원</dd>';
					output += '</dl>';
					output += '<dl>';
					output += '<dt>검수비</dt>';
					output += '<dd>무료</dd>';						
					
					output += '</dl>';
					output += '<dl>';
					output += '<dt>수수료</dt>';
					output += '<dd>-'+fee.toLocaleString('ko-KR')+'원</dd>';						
					
					output += '</dl>';
					output += '<dl>';
					output += '<dt>배송비</dt>';
					output += '<dd>선불 - 판매자 부담 </dd>';						
					
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
					
					output += '<div class="check-sale">';
					output += '<ul class="check-list">';
					output += '<li class="check-item" style="border-top:none;">';
					output += '<a class="check-a">';
					output += '<div class="check-group">';
					output += '<p class="check-main">';
					output += '거래가 체결되면 일요일 · 공휴일을 제외하고 48시간 내에 KREAM으로 발송을 완료한 후, 발송 정보를 정확히 입력해야 합니다.';
					output += '</p>';
					output += '<p class="check-sub">';
					output += '착불 배송 시 판매 금액에서 차감 정산하며, 미정산 시 별도 고지없이 해당 금액을 결제 시도할 수 있습니다.';
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
					output += '송장 번호 미기재·오입력 시 입고가 진행되지 않으며, 발송 후 5일(일요일·공휴일 제외) 내 미도착은 허위 정보 입력으로 간주하여 미입고 페널티를 부과합니다.';
					output += '</p>';
					output += '<p class="check-sub">';
					output += '앱 알림 해제, 알림톡 차단, 전화번호 변경 후 미등록 시에는 거래 진행 상태 알림을 받을 수 없으며 이로 인한 거래 실패는 판매자의 책임입니다.';
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
					output += '검수 기준과 페널티 및 이용 정책을 다시 한번 확인하였습니다.';
					output += '</p>';
					output += '<p class="check-sub">';
					output += '이용정책 위반 시, 판매 금액의 최대 15.0%의 페널티가 부과됩니다. 페널티 회피 시 이후 거래가 제한되며 별도 고지없이 해당 금액을 결제 시도할 수 있습니다.';
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
					output += '판매 조건을 모두 확인하였으며, 입찰 진행에 동의합니다.';
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
					output += '<div class="total-sale-confirm">';
					output += '<div class="final-total-price">';
						
					output += '</div>';
					output += '<div class="total-sale-confirm">';
						if(param.type=="2"){
							output += '<form action="/sale/salePaymentBid.do" method="post" id="newForm">';
							output += '<input type="hidden" name="item_num" id="item_num" value="'+param.item_num+'">';
							output += '<input type="hidden" name="item_sizenum" id="item_sizenum" value="'+param.item_sizenum+'">';
							output += '<input type="hidden" name="sale_price" id="sale_price" value="'+param.sale_price+'">';
							output += '<input type="hidden" name="total" id="total" value="'+total+'">';
							output += '<input type="hidden" name="sale_deadline" id="sale_deadline" value="'+param.dateDeadline+'">';
							output += '<input type="hidden" name="trade_zipcode" id="trade_zipcode" value="'+param.member.mem_zipcode+'">';
							output += '<input type="hidden" name="trade_address1" id="trade_address1" value="'+param.member.mem_address1+'">';
							output += '<input type="hidden" name="trade_address2" id="trade_address2" value="'+param.member.mem_address2+'">';
							output += '<input type="submit" id="btn_final_sale" value="판매입찰하기">';
						}else{							
							output += '<form action="/sale/salePaymentDirect.do" method="post" id="newForm">';
							output += '<input type="hidden" name="item_num" id="item_num" value="'+param.item_num+'">';
							output += '<input type="hidden" name="item_sizenum" id="item_sizenum" value="'+param.item_sizenum+'">';
							output += '<input type="hidden" name="purchase_price" id="purchase_price" value="'+param.sale_price+'">';
							output += '<input type="hidden" name="trade_zipcode" id="trade_zipcode" value="'+param.member.mem_zipcode+'">';
							output += '<input type="hidden" name="trade_address1" id="trade_address1" value="'+param.member.mem_address1+'">';
							output += '<input type="hidden" name="trade_address2" id="trade_address2" value="'+param.member.mem_address2+'">';
							output += '<input type="submit" id="btn_final_sale" value="즉시판매하기">';
						}
					
					output += '</form>';
					output += '</div>';
					output += '</div>';
					$('.sale-detail').html(output);
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
			$('#btn_final_sale').prop('disabled',false);
			$('#btn_final_sale').css('background-color','#41B979');
			$('#btn_final_sale').css('color','white');
		}else{
			$('#btn_final_sale').css('background-color','#ebebeb');
			$('#btn_final_sale').css('color','black');
			$('#btn_final_sale').prop('disabled',true);
			$('#btn_final_sale').removeAttr('cursor');	
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
	
	$(document).on("click",".add-ship-info",function(){
			$('#modalWrap').css('display','block');
				
			$('#main').css('opacity','1');
			$('body').css('overflow','hidden').css('padding-right','17px');
		});
		$('#modal_close').click(function(){
			$('#modalWrap').css('display','none');
			$('#main').removeAttr('style');
			$('body').removeAttr('style');
		});
		
		$(document).on("click","#modal_save",function(){
			if($('#zipcode').val().trim() == ''){
				alert('우편번호를 입력하세요.');
				return;
			}
			if($('#address1').val().trim() == ''){
				alert('우편번호를 입력하세요.');
				return;
			}
			if($('#address2').val().trim() == ''){
				alert('상세주소를 입력하세요.');
				return;
			}
			
			$('.info-ship').text($('#address1').val() + ' ' + $('#address2').val());
			$('.info-ship').css('color','black');
			$('#trade_zipcode').val($('#zipcode').val());
			$('#trade_address1').val($('#address1').val());
			$('#trade_address2').val($('#address2').val());
			
			$('#modalWrap').css('display','none');
			$('#main').removeAttr('style');
			$('body').removeAttr('style');
		});
		
		$(document).on("click","#btn_final_purchase",function(){
			if($('.info-ship').text().trim() == '반송 배송지를 입력해주세요.'){
				$('html, body').scrollTop($(".item").offset().top);
				$('.info-ship').css('color','red');
				return false;
			}
		});

});