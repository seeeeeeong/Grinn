function showDiv(element) {
	var tag = document.getElementsByClassName("polling-item");
	
	for(var i=0; i<tag.length; i++) {
		// className이 box인 요소(poll1Box, poll2Box, poll3Box, poll4Box가 하나의 배열로 생성)를 찾아
		// tag라는 변수에 대입. 이것을 반복문으로 돌려서 tag의 길이만큼 4번 반복.
		// 전달받은 버튼 요소 객체의 아이디값 중에 Box라는 문자열을 붙였을 때의 값이 
		// tag의 i번째 아이디와 동일하다면 
		// i번째 태그 스타일을 display 속성에 접근해서 block으로 변경.
		// 그렇지 않으면 none으로 변경
		if(element.id + "Box" == tag[i].id)
			tag[i].style.display = "block";
		else
			tag[i].style.display = "none";
	}
}

document.addEventListener("DOMContentLoaded", function () {
    const pollingItems = document.querySelectorAll(".polling-item");

    pollingItems.forEach((item) => {
      item.addEventListener("click", function () {
        // 라디오 버튼을 클릭하는 동작 구현
        const radioButton = item.querySelector("input[type='radio']");
        if (radioButton) {
          radioButton.checked = true;
          // 투표 결과에 대한 동작을 구현하는 곳
          // 투표 결과를 표시하는 코드를 추가..?
          output = "<<polling>>";
       }
     });
   });
 });
 
 document.addEventListener("DOMContentLoaded", function () {
    const pollingItems = document.querySelectorAll(".polling-item");

    pollingItems.forEach((item) => {
      item.addEventListener("click", function () {
        // 클래스 토글을 사용하여 선택된 상태를 변경합니다.
        this.classList.toggle("selected");

        // 선택된 버튼을 제외한 나머지 버튼의 클래스를 초기화합니다.
        pollingItems.forEach((otherItem) => {
          if (otherItem !== this) {
            otherItem.classList.remove("selected");
          }
        });
      });
    });
  });
 


function showResult() {
	$.ajax({
		url: 'getPollingCount.do',
		type: 'post',
		data: {poll_num:$('#pollNum').attr('data-id')},
		dataType: 'json',
		success: function(param){
			if(param.result == 'success'){
				let resultId1 = $('#radioCheck1').val(); 
				let resultId2 = $('#radioCheck2').val();
				let resultId3 = $('#radioCheck3').val();
				let resultId4 = $('#radioCheck4').val();
				
				if(param.list[0].item_num == resultId1){
					$('#poll1Box div').append(param.list[0].poll_count);
				}
				if(param.list[0].item_num == resultId2){
					$('#poll2Box div').append(param.list[1].poll_count);
				}
				if(param.list[0].item_num == resultId3){
					$('#poll3Box div').append(param.list[2].poll_count);
				}
				if(param.list[0].item_num == resultId4){
					$('#poll4Box div').append(param.list[3].poll_count);
				}
				
				if(param.list[1].item_num == resultId1){
					$('#poll1Box div').append(param.list[0].poll_count);
				}
				if(param.list[1].item_num == resultId2){
					$('#poll2Box div').append(param.list[1].poll_count);
				}
				if(param.list[1].item_num == resultId3){
					$('#poll3Box div').append(param.list[2].poll_count);
				}
				if(param.list[1].item_num == resultId4){
					$('#poll4Box div').append(param.list[3].poll_count);
				}
				
				if(param.list[2].item_num == resultId1){
					$('#poll1Box div').append(param.list[0].poll_count);
				}
				if(param.list[2].item_num == resultId2){
					$('#poll2Box div').append(param.list[1].poll_count);
				}
				if(param.list[2].item_num == resultId3){
					$('#poll3Box div').append(param.list[2].poll_count);
				}
				if(param.list[2].item_num == resultId4){
					$('#poll4Box div').append(param.list[3].poll_count);
				}
				
				if(param.list[3].item_num == resultId1){
					$('#poll1Box div').append(param.list[0].poll_count);
				}
				if(param.list[3].item_num == resultId2){
					$('#poll2Box div').append(param.list[1].poll_count);
				}
				if(param.list[3].item_num == resultId3){
					$('#poll3Box div').append(param.list[2].poll_count);
				}
				if(param.list[3].item_num == resultId4){
					$('#poll4Box div').append(param.list[3].poll_count);
				}
			}else{
				alert('투표수 조회 오류 발생');
			}
		},
		error: function(){
			alert('네트워크 오류 발생');
		}
	})
	
    var radios = document.getElementsByName("polling-option");
    var resultElements = document.querySelectorAll('#result');
    resultElements.forEach(function(resultElement) {
        resultElement.innerHTML = "투표수";
    });
}

function pollClick() {
	if($('#radioCheck1').is(":checked")) {
		let item_num = $('#radioCheck1').val();
		let poll_num = $('#radioCheck1').attr('data-num');
		location.href='writePolling.do?poll_num=' + poll_num + '&item_num=' + item_num;
	} 
	if($('#radioCheck2').is(":checked")) {
		let item_num = $('#radioCheck2').val();
		let poll_num = $('#radioCheck2').attr('data-num');
		location.href='writePolling.do?poll_num=' + poll_num + '&item_num=' + item_num;
	} 
	if($('#radioCheck3').is(":checked")) {
		let item_num = $('#radioCheck3').val();
		let poll_num = $('#radioCheck3').attr('data-num');
		location.href='writePolling.do?poll_num=' + poll_num + '&item_num=' + item_num;
	} 
	if($('#radioCheck4').is(":checked")) {
		let item_num = $('#radioCheck4').val();
		let poll_num = $('#radioCheck4').attr('data-num');
		location.href='writePolling.do?poll_num=' + poll_num + '&item_num=' + item_num;
	} 
}
/*
$(function(){
	function selectPoll_item(poll_num){
		$.ajax({
			url: 'getPolling',
			type: 'post',
			data: {poll_num:poll_num},
			dataType: 'json',
			success: function(param) {
				displayPoll(param);
			},
			error: function(){
				alert('네트워크 오류');
			}
		})
	}
	
	$('#poll_result').click(function(){
		$.ajax({
			url: 'writePolling',
			type: 'post',
			data: {poll_num:$('#poll_result').attr('data-num')},
			dataType: 'json',
			success: function(param) {
				if(param.result=='logout'){
					alert('로그인 후 이용 가능합니다.');
					location.href='/member/login.do';
				}else if(param.result == 'success'){
					displayPoll(param);
				}else{
					alert('등록시 오류 발생');
				}
			},
			error: function(){
				alert('네트워크 오류');
			}
		})
	})
	
	function displayPoll(param){
			let output;
			if(param.status=='yesPoll'){
				alert('투표 성공')
			}else if(param.status=='noPoll'){
				alert('투표 취소')
			}else{
				alert('투표 오류 발생');
			}
			//문서 객체에 추가
			$('#poll_result').attr('src',output);
			$('#output_pcount').text("총 투표수 " + param.count + "표");
		}
		selectPoll_item($('#poll_result').attr('data-num'));
})
*/

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 