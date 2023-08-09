$(function(){
	
	//======댓글=========
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
			url:'listReview.do',
			type:'post',
			data:{pageNum:pageNum,rowCount:rowCount,item_num:$('#output').attr('data-itemnum')},
			dataType:'json',
			success:function(param){
				//로딩이미지 감추기
				$('#loading').hide();
				count = param.count;
				
				if(pageNum == 1){
					//처음 호출시는 해당 ID의 div의 내부 내용물을 제거
					$('#output').empty();
				}
				
				//댓글수 읽어오기
				//displayReviewCount(param);
	
				
				//댓글 목록
				$(param.list).each(function(index,item){
					let output = '<div class="item">';
					output += '<ul class="detail-info">';
					output += '<li>';
					output += '<img src="../user/viewProfile.do?mem_num='+ item.mem_num+'" width="40" height="40" class="my-photo">';
					output += '</li>';
					output += '<li>';
					if(item.nick_name){
						output += item.mem_nickname + '<br>';
					}else{
						output += item.mem_id + '<br>';
					}
					if(item.review_modifydate){//수정일이 존재한다면
						output += '<span class="modify-date"> 최근 수정일 : ' + item.review_modifydate + '</span>';
					}else{
						output += '<span class="modify-date"> 등록일 : ' + item.review_modifydate + '</span>';
					}
					output += '</li>';
					output += '</ul>';
					output += '<div class="sub-item">';
					output += '<p>' + item.review_content.replace(/\r\n/g,'<br>') + '</p>';
					if(param.user_num==item.mem_num){
						//로그인한 회원번호가 댓글 작성자 회원번호와 같으면
						output += ' <input type="button" data-num="'+item.review_num+'" value="수정" class="modify-btn">';
						output += ' <input type="button" data-num="'+item.review_num+'" value="삭제" class="delete-btn">';
					}
					output += '<hr size="1" noshade>';
					output += '</div>';
					output += '</div>';
					
					//문서 객체 추가
					$('#output').append(output);
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
	
	//초기 데이터(목록) 호출
	selectList(1);
});