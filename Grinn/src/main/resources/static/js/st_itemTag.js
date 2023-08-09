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
   let item_num1;
   let item_num2;
   let item_num3;
   let item_photo1name;
   
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
                     item_photo1name = item.item_photo1name;
                     let output = '';
                     output += '<li data-num="' + item.item_num + '">';
                     output += '<img src="../' + item.item_photo1name + '">';
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
      item_list.push(item_name);
      item_nameList.push(item_num);
      //선택한 상품을 화면에 표시
      let choice_item = '<span class="item-span" data-name=' + item_name + '>';
      choice_item += '<img src="../' + item_photo1name + '">';
      choice_item += '<input type="hidden" name="items" value="' + item_num + '">';
      if(item_list[0] != null){
         item_num1 = item_nameList[0];
         choice_item += '<input type="hidden" name="item_num1" value="' + item_num1 + '">';
      }
      if(item_list[1] != null){
         item_num2 = item_nameList[1];
         choice_item += '<input type="hidden" name="item_num2" value="' + item_num2 + '">';
      }
      if(item_list[2] != null){
         item_num3 = item_nameList[2];
         choice_item += '<input type="hidden" name="item_num3" value="' + item_num3 + '">';
      }
      choice_item += item_name + '<sup>&times;</sup></span>';
      $('#item_tag').append(choice_item);
      $('#item_search').val('');
      $('#search_area').empty(); //ul태그 초기화
   });
   
   //선택한 상품 삭제하기
   $(document).on('click', '.item-span', function(){
      let item_name = $(this).attr('data-name');
      //채팅 멤버가 배열에서 삭제할 멤버의 ID 제거
      item_list.splice(item_list.indexOf(item_name), 1);
      $(this).remove();//이벤트가 발생한 태그 제거
      $('.item-span').val('');
      if($('#item_tag span').length == 0){
         $('.item-span').empty();
      }
   });
   
});