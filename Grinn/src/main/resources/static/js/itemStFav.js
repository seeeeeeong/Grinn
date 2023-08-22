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
			console.log(st_num);
			$.ajax({
				url: '../style/writeFav.do',
				type: 'post',
				data: { st_num: st_num },
				dataType: 'json',
				success: function(param) {
					if (param.result == 'logout') {
						alert('로그인 후 이용 가능합니다.');
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
	