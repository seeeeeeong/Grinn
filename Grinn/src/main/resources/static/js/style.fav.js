$(function(){
	//좋아요 읽기
	//좋아요 선택 여부와 선택한 총개수 표시
	function selectFav(st_num){
		$.ajax({
			url:'getFav.do',
			type:'post',
			data:{st_num:st_num},
			dataType:'json',
			success:function(param){
				displayFav(param);
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	}//end of selectFav
	//좋아요 등록/삭제
	$('#output_fav').click(function(){
		$.ajax({
			url:'writeFav.do',
			type:'post',
			data:{st_num:$('#output_fav').attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인 후 이용 가능합니다.');
					location.href='/member/login.do';
				}else if(param.result == 'success'){
					displayFav(param);
				}else{
					alert('등록시 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});//end of click
	
	//좋아요 표시 공통 함수
	function displayFav(param){
		let output;
		if(param.status=='yesFav'){
			output = '../images/yes_like.png';
		}else if(param.status=='noFav'){
			output = '../images/no_like.png';
		}else{
			alert('좋아요 표시 오류 발생');
		}
		//문서 객체에 추가
		$('#output_fav').attr('src',output);
		$('#output_fcount').text("좋아요 " + param.count + "개");
	}//end of displayFav
	//초기 데이터 표시
	selectFav($('#output_fav').attr('data-num'));
});