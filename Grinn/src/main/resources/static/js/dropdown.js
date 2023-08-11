
	$(document).ready(function($){
		var $drop = $("#drop");
			$drop.div = $drop.find("> div");
			$drop.p = $drop.div.find("> p");
			$drop.b = $drop.find("> b");
		
		$drop.p.bind("click",function(e){
			if($(this).parent('').next('b').is(':hidden')){
				$(this).parent("div").attr("class","dropdown_head").siblings("div").removeClass("dropdown_head");
				$(this).parent("b").next("b").slideDown(150,"swing").siblings("b").slideUp(150,"swing");
			}else{
				$drop.div.removeClass("dropdown_head");
				$drop.b.slideUp(150,"swing");
			}
			$(this).focus();
			return false;
		});
	});
	
/*	$(function() {
	$('#imgOpen').click(function(){
		$('.dropdown_content').css({
			'display':'block'
		});
	});
});	*/