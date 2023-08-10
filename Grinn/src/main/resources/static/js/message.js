$(function(){
	let message_socket;//웹소켓 식별자
	let member_list = []; //채팅 회원 저장
	
	//채팅방 멤버를 저장하는 배열에 회원을 저장
	if($('#user').length>0){//채팅방 생성
		member_list = [$('#user').attr('data-id')];
	}else if($('#chat_member').length>0){//채팅
		member_list = $('#chat_member').text().split(',');
	}
	
	/*--------------------
	 *    웹소켓 연결
     *--------------------*/
	function alarm_connect(){
		message_socket = new WebSocket("ws://211.63.89.70:8000/message-ws.do");
		message_socket.onopen=function(evt){
			//채팅 페이지에 진입하면 채팅 메시지 발송
			if($('#talkDetail').length==1){
				message_socket.send("msg:");
			}
			console.log('채팅페이지 접속');
		};
		//서버로부터 메시지를 받으면 호출되는 함수 지정
		message_socket.onmessage=function(evt){
			let data = evt.data;
			if($('#talkDetail').length == 1 &&
			    data.substring(0,4) == 'msg:'){
				selectMsg();
			}
		};
		message_socket.onclose=function(evt){
			//소켓이 종료된 후 부가적인 작업이 있을 경우 명시
			console.log('채팅 종료');
		};
		
	}
	alarm_connect();
	
	/*--------------------
	 *    채팅방 생성하기
     *--------------------*/
	//회원 정보 검색
	$('#member_search').keyup(function(){
		if($('#member_search').val().trim()==''){
			$('#search_area').empty();
			return;
		}
		//서버와 통신
		$.ajax({
			url:'memberSearchAjax.do',
			type:'post',
			data:{mem_id:$('#member_search').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					$('#member_search').attr('disabled',true);
					$('#member_search').val('로그인해야 회원 검색이 가능합니다.');
				}else if(param.result == 'success'){
					$('#search_area').empty();
					$(param.member).each(function(index,item){
						if(!member_list.includes(item.mem_id)){
							let output = '';
							output += '<li data-num="'+item.mem_num+'">';
							output += item.mem_id;
							output += '</li>';
							$('#search_area').append(output);
						}	
					});
				}else{
					alert('회원 검색 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	//검색된 회원 선택하기
	$(document).on('click','#search_area li',function(){
		let mem_id = $(this).text(); //선택한 아이디
		let mem_num = $(this).attr('data-num'); //선택한 회원번호
		member_list.push(mem_id);
		//선택한 id를 화면에 표시
		let choice_id = '<span class="member-span" data-id="'+mem_id+'">';
		choice_id += '<input type="hidden" name="members" value="'+mem_num+'">';
		choice_id += mem_id + '<sup>&times;</sup></span>';
		$('#talk_member').append(choice_id);
		$('#member_search').val('');
		$('#search_area').empty(); //ul 태그 초기화
		
		if($('#name_checked').is(':checked')){//채팅방 이름 자동 설정
			makeRoom_name();
		}
	});
	
	//선택한 채팅방 멤버 삭제하기
	$(document).on('click','.member-span',function(){
		let mem_id = $(this).attr('data-id');
		//채팅 멤버가 저장된 배열에서 삭제할 멤버의 mem_id 제거
		member_list.splice(member_list.indexOf(mem_id),1);
		$(this).remove();//이벤트가 발생한 태그 제거
		
		if($('#name_checked').is(':checked')){
			makeRoom_name();
		}
		
		if($('#talk_member span').length == 0){
			$('#name_span').text('');
			$('#basic_name').val('');
		}
		
	});
	
	//채팅방 이름 생성 방식 정하기(자동/수동)
	$('#name_checked').click(function(){
		if($('#name_checked').is(':checked')){//채팅방 이름 자동 생성
			$('#basic_name').attr('type','hidden');
			if(member_list.length>1){
				makeRoom_name();
			}
		}else{//채팅방 이름 수동 생성
			$('#basic_name').attr('type','text');
			$('#name_span').text('');//채팅방 이름 표시 텍스트 초기화
		}
	});
		
	//채팅방 이름 생성
	function makeRoom_name(){
		let name = '';
		$.each(member_list,function(index,item){
			if(index>0) name += ',';
			name += item;
		});
		if(name.length>55){
			name = name.substring(0,55) + '...';
		}
		$('#basic_name').val(name);
		$('#name_span').text(name);
	}
	
	//채팅방 생성을 위한 데이터 전송
	$('#talk_form').submit(function(){
		//이미 배열에 현재 로그인한 유저가 기본 등록되어 있어서
		//로그인한 유저 포함 최소 2명이 되어야 채팅 가능
		if(member_list.length<=1){
			alert('채팅에 참여할 회원을 검색하세요!');
			$('#member_search').focus();
			return false;
		}
	});
	
	/*--------------------
	 *    채팅하기
     *--------------------*/
	//채팅 데이터 읽기
	function selectMsg(){
		//서버와 통신
		$.ajax({
			url:'../talk/talkDetailAjax.do',
			type:'post',
			data:{talkroom_num:$('#talkroom_num').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
					message_socket.close();
				}else if(param.result == 'success'){
					//메시지 표시 UI 초기화
					$('#chatting_message').empty();
					
					let chat_date='';
					$(param.list).each(function(index,item){
						let output = '';
						//날짜 추출
						if(chat_date != item.chat_date.split(' ')[0]){
							chat_date = item.chat_date.split(' ')[0];
							output += '<div class="date-position"><span>'+chat_date+'</span></div>';
						}
						
						if(item.message.indexOf('@{member}@')>=0){//멤버등록/탈퇴 메시지 처리
							//신규, 탈퇴 회원 메시지
							output += '<div class="member-message">';
							output += item.message.substring(0,item.message.indexOf('@{member}@'));
							output += '</div>';
						}else{
							//멤버등록/탈퇴 메시지가 아닌 일반 메시지
							if(item.mem_num == param.user_num){
								output += '<div class="from-position">'+item.mem_id;
								output += '<div>'
							}else{
								output += '<div class="to-position">';
								output += '<div class="space-photo">';
								output += '<img src="../member/viewProfile.do?mem_num='+item.mem_num+'" width="40" height="40" class="my-photo">';
								output += '</div><div class="space-message">';
								output += item.mem_id;
							}
							output += '<div class="item">';
							output += item.read_count + ' <span>'+item.message.replace(/\r\n/g,'<br>').replace(/\r/g,'<br>').replace(/\n/g,'<br>')+'</span>';
							//시간 추출
							output += '<div class="align-right">'+item.chat_date.split(' ')[1]+'</div>';
							output += '</div>';
							output += '</div><div class="space-clear"></div>';
							output += '</div>';
							
						}
						
						//문서 객체에 추가
						$('#chatting_message').append(output);
						//스크롤을 하단에 위치시킴
						$('#chatting_message').scrollTop($('#chatting_message')[0].scrollHeight);
						
					});
					
				}else{
					alert('채팅 메시지 읽기 오류 발생');
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				message_socket.close();
			}
		});
	}
	//메시지 입력 후 enter 이벤트 처리
	$('#message').keydown(function(event){
		if(event.keyCode == 13 && !event.shiftKey){
			$('#detail_form').trigger('submit');
		}
	});
	//채팅 등록
	$('#detail_form').submit(function(event){
		if($('#message').val().trim()==''){
			alert('메시지를 입력하세요!');
			$('#message').val('').focus();
			return false;
		}
		if($('#message').val().length>1333){
			alert('메시지를 1333자까지만 입력 가능합니다.');
			return false;
		}
		
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'../talk/writeTalk.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
					message_socket.close();
				}else if(param.result == 'success'){
					//폼 초기화
					$('#message').val('').focus();
					//메시지가 저장되었다고 소켓에 신호를 보냄
					message_socket.send('msg:');
				}else{
					alert('채팅 등록 오류 발생');
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				message_socket.close();
			}
		});
		//기본이벤트 제거
		event.preventDefault();
	});
	
	/*--------------------
	 *    채팅방 이름 변경하기
     *--------------------*/
     //채팅방 이름 변경 UI 표시
	$('#change_name').click(function(){
		$(this).hide();
		let output = '';
		output += '<div id="space_name">';
		output += '<input type="text" name="room_name" id="room_name">';
		output += ' <input type="button" value="전송" id="submit_name">';
		output += ' <input type="button" value="취소" id="result_name">';
		output += '</div>';
		
		$('#chatroom_title').append(output);
	});
	//채팅방 이름 변경 UI 숨기기
	$(document).on('click','#result_name',function(){
		initForm();
	});
	
	function initForm(){
		$('#change_name').show();
		$('#space_name').remove();
	}
	
	//채팅방 이름 변경
	$(document).on('click','#submit_name',function(){
		//서버와 통신
		$.ajax({
			url:'../talk/changeName.do',
			type:'post',
			data:{talkroom_num:$('#talkroom_num').val(),room_name:$('#room_name').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					$('#chatroom_name').text($('#room_name').val());
					//폼 초기화
					initForm();
				}else{
					alert('채팅방 이름 변경 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	/*--------------------
	 *    채팅방 멤버 추가하기
     *--------------------*/
    //채팅방 멤버 추가 UI 호출 
	$('#opener').click(function(){
		$('#dialog').dialog('open');
		//초기화
		member_list = $('#chat_member').text().split(',');
		$('#member_search').val('');
		$('#search_area').empty();
		$('#talk_member').empty();
		
		$(".fixed").css({
		    "position":"static"
	  	});
	  	$("#main_body").css({
		  "padding": "0 0 30px 0"
	  	});
	});
	//채팅방 추가 멤버 정보 전송
	$('#new_form').submit(function(event){
		if($('input[name="members"]').length==0){
			alert('추가할 회원을 선택하세요!');
			$('#member_search').val('').focus();
			return false;
		}
		
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'../talk/newMemberAjax.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 사용할 수 있습니다.');
					message_socket.close();
				}else if(param.result == 'success'){
					$('#dialog').dialog('close');//다이얼로그 닫기
					$('#chat_member').text(member_list);//채팅멤버 표시
					$('#chat_mcount').text('('+member_list.length+'명)');//인원수 표시
					alert('정상적으로 회원을 추가했습니다.');
					//메시지가 저장되었다고 소켓에 신호를 보냄
					message_socket.send('msg:');
				}else{
					alert('채팅 멤버 추가 오류 발생');
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생!');
				message_socket.close();
			}
		});
		//기본 이벤트 제거
		event.preventDefault();		
	});
	
	/*--------------------
	 *    채팅방 나가기
     *--------------------*/
	$('#delete_talkroom').click(function(){
		let choice = confirm('채팅방을 나가길 원하시나요?');
		if(!choice){
			return;
		}
		
		//서버와 통신
		$.ajax({
			url:'../talk/deleteTalkRoomMemberAjax.do',
			type:'post',
			data:{talkroom_num:$('#talkroom_num').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 사용할 수 있습니다.');
					message_socket.close();
				}else if(param.result == 'success'){
					alert('정상적으로 채팅방을 나갔습니다.');
					//메시지가 저장되었다고 소켓에 신호를 보냄
					message_socket.send('msg:');
					location.href='../talk/talkList.do';
				}else{
					alert('채팅방 나가기 처리 오류 발생');
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				message_socket.close();
			}
		});
		
	});
	
});








