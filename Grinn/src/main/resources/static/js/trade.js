$(function(){
			
		// 구매 입찰 버튼 클릭시 
		$('#btn_purchase_bid').click(function(){
			if($('#input_bid').val().trim() == ''){
				alert('희망 하는 구매 입찰가를 입력하세요!');
				$('#input_bid').val('').focus();
				return;
			}
			
			if($('#print_deadline').attr('data-deadline') == null){
				alert('입찰 마감 기한을 선택하세요!');
				return;
			}
			
			$.ajax({
				url: '../purchase/paymentPurchaseBid.do',
				type: 'post',
				data:{
					minSaleBid:$('#minSaleBid').val(),
					item_num:$('#item_num').val(),
					item_sizenum:$('#item_sizenum').val(),
					item_size:$('#item_size').val(),
					deadline:$('#print_deadline').attr('data-deadline'),
					purchase_price:$('#input_bid').val()
				},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인은 필수입니다!');
					}else if(param.result == 'duplicated'){
						alert('입찰 정보를 등록한 기록이 있습니다!');
					}else if(param.result == 'success'){
						alert('일단 통신 성공');
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