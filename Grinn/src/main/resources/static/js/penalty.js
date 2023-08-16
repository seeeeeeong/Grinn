$(function(){
	function OnOff(value){
	 	// 라디오 버튼 value 값 조건 비교
 		if(value == "1"){
  			document.querySelector('.type1').disabled = false; // 보여줌
 		}else if (value == "2"){
 			document.querySelector('.type2').disabled = false;
 		}else {
			document.querySelector('.type3').disabled = false;
		}
	}
/*	
	$('#pe_service_type1').click(function(){
            
    if($("input:radio[name=host_chk]:checked").val()=='select'){
        $("#hostOption").attr("disabled",false);
        $("#hostOption").removeClass("readonly");
    }else{
        $("#hostOption").attr("disabled",true);                    
        $("#hostOption").addClass("readonly");
    }
});

	$('#pe_service_type1').prop('checked', true);
	*/
});