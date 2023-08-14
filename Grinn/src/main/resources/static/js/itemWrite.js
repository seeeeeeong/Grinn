$(function(){
	//MyPage 프로필 사진 등록 및 수정
	//수정버튼 이벤트 처리/ok
	$('#photo_btn').click(function(){
		$('#photo_choice').show();
		$(this).hide();
	});
	
	//처음 화면에 보여지는 이미지 읽기/ok
	let photo_path = $('.item-photo').attr('src');
	let my_photo; //업로드하고자 선택한 이미지 저장
	$('#upload').change(function(){
		my_photo = this.files[0];
		if(!my_photo){
			$('.item-photo').attr('src',photo_path);
			return;
		}
		
		if(my_photo.size > 1024 * 1024){
			alert(Math.round(my_photo.size/1024)+'kbytes(1024kbytes까지만 업로드 가능)');
			$('.item-photo').attr('src',my_photo);
			$(this).val('');
			return;
		}
		
		//이미지 미리보기 처리/ok
		let reader = new FileReader();
		reader.readAsDataURL(my_photo);
		
		reader.onload = function(){
			$('.item-photo').attr('src',reader.result);
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
		$('.item-photo').attr('src',photo_path);
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
/*
	$(document).ready(function() {
		// 메뉴 클릭 이벤트 처리
		$("#allLink, #shoesLink, #topsLink, #bottomsLink, #accessoriesLink").click(function() {
			// 모든 링크에서 active 클래스 제거
			$("#page_nav1 ul li a").removeClass("active");

			// 클릭한 링크에 active 클래스 추가
			$(this).addClass("active");
		});
	});*/
	
	var acc = document.getElementsByClassName("accordion");
	var i;

	for (i = 0; i < acc.length; i++) {
		acc[i].addEventListener("click", function() {
			this.classList.toggle("active");
			var panel = this.nextElementSibling;
			if (panel.style.maxHeight) {
				panel.style.maxHeight = null;
			} else {
				panel.style.maxHeight = panel.scrollHeight + "px";
			}
		});
	}

	//textarea에 내용 입력시 글자수 체크
	$(document).on('keyup', '#review_content', function() {
		// 입력한 글자수 구하기
		let inputLength = $(this).val().length;

		if (inputLength > 300) { // 300자를 넘어선 경우
			$(this).val($(this).val().substring(0, 300))
		} else { // 300자 이하인 경우
			// 남은 글자수 구하기
			let remain = 300 - inputLength;
			remain += '/300';
			$('.letter-count').text(remain);
		}
	});
	

    const tabLinks = document.querySelectorAll('.tab-link');

    tabLinks.forEach(link => {
        link.addEventListener('click', (event) => {
            // 이전에 선택된 탭에서 active 클래스 제거
            const previouslyActiveTab = document.querySelector('.tab-link.active');
            if (previouslyActiveTab) {
                previouslyActiveTab.classList.remove('active');
            }
            
            // 클릭된 탭에 active 클래스 추가
            event.target.classList.add('active');
            
            // 클릭된 탭의 data-tab 속성 값 가져오기
            const selectedTab = event.target.getAttribute('data-tab');
            
            // 선택한 탭에 대한 페이지로 이동
            location.href = `itemList.do?tab=${selectedTab}`;
        });
    });

	$('#order').change(function() {
    	const selectedTab = $('[data-tab].active').attr('data-tab'); // 현재 선택된 탭 가져오기
    	const keyfield = $('#keyfield').val();
    	const keyword = $('#keyword').val();
    	const order = $('#order').val();
    
    	const url = `itemList.do?tab=${selectedTab}&keyfield=${keyfield}&keyword=${keyword}&order=${order}`;
    	location.href = url;
	});
	
	//관리자 상품 삭제
	$(document).on('click','.delete-btn',function(){
		let choice = confirm('삭제하시겠습니까?');
		if(!choice){
			return;
		}
		//서버와 통신
		$.ajax({
			url:'itemDelete.do',
			type:'post',
				//key	value
			data:{item_num:$('#output').attr('data-itemnum')},
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인해야 삭제할 수 있습니다.');
				}else if(param.result=='success'){
					alert('삭제완료');
					location.href="../item/itemAdminList.do";
				}else if(param.result=='wrongAccess'){
					alert('잘못된 경로입니다.');
				}else{
					alert('상품 삭제 오류 발생');
				}
			},
			error:function(param){
				alert('네트워크 오류 발생!');
			}
			
		});
		
	});
});