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
					let stoutput = '<a href="/style/detail.do?st_num='+item.st_num+'">';
					stoutput += '<div>';
					//stoutput += '<h2>Style</h2>'
					stoutput += '<img src="../style/viewPhoto1.do?st_num='+item.st_num+'" width="100" height="100">';
					stoutput += '<ul class="detail-info">';
					stoutput += '<li>';
					stoutput += '<img src="../member/viewProfile.do?mem_num='+ item.mem_num+'" width="20" height="20" class="my-photo">';
					stoutput += '</li>';
					stoutput += '<li>';
					stoutput +=  item.mem_id + '<br>';
					stoutput += '</li>';
					stoutput += '</ul>';
					stoutput += '<div class="sub-item">';
					stoutput += '<p>' +item.st_phrase.replace(/\r\n/g,'<br>') + '</p>'
					stoutput += '</a>';
					stoutput += '<div class="like-button">';
					stoutput += '<img class="output_fav" data-num="' + item.st_num + '" src="../images/no_like.png" width="20" height="20">';
					stoutput += '<span class="output_fcount" data-num="'+item.st_num+'"></span>';
					stoutput += '</div>';
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
	//좋아요 읽기
	//좋아요 선택 여부와 선택한 총개수 표시
		function selectFav(st_num) {
			$.ajax({
				url: '../style/getFav.do',
				type: 'post',
				data: { st_num: st_num },
				dataType: 'json',
				success: function(param) {
					displayFav(param, st_num);
				},
				error: function() {
					alert('네트워크 오류 발생');
				}
			});
		}//end of selectFav
		//좋아요 표시 공통 함수
		function displayFav(param, st_num) {
			let outputSelector = '.output_fav[data-num="' + st_num + '"]';
			let outputCountSelector = '.output_fcount[data-num="' + st_num + '"]';
			let output;
			if (param.status == 'yesFav') {
				output = '../images/yes_like.png';
			} else if (param.status == 'noFav') {
				output = '../images/no_like.png';
			} else {
				alert('좋아요 표시 오류 발생');
			}
			//문서 객체에 추가
			$(outputSelector).attr('src', output);
			$(outputCountSelector).text(param.count);
		}//end of displayFav

		//좋아요 등록/삭제
		$(document).on('click', '.output_fav', function() {
			let st_num = $(this).attr('data-num');
			$.ajax({
				url: '../style/writeFav.do',
				type: 'post',
				data: { st_num: st_num },
				dataType: 'json',
				success: function(param) {
					if (param.result == 'logout') {
						alert('로그인 후 이용 가능합니다.');
						location.href = '/member/login.do';
					} else if (param.result == 'success') {
						displayFav(param, st_num);
					} else {
						alert('등록시 오류 발생');
					}
				},
				error: function() {
					alert('네트워크 오류 발생');
				}
			});
		});//end of click
	
	//초기 데이터(목록) 호출
	selectList(1);
});	
	