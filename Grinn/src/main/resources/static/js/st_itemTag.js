//파일 선택 이벤트 핸들러
   function handleFileSelection(fileNumber) {
       const upload1 = document.getElementById('upload1');
       const upload2 = document.getElementById('upload2');
       const upload3 = document.getElementById('upload3');
       const upload4 = document.getElementById('upload4');
   
       if (fileNumber == 1) {
           const selectedImg = upload1.files[0];
           if (selectedImg) {
               upload2.removeAttribute('disabled');
               upload2.style.display = 'block';
           } else {
               upload2.setAttribute('disabled', 'disabled');
               upload2.style.display = 'none';
                 upload2.value = '';
                 upload3.setAttribute('disabled', 'disabled');
               upload3.style.display = 'none';
               upload3.value = '';
               upload4.setAttribute('disabled', 'disabled');
               upload4.style.display = 'none';
               upload4.value = '';
           }
       }
       
       if (fileNumber == 2) {
           const selectedImg = upload2.files[0];
           if (selectedImg) {
               upload3.removeAttribute('disabled');
               upload3.style.display = 'block';
           } else {
               upload3.setAttribute('disabled', 'disabled');
               upload3.style.display = 'none';
               upload3.value = '';
               upload4.setAttribute('disabled', 'disabled');
               upload4.style.display = 'none';
               upload4.value = '';
           }
       }
       
       if (fileNumber == 3) {
           const selectedImg = upload3.files[0];
           if (selectedImg) {
               upload4.removeAttribute('disabled');
               upload4.style.display = 'block';
           } else {
               upload4.setAttribute('disabled', 'disabled');
               upload4.style.display = 'none';
               upload4.value = '';
           }
       }
       
   }

$(function(){
   //태그할 상품 저장
   let item_list = [];
   let item_nameList = [];

   //상품 검색
   $('#item_search').keyup(function(){
      if($('#item_search').val().trim()==''){
         $('#search_area').empty();
         return;
      }
      //서버와 통신
      $.ajax({
         url:'itemSearchAjax.do',
         type:'post',
         data:{item_name:$('#item_search').val()},
         dataType:'json',
         success:function(param){
            if(param.result == 'success'){
               $('#search_area').empty();
               $(param.item_tag).each(function(index,item){
                  if(!item_list.includes(item.item_name)){
                     let output = '';
                     output += '<li data-num="' + item.item_num + '">';
                     output += '<img src="../style/viewPhotoByItem_num.do?item_num=' + item.item_num + '" width="30" height="30">';
                     output += item.item_name;
                     output += '</li>';
                     $('#search_area').append(output);
                  }
               });
            }else{
               alert('상품 검색 중 오류가 발생했습니다.');
            }
         },
         error:function(){
            alert('네트워크 오류 발생');
         }
      });
   });
  
   //검색된 상품 선택
   $(document).on('click', '#search_area li', function(){
      let item_name = $(this).text(); //선택한 상품 저장
      let item_num = $(this).attr('data-num'); //선택한 상품번호
      if(item_list.length <= 2) {
		  item_list.push(item_name);
	  }else{
			alert('3개까지 추가 가능');
			$('#item_search').val('');
			$('#search_area').empty();
			return;
	  }
      if(item_nameList.length <= 2) {
		  item_nameList.push(item_num);
	  }
      //선택한 상품을 화면에 표시
      let choice_item = '<div class="item-span" data-name=' + item_name + '">';
      choice_item += '<img src="../style/viewPhotoByItem_num.do?item_num=' + item_num + '" width="40" height="40" data-num="' + item_num + '">';
	  choice_item += '<span>' + item_name + '</span><br></div>';
   
      $('#item_tag').append(choice_item);
      $('#item_search').val('');
      $('#search_area').empty(); //ul태그 초기화
   });
   
   //선택한 상품 삭제하기
   $(document).on('click', '.item-span', function(){
      let item_name = $(this).attr('data-name');
      let item_num = $(this).find('img').attr('data-num');
      item_list.splice(item_list.indexOf(item_name), 1);
      item_nameList.splice(item_nameList.indexOf(item_num), 1);
      $(this).remove();//이벤트가 발생한 태그 제거
      $('.item-span').val('');
      if($('#item_tag span').length == 0){
         $('.item-span').empty();
      }
   });
   
   //올리기 버튼 클릭시 상품 태그 등록
   $(document).on('click', '.submit-style', function(){
	    if(item_nameList.length > 0){
		   for(let i=0;i<item_nameList.length;i++){
			   $('#item_num' + (i+1)).val(item_nameList[i]);
		   }
	    }
   });
   
   //수정버튼
   $(document).on('click', '.modify-style', function(){
	   if(item_nameList.length == 1){
		   if($('#item_num1').val() == '0'){
			   $('#item_num1').val(item_nameList[0]);
		   }else if($('#item_num2').val() == '0'){
			   $('#item_num2').val(item_nameList[0]);
		   }else{
			   $('#item_num3').val(item_nameList[0]);
		   }
	   }
	   
	   if(item_nameList.length == 2){
		   if($('#item_num1').val() == '0' && $('#item_num2').val() == '0'){
			   $('#item_num1').val(item_nameList[0]);
			   $('#item_num2').val(item_nameList[1]);
		   }
		   if($('#item_num2').val() == '0' && $('#item_num3').val() == '0'){
			   $('#item_num2').val(item_nameList[0]);
			   $('#item_num3').val(item_nameList[1]);
		   }
		   if($('#item_num1').val() == '0' && $('#item_num3').val() == '0'){
			   $('#item_num1').val(item_nameList[0]);
			   $('#item_num3').val(item_nameList[1]);
		   }
	   }
	   
	   if(item_nameList.length == 3){
		   for(let i=0;i<item_nameList.length;i++){
			   $('#item_num' + (i+1)).val(item_nameList[i]);
		   }
	    }
   });

   $(document).on('click', '#del1', function(){
	   if($('#item_num1').val() != '0'){
		   $('#box1').remove();
	   	   $('#item_num1').val('0');
	   	   return;
	   }
   });
   
   $(document).on('click', '#del2', function(){
	   if($('#item_num2').val() != '0'){
		   $('#box2').remove();
	   	   $('#item_num2').val('0');
	   	   return;
	   }
   });
   
   $(document).on('click', '#del3', function(){
	   if($('#item_num3').val() != '0'){
	   	   $('#box3').remove();
	       $('#item_num3').val('0');
	       return;
	   }
   });

});