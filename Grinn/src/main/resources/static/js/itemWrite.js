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
});