$(function(){
	let rowCount = 10;
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
					let stoutput = '<div class="item">';
					stoutput += '<h2>Style</h2>'
					stoutput += '<ul class="detail-info">';
					stoutput += '<li>';
					stoutput += '<img src="../member/viewProfile.do?mem_num='+ item.mem_num+'" width="40" height="40" class="my-photo">';
					stoutput += '</li>';
					stoutput += '<li>';
					stoutput += item.id + '<br>';
					stoutput += '</li>';
					stoutput += '</ul>';
					stoutput += '<div class="sub-item">';
					stoutput += '<p>' + item.st_phrase.replace(/\r\n/g,'<br>') + '</p>';
					stoutput += '<hr size="1" noshade>';
					stoutput += '</div>';
					stoutput += '</div>';
					
					//문서 객체 추가
					$('#stoutput').append(stoutput);
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
		selectList(currentPage + 1);
	});

	
	//댓글 수 표시
	function displayReplyCount(data){
		let count = data.count;
		let stoutput;
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