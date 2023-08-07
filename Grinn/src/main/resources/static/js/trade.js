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
						output += '<p>배송주소</p>';
						output += '<ul>';
						output += '<li><span>받는분 </span> <span>'+param.member.mem_name+'</span></li>';
						output += '<li><span>연락처 </span> <span>'+param.member.mem_phone+'</span></li>';
						output += '<li><span>배송 주소 </span> <span>'+ param.member.mem_zipcode+' '+param.member.mem_address1+' '+param.member.mem_address2+'</span></li>';
						output += '</ul>';
						output += '</div>';
						output += '<hr size="1" width="100%" noshade>';
						
						output += '<div class="final-tradeInfo">';
						output += '<h3>최종 주문 정보</h3>'
						output += '<div class="align-center total-price">';
						output += '<p>총 결제금액</p>';
						output += '<p>'+total.toLocaleString('ko-KR')+'원</p>';
						output += '</div>';
						output += '<hr size="1" width="100%" noshade>';
						output += '<div class="align-center wish-price">';
						if(param.type=="2"){
							output += '<p>구매 희망가</p>';
						}else{
							output += '<p>즉시 구매가</p>';
						}
						output += '<p>'+param.purchase_price.toLocaleString('ko-KR')+'원</p>';
						output += '<p>검수비</p>';
						output += '<p>무료</p>';
						output += '<p>수수료</p>';
						output += '<p>'+fee.toLocaleString('ko-KR')+'원</p>';
						output += '<p>배송비</p>';
						output += '<p>'+ship.toLocaleString('ko-KR')+'원</p>';
						output += '<hr size="1" width="100%" noshade>'
						if(param.type=="2"){
							output += '<p>입찰 마감 기한</p>';
							output += '<p>'+param.deadline+'일 - '+param.dateDeadline+'까지</p>';
							output += '<hr size="1" width="100%" noshade>'
						}
						output += '</div>';
						output += '</div>';
						
						output += '<div class="purchase-check">';
						output += '<ul>';
						
						output += '<li>';
						output += '<a>';
						output += '<div>';
						output += '<p>판매자의 판매거부, 배송지연, 미입고 등의 사유가 발생할 경우, 거래가 취소될 수 있습니다.</p>';
						output += '<p>앱 알림 해제, 알림톡 차단, 전화번호 변경 후 미등록 시에는 거래 진행 상태 알림을 받을 수 없습니다.</p>';
						output += '</div>';
						output += '<div>';
						output += '<input type="checkbox" id="check1">';
						output += '</div>';
						output += '</a>';
						output += '</li>';
						
						output += '<li>';
						output += '<a>';
						output += '<div>';
						output += '<p>창고 보관을 선택한 경우, 구매자에게 배송되지 않고 KREAM 창고에 보관됩니다.</p>';
						output += '<p>검수 합격 후 보관이 완료되면 창고 이용료(현재 첫 30일 무료)가 결제됩니다.</p>';
						output += '</div>';
						output += '<div>';
						output += '<input type="checkbox" id="check2">';
						output += '</div>';
						output += '</a>';
						output += '</li>';
						
						output += '<li>';
						output += '<a>';
						output += '<div>';
						output += '<p>구매 입찰의 거래가 체결되면, 단순 변심이나 실수에 따른 구매 결정 후 취소는 불가합니다.</p>';
						output += '<p>본 거래는 개인간 거래로 전자상거래법(제17조)에 따른 청약철회(환불, 교환) 규정이 적용되지 않습니다. 단, 조작 실수 등을 고려하여 계정당 하루 1회 구매를 거부할 수 있습니다.</p>';
						output += '</div>';
						output += '<div>';
						output += '<input type="checkbox" id="check3">';
						output += '</div>';
						output += '</a>';
						output += '</li>';
						
						output += '<li>';
						output += '<a>';
						output += '<div>';
						output += '<p>구매 조건을 모두 확인하였으며, 입찰 진행에 동의합니다.</p>';
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
						output += '<p>총 결제금액</p>';
						output += '<p style="font-color:red;">'+total.toLocaleString('ko-KR')+'원</p>'
						output += '</div>';
						
						output += '<div>';
						if(param.type=="2"){
							output += '<form action="/purchase/purchasePaymentBid.do" method="post">';
							output += '<input type="hidden" name="item_num" id="item_num" value="'+param.item_num+'">';
							output += '<input type="hidden" name="item_sizenum" id="item_sizenum" value="'+param.item_sizenum+'">';
							output += '<input type="hidden" name="purchase_price" id="purchase_price" value="'+param.purchase_price+'">';
							output += '<input type="hidden" name="total" id="total" value="'+total+'">';
							output += '<input type="hidden" name="purchase_deadline" id="purchase_deadline" value="'+param.dateDeadline+'">';
							output += '<input type="submit" value="구매입찰하기">';
						}else{							
							output += '<form action="/purchase/purchasePaymentDirect.do" method="post">';
							output += '<input type="hidden" name="item_num" id="item_num" value="'+param.item_num+'">';
							output += '<input type="hidden" name="item_sizenum" id="item_sizenum" value="'+param.item_sizenum+'">';
							output += '<input type="hidden" name="sale_price" id="sale_price" value="'+param.purchase_price+'">';
							output += '<input type="hidden" name="trade_price" id="trade_price" value="'+total+'">';
							output += '<input type="hidden" name="trade_zipcode" id="trade_zipcode" value="'+param.member.mem_zipcode+'">';
							output += '<input type="hidden" name="trade_address1" id="trade_address1" value="'+param.member.mem_address1+'">';
							output += '<input type="hidden" name="trade_address2" id="trade_address2" value="'+param.member.mem_address2+'">';
							output += '<input type="submit" value="즉시구매하기">';
						}
						
						output += '</form>';
						output += '</div>';
						
						$('.purchase-detail').html(output);
					}else{
						alert('구매 입찰 통신 오류');
					}
				},
				error:function(){
					alert('네트워크 통신 오류');
				}
			});
		});
});