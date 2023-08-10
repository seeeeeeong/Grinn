$(function(){
	/*$('#to').datepicker({
	   dateFormat: 'yy-mm-dd' //Input Display Format 변경
       ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
       ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
       ,changeYear: true //콤보박스에서 년 선택 가능
       ,changeMonth: true //콤보박스에서 월 선택 가능                
       ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
       ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
       ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
       ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
       ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
       ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
       ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
       ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
       ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
       ,minDate:0 //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
       ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후) 
	});
	*/
	
	
    // 초기값을 오늘 날짜로 설정
    $('#from-to').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	
   var dateFormat = "yy-mm-dd",
      from = $( "#from-to" )
        .datepicker({
          showMonthAfterYear: true, //연도,달 순서로 지정
		  yearSuffix: "년",
          changeMonth: true,//달 변경 지정
          dateFormat:"yy-mm-dd",//날짜 포맷
          dayNamesMin: ["일", "월", "화", "수", "목", "금", "토" ],//요일 이름 지정
          monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],//월 이름 지정
          minDate:0 //오늘 이전 날짜를 선택할 수 없음
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate(this) );//종료일의 minDate 지정
        }),
      to = $( "#from-to2" ).datepicker({
     	showMonthAfterYear: true,  
		yearSuffix: "년",
        changeMonth: true,
        dateFormat:"yy-mm-dd",
        dayNamesMin: ["일", "월", "화", "수", "목", "금", "토" ],
        monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
        minDate:'+1D' //내일부터 선택가능, 지정형식 예(+1D +1M +1Y)
      })
      .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate(this) );//시작일의 maxDate 지정
      });
 
    function getDate(element) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
        if(element.id == 'from'){
        date.setDate(date.getDate()+3);//종료일은 시작보다 하루 이후부터 지정할 수 있도록 설정
        }else{
         date.setDate(date.getDate()-1);//시작일은 종료일보다 하루 전부터 지정할 수 있도록 설정
        }
      } catch( error ) {
        date = null;
      }
      return date;
    }	
	
	
	// ===종료 날짜 먼저 선택 시 시작 날짜의 값이 없으면 알림===
	$('#from-to2').on('keyup mouseup', function(){
		if($('#from-to').val() == ''){
			alert('시작일을 먼저 입력하시기 바랍니다.');
			$('#from-to').focus();
			return;
		}
	});
	
	$('#book_count').on('keyup mouseup', function(){
		if($('#book_count').val() == ''){
			$('#booth_total_txt').text('총 예약 금액 : 0원');
		}
		
		if($('#book_count').val() < 0){
			$('#book_count').val('');
			return;
		}
		
		let total = $('#book_count').val() * $('#booth_fee').val();
		$('#booth_total_txt').text('총 예약 금액 : ' + total.toLocaleString() + '원');
		
	});
	
	// ===날짜 선택 예약===
	$('#book_btn').submit(function(event){
		if ($('#book_count').val() == ''){
			alert('수량을 입력하세요');
			$('#book_count').focus();
			return false;
		}
		
		if ($('#book_count').val() == 0){
			alert('수량을 입력하세요');
			$('#book_count').focus();
			return false;
		}
		
		let form_data = $(this).serialize();
		
		// 서버와 통신
		$.ajax({
			url:'completeDate.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if (param.result == 'logout'){
					alert('로그인 후 사용하세요');
				} else if (param.result == 'success'){
					alert('예약 확정 단계로 넘어갑니다');
					location.href='checkBooking.do';
				} else if (param.result == 'alreadyBooked'){
					alert('이미 예약하셨습니다');
				} else {
					alert('플리마켓 예약 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생')
			}
		});
		event.preventDefault();
	});         
});