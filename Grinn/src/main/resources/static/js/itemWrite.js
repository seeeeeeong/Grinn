$(function(){
	//MyPage 프로필 사진 등록 및 수정
	//수정버튼 이벤트 처리/ok
	$('#photo_btn').click(function(){
		$('#photo_choice').show();
		$(this).hide();
	});
	
	//처음 화면에 보여지는 이미지 읽기/ok
	let photo_path = $('.my-photo').attr('src');
	let my_photo; //업로드하고자 선택한 이미지 저장
	$('#upload').change(function(){
		my_photo = this.files[0];
		if(!my_photo){
			$('.my-photo').attr('src',photo_path);
			return;
		}
		
		if(my_photo.size > 1024 * 1024){
			alert(Math.round(my_photo.size/1024)+'kbytes(1024kbytes까지만 업로드 가능)');
			$('.my-photo').attr('src',my_photo);
			$(this).val('');
			return;
		}
		
		//이미지 미리보기 처리/ok
		let reader = new FileReader();
		reader.readAsDataURL(my_photo);
		
		reader.onload = function(){
			$('.my-photo').attr('src',reader.result);
		};
	});
	
	/*//파일업로드 처리
	//올리면 배열에 저장해놓기
	$(document).ready(function(){
		//유효성검사
		$('#addBtn').click(function(){
			if($('#upload').val==''){
			alert('파일을 선택하세요');
			$('#upload').focus();
			return;
		}
		document.itemWrite.action
		})
	})*/
	//취소 버튼 처리
	$('#photo_reset').click(function(){
		$('.my-photo').attr('src',photo_path);
		$('#upload').val('');
		$('#photo_choice').hide();
		$('#photo_btn').show();
	});
	
		
	// 관심상품
    $(function() {
        // 좋아요 읽기
        // 좋아요 선택여부와 선택한 총개수 표시
        function selectFav(item_num) {
            $.ajax({
                url: 'getFav.do',
                type: 'post',
                data: { item_num: item_num },
                dataType: 'json',
                success: function(param) {
                    displayFav(param, item_num); // 수정된 부분
                },
                error: function() {
                    alert('네트워크 오류 발생');
                }
            });
        } // end of selectFav

        // 좋아요 표시 공통 함수
        function displayFav(param, item_num) { // 수정된 부분
            let outputSelector = '.output_fav[data-num="' + item_num + '"]';
            let outputCountSelector = '.output_fcount[data-num="' + item_num + '"]';
            let output;

            if (param.status == 'yesFav') {
                output = '../images/save_black.png';
            } else if (param.status == 'noFav') {
                output = '../images/save_blank.png';
            } else {
                alert('좋아요 표시 오류 발생');
            }

            // 문서 객체에 추가
            $(outputSelector).attr('src', output);
            $(outputCountSelector).text(param.count);
        } // end of displayFav

        // 좋아요 등록/삭제
        $(document).on('click', '.output_fav', function() {
            let item_num = $(this).attr('data-num');
            $.ajax({
                url: 'writeFav.do',
                type: 'post',
                data: { item_num: item_num },
                dataType: 'json',
                success: function(param) {
                    if (param.result == 'logout') {
                        alert('로그인 후 좋아요를 눌러주세요!');
                    } else if (param.result == 'success') {
                        displayFav(param, item_num); // 수정된 부분
                    } else {
                        alert('등록시 오류 발생');
                    }
                },
                error: function() {
                    alert('네트워크 오류 발생');
                }
            });
        });

        // 초기 데이터 표시
        $('.output_fav').each(function() {
            let item_num = $(this).attr('data-num');
            selectFav(item_num);
        });
    });
});