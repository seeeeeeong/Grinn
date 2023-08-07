$(function(){
	// ===예약 수량 변경
	$('#book_quantity').on('keyup mouseup', function(){
		if ($('#book_quantity').val() == ''){
			$('#book_total_txt').text('총 예약 금액: 0원');
			return;
		}
		if ($('#book_quantity').val() <= 0){
			$('#book_quantity').val('');
			return;
		}
		if (Number($('#booth_count').val()) < $('#book_quantity').val()){
			alert('수량이 부족합니다');
			$('#book_quantity').val();
			$('#book_total_txt').text('총 예약 금액: 0원');
			return;
		}
		
		let total = $('#booth_fee').val() * $('#book_quantity').val();
		$('#book_total_txt').text('총 예약 금액: ' + total.toLocaleString() + '원');
	});
	
	// ===예약 폼 제출===
	$('#market_cart').submit(function(event){
		if ($('#book_quantity').val() == ''){
			alert('예약 수량을 입력하세요');
			$('#book_quantity').focus();
			return false;
		}
	});
});