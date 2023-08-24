$(function(){
	let item_list = []; // 투표 항목(상품) 저장
	
	
	//회원 정보 검색
	$('#item_search').keyup(function(){
		if($('#item_search').val().trim()==''){
			$('#search_area').empty();
			return;
		}
		//서버와 통신
		$.ajax({
			url:'itemSearchAjax.do',
			type:'post',
			data:{item_name:$('#item_search').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					$('#item_search').attr('disabled',true);
					$('#item_search').val('로그인해야 회원 검색이 가능합니다.');
				}else if(param.result == 'success'){
					$('#search_area').empty();
					$(param.item).each(function(index,item){
						if(!item_list.includes(item.item_name)){
							let output = '';
							output += '<li data-num="'+item.item_num+'">';
							output += '<img src="../poll/viewPhotoByItem_num.do?item_num=' + item.item_num + '" width="30" height="30">';
							output += item.item_name;
							output += '</li>';
							$('#search_area').append(output);
						}	
					});
				}else{
					alert('회원 검색 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	// 검색된 상품 선택하기
	$(document).on('click','#search_area li',function(){
		let item_name = $(this).text(); //선택한 상품이름
		let item_num = $(this).attr('data-num'); //선택한 상품번호
		if(item_list.length <= 3) {
			item_list.push(item_name);
		} else {
			alert('최소 2개 최대 4개 선택 가능');
			$('#item_search').val('');
			$('#search_area').empty();
		}
		
		//선택한 상품을 화면에 표시
        let choice_id = '<div class="item-span" data-name=' + item_name + '">';
        choice_id += '<input type="hidden" name="poll_items" value="' + item_num + '" width="40" height="40" data-num="' + item_num + '">';
        choice_id += '<img src="../poll/viewPhotoByItem_num.do?item_num=' + item_num + '" width="40" height="40" data-num="' + item_num + '">';
	    choice_id += '<span>' + item_name + '</span><br></div>';
		$('#poll_item').append(choice_id);
		$('#item_search').val('');
		$('#search_area').empty(); //ul 태그 초기화
		
	});
	
	//선택한 상품 삭제하기
	$(document).on('click','.item-span',function(){
		let item_name = $(this).attr('data-id');
		// 상품이 저장된 배열에서 삭제할 상품의 item_name 제거
		item_list.splice(item_list.indexOf(item_name),1);
		$(this).remove();//이벤트가 발생한 태그 제거
		$('.item-span').val('');
		if($('#poll_item span').length == 0){
			$('#name_span').text('');
			$('.item-span').empty();
		}
		
	});
	
	
	
	
	
});








