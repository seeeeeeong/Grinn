$(function(){
	let rowCount = 4;
	let currentPage;
	let count;
	
	//댓글 목록
	function selectList(pageNum){
		currentPage = pageNum;
		
		//로딩이미지 노출
		$('#loading').show();
		//서버와 통신
		$.ajax({
			url:'itemStList.do',
			type:'post',
			data:{pageNum:pageNum,rowCount:rowCount,item_num:$('#stoutput').attr('data-itemnum')},
			dataType:'json',
			success:function(param){
				//로딩이미지 감추기
				$('#loading').hide();
				count = param.count;
				
				if(pageNum == 1){
					//처음 호출시는 해당 ID의 div의 내부 내용물을 제거
					$('#stoutput').empty();
				}
				
				//댓글수 읽어오기
				displayReplyCount(param);
	
				
				//댓글 목록
				$(param.list).each(function(index,item){
					let stoutput = '<div class="stylelist01">';
					stoutput += '<a href="/style/detail.do?st_num='+item.st_num+'">';
					stoutput += '<img src="../style/viewPhoto1.do?st_num='+item.st_num+'" class="stylept">';
					stoutput += '<ul class="detail-style">';
					stoutput += '<li>';
					stoutput += '<img src="../member/viewProfile.do?mem_num='+ item.mem_num+'" width="25" height="25" class="my-photo">';
					stoutput += '</li>';
					stoutput += '<li>';
					stoutput +=  item.mem_id + '<br>';
					stoutput += '</li>';
					stoutput += '</ul>';
					stoutput += '<div class="sub-style">';
					if(item.st_phrase!=null){
						stoutput += '<p>' +item.st_phrase.replace(/\r\n/g,'<br>') + '</p>'
					}
					stoutput += '</div>';
					stoutput += '</a>';
					stoutput += '<div class="like-button">';
					stoutput += '<img class="output_fav" data-num="' + item.st_num + '" src="../images/no_like.png">';
					stoutput += '<span class="output_fcount" data-num="'+item.st_num+'"></span>';
					stoutput += '</div>';
					stoutput += '</div>';
					
					
					//문서 객체 추가
					$('#stoutput').append(stoutput);
				});
				
				$('.output_fav').each(function() {
					let st_num = $(this).attr('data-num');
					//console.log('st_num : ' + st_num);
					selectFav(st_num);
				});
				
				//paging button 처리
				if(currentPage >= Math.ceil(count/rowCount)){
					//다음 페이지가 없음
					$('.paging-button').hide();
				}else{
					//다음페이지가 존재
					$('.paging-button').show();
				}
			},
			error:function(){
				//로딩 이미지 감추기
				$('#loading').hide();
				alert('네트워크 오류 발생');
			}
		});
	}
	//다음 댓글 보기 버튼 클릭시 데이터 추가
	$('.paging-button input').click(function(){
		let item_num = $('#stoutput').data('itemnum');
		location.href='../item/listStyle.do?item_num='+item_num;
		//selectList(currentPage + 1);
	});

	
	//댓글 수 표시
	function displayReplyCount(data){
		let count = data.count;
		let stoutput;
		console.log('count : '+data.count);
		if(count==0){
			stoutput = '댓글수(0)';
		}else{
			stoutput = '댓글수('+count+')';
		}
		//문서 객체 추가
		$('#output_rcount').text(stoutput);
	}

	//초기 데이터(목록) 호출
	selectList(1);
});	
	