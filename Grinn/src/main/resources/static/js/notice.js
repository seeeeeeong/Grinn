$(function() {
	$('#ch1').click(function() {
		$('.description_wrap1').css('display', 'block');
		$('.description_wrap2').css('display', 'none');
		$('.description_wrap3').css('display', 'none');
		$('.description_wrap4').css('display', 'none');
		$('.description_wrap5').css('display', 'none');
		$('.description_wrap6').css('display', 'none');

		$('#ch1').css('color', '#222222');
		$('#ch2').css('color', '#909090');
		$('#ch3').css('color', '#909090');
		$('#ch4').css('color', '#909090');
		$('#ch5').css('color', '#909090');
		$('#ch6').css('color', '#909090');
	});
	$('#ch2').click(function() {
		$(this).css('color', 'black');
		$('.description_wrap1').css('display', 'none');
		$('.description_wrap2').css('display', 'block');
		$('.description_wrap3').css('display', 'none');
		$('.description_wrap4').css('display', 'none');
		$('.description_wrap5').css('display', 'none');
		$('.description_wrap6').css('display', 'none');

		$('#ch1').css('color', '#909090');
		$('#ch2').css('color', '#222222');
		$('#ch3').css('color', '#909090');
		$('#ch4').css('color', '#909090');
		$('#ch5').css('color', '#909090');
		$('#ch6').css('color', '#909090');
	});
	$('#ch3').click(function() {
		$(this).css('color', 'black');
		$('.description_wrap1').css('display', 'none');
		$('.description_wrap2').css('display', 'none');
		$('.description_wrap3').css('display', 'block');
		$('.description_wrap4').css('display', 'none');
		$('.description_wrap5').css('display', 'none');
		$('.description_wrap6').css('display', 'none');

		$('#ch1').css('color', '#909090');
		$('#ch2').css('color', '#909090');
		$('#ch3').css('color', '#222222');
		$('#ch4').css('color', '#909090');
		$('#ch5').css('color', '#909090');
		$('#ch6').css('color', '#909090');
	});
	$('#ch4').click(function() {
		$(this).css('color', 'black');
		$('.description_wrap1').css('display', 'none');
		$('.description_wrap2').css('display', 'none');
		$('.description_wrap3').css('display', 'none');
		$('.description_wrap4').css('display', 'block');
		$('.description_wrap5').css('display', 'none');
		$('.description_wrap6').css('display', 'none');

		$('#ch1').css('color', '#909090');
		$('#ch2').css('color', '#909090');
		$('#ch3').css('color', '#909090');
		$('#ch4').css('color', '#222222');
		$('#ch5').css('color', '#909090');
		$('#ch6').css('color', '#909090');
	});
	$('#ch5').click(function() {
		$(this).css('color', 'black');
		$('.description_wrap1').css('display', 'none');
		$('.description_wrap2').css('display', 'none');
		$('.description_wrap3').css('display', 'none');
		$('.description_wrap4').css('display', 'none');
		$('.description_wrap5').css('display', 'block');
		$('.description_wrap6').css('display', 'none');

		$('#ch1').css('color', '#909090');
		$('#ch2').css('color', '#909090');
		$('#ch3').css('color', '#909090');
		$('#ch4').css('color', '#909090');
		$('#ch5').css('color', '#222222');
		$('#ch6').css('color', '#909090');
	});
	$('#ch6').click(function() {
		$(this).css('color', 'black');
		$('.description_wrap1').css('display', 'none');
		$('.description_wrap2').css('display', 'none');
		$('.description_wrap3').css('display', 'none');
		$('.description_wrap4').css('display', 'none');
		$('.description_wrap5').css('display', 'none');
		$('.description_wrap6').css('display', 'block');

		$('#ch1').css('color', '#909090');
		$('#ch2').css('color', '#909090');
		$('#ch3').css('color', '#909090');
		$('#ch4').css('color', '#909090');
		$('#ch5').css('color', '#909090');
		$('#ch6').css('color', '#222222');
	});
});