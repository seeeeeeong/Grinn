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
				url: '../sale/paymentSaleBid.do',
				type: 'post',
				data:{
					type:type,
					maxPurchaseBid:$('#maxPurchaseBid').val(),
					item_num:$('#item_num').val(),
					item_sizenum:$('#item_sizenum').val(),
					item_size:$('#item_size').val(),
					deadline:$('#print_deadline').attr('data-deadline'),
					sale_price:$('#input_bid').val(),
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
						output += '<p>반송주소</p>';
						output += '<ul>';
						output += '<li><span>받는분 </span> <span>'+param.member.mem_name+'</span></li>';
						output += '<li><span>연락처 </span> <span>'+param.member.mem_phone+'</span></li>';
						output += '<li><span>반송 주소 </span> <span>'+ param.member.mem_zipcode+' '+param.member.mem_address1+' '+param.member.mem_address2+'</span></li>';
						output += '</ul>';
						output += '</div>';
						output += '<hr size="1" width="100%" noshade>';
						
						output += '<div class="final-tradeInfo">';
						output += '<h3>최종 주문 정보</h3>'
						output += '<div class="align-center total-price">';
						output += '<p>총 정산금액</p>';
						output += '<p>'+total.toLocaleString('ko-KR')+'원</p>';
						output += '</div>';
						output += '<hr size="1" width="100%" noshade>';
						output += '<div class="align-center wish-price">';
						if(param.type=="2"){
							output += '<p>판매 희망가</p>';
						}else{
							output += '<p>즉시 판매가</p>';
						}
						output += '<p>'+param.sale_price.toLocaleString('ko-KR')+'원</p>';
						output += '<p>검수비</p>';
						output += '<p>무료</p>';
						output += '<p>수수료</p>';
						output += '<p>'+fee.toLocaleString('ko-KR')+'원</p>';
						output += '<p>배송비</p>';
						output += '<p>선불 - 판매자 부담 (발송 시 정산금액에서 차감)</p>';
						output += '<hr size="1" width="100%" noshade>'
						if(param.type=="2"){
							output += '<p>입찰 마감 기한</p>';
							output += '<p>'+param.deadline+'일 - '+param.dateDeadline+'까지</p>';
							output += '<hr size="1" width="100%" noshade>'
						}
						output += '</div>';
						output += '</div>';
						
						output += '<div class="sale-check">';
						output += '<ul>';
						
						output += '<li>';
						output += '<a>';
						output += '<div>';
						output += '<p>거래가 체결되면 일요일 · 공휴일을 제외하고 48시간 내에 KREAM으로 발송을 완료한 후, 발송 정보를 정확히 입력해야 합니다.</p>';
						output += '<p>착불 배송 시 판매 금액에서 차감 정산하며, 미정산 시 별도 고지없이 해당 금액을 결제 시도할 수 있습니다.</p>';
						output += '</div>';
						output += '<div>';
						output += '<input type="checkbox" id="check1">';
						output += '</div>';
						output += '</a>';
						output += '</li>';
						
						output += '<li>';
						output += '<a>';
						output += '<div>';
						output += '<p>송장 번호 미기재·오입력 시 입고가 진행되지 않으며, 발송 후 5일(일요일·공휴일 제외) 내 미도착은 허위 정보 입력으로 간주하여 미입고 페널티를 부과합니다.</p>';
						output += '<p>앱 알림 해제, 알림톡 차단, 전화번호 변경 후 미등록 시에는 거래 진행 상태 알림을 받을 수 없으며 이로 인한 거래 실패는 판매자의 책임입니다.</p>';
						output += '</div>';
						output += '<div>';
						output += '<input type="checkbox" id="check2">';
						output += '</div>';
						output += '</a>';
						output += '</li>';
						
						output += '<li>';
						output += '<a>';
						output += '<div>';
						output += '<p>검수 기준과 페널티 및 이용 정책을 다시 한번 확인하였습니다.</p>';
						output += '<p>이용정책 위반 시, 판매 금액의 최대 15.0%의 페널티가 부과됩니다. 페널티 회피 시 이후 거래가 제한되며 별도 고지없이 해당 금액을 결제 시도할 수 있습니다.</p>';
						output += '</div>';
						output += '<div>';
						output += '<input type="checkbox" id="check3">';
						output += '</div>';
						output += '</a>';
						output += '</li>';
						
						output += '<li>';
						output += '<a>';
						output += '<div>';
						output += '<p>판매 조건을 모두 확인하였으며, 입찰 진행에 동의합니다.</p>';
						output += '</div>';
						output += '<div>';
						output += '<input type="checkbox" id="check4">';
						output += '</div>';
						output += '</a>';
						output += '</li>';
						
						output += '</ul>';
						output += '</div>';
						
						output += '<hr size="1" width="100%" noshade>';
						
						output += '<div class="total-price">'
						output += '<p>총 정산금액</p>';
						output += '<p style="font-color:red;">'+total.toLocaleString('ko-KR')+'원</p>'
						output += '</div>';
						
						output += '<div>';
						if(param.type=="2"){
							output += '<form action="/sale/salePaymentBid.do" method="post">';
							output += '<input type="hidden" name="item_num" id="item_num" value="'+param.item_num+'">';
							output += '<input type="hidden" name="item_sizenum" id="item_sizenum" value="'+param.item_sizenum+'">';
							output += '<input type="hidden" name="sale_price" id="sale_price" value="'+param.sale_price+'">';
							output += '<input type="hidden" name="total" id="total" value="'+total+'">';
							output += '<input type="hidden" name="sale_deadline" id="sale_deadline" value="'+param.dateDeadline+'">';
							output += '<input type="submit" value="판매입찰하기">';
						}else{							
							output += '<form action="/sale/salePaymentDirect.do" method="post">';
							output += '<input type="hidden" name="item_num" id="item_num" value="'+param.item_num+'">';
							output += '<input type="hidden" name="item_sizenum" id="item_sizenum" value="'+param.item_sizenum+'">';
							output += '<input type="hidden" name="purchase_price" id="purchase_price" value="'+param.sale_price+'">';
							output += '<input type="hidden" name="trade_price" id="trade_price" value="'+total+'">';
							output += '<input type="hidden" name="trade_zipcode" id="trade_zipcode" value="'+param.member.mem_zipcode+'">';
							output += '<input type="hidden" name="trade_address1" id="trade_address1" value="'+param.member.mem_address1+'">';
							output += '<input type="hidden" name="trade_address2" id="trade_address2" value="'+param.member.mem_address2+'">';
							output += '<input type="submit" value="즉시판매하기">';
						}
						output += '</form>';
						output += '</div>';
						
						$('.sale-detail').html(output);
					}else{
						alert('판매 입찰 통신 오류');
					}
				},
				error:function(){
					alert('네트워크 통신 오류');
				}
			});
		});
});