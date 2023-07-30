$(function(){
	let checkId = 0;
	
	$('#confirmId').click(function(){
		if($('#mem_id').val().trim()==''){
			$('#message_id').css('color','red').text('아이디를 입력하세요');
			$('#mem_id').val('').focus();
		}
		$('#message_id').text('');
		$.ajax({
			url : 'confirmId.do',
			type : 'post',
			data : {id:$('#mem_id').val()},
			dataType : 'json',
			success : function(param){
				if(param.result == 'idNotFound'){
					$('#message_id').css('color','#000').text('등록가능한 아이디입니다.');
					checkId = 1;
				}else if(param.result == 'idDuplicated'){
					$('#message_id').css('color','red').text('중복된 아이디입니다.');
					$('#mem_id').val('').focus();
					checkId = 0;
				}else if(param.result == 'notMatchPattern'){
					$('#message_id').css('color','red').text('영문, 숫자 포함 4자이상 12자이하 입력 필수');
					$('#mem_id').val('').focus();
					checkId = 0;
				}else{
					checkId = 0;
					alert('ID중복체크 오류');
				}
			},
			error:function(){
				checkId = 0;
				alert('네트워크 오류 발생');
			}
		});		
	});
	
	$('#member_register #mem_id').keydown(function(){
		checkId = 0;
		$('#message_id').text('');
	});
	
	$('#member_register').submit(function(){
		if(checkId == 0){
			$('#message_id').css('color','red').text('아이디 중복 체크 필수');
			if($('#mem_id').val().trim() == ''){
				$('#mem_id').val('').focus();
			}
			return false;
		}
	});
});
